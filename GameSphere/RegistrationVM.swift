//
//  RegistrationViewModel.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 28/05/23.
//

import UIKit
import Firebase
import FirebaseStorage

class RegistrationVM: UserRegistration {
    
    var emailTextField = Utilities().inputTextField(placeHolderText: "Email")
    var passwordTextField = Utilities().inputTextField(placeHolderText: "Password", isSecureField: true)
    var fullnameTextField = Utilities().inputTextField(placeHolderText: "Full Name")
    var usernameTextField = Utilities().inputTextField(placeHolderText: "Username")
    var profileImageReg = UIImage()
    
    internal lazy var userReg = User(
        userId: "",
        email: "",
        password: "",
        fullName: "",
        userName: "",
        profileImageUrl: ""
    )
    
    var result: AuthDataResult?
      
    private func verifyAndSetProps() throws {
        guard let email = emailTextField.text, !email.isEmpty else {
            throw RegistrationError.missingEmail
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            throw RegistrationError.missingPassword
        }
        guard let fullName = fullnameTextField.text, !fullName.isEmpty else {
            throw RegistrationError.missingFullName
        }
        guard let userName = usernameTextField.text, !userName.isEmpty else {
            throw RegistrationError.missingUsername
        }

        userReg.email = email
        userReg.password = password
        userReg.fullName = fullName
        userReg.userName = userName
    }
    
    func checkUsernameAvailability(username: String, completion: @escaping (Bool, Error?) -> Void) {
        let usernameRef = REF_USERS.queryOrdered(byChild: "userName").queryEqual(toValue: username)
        
        usernameRef.observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                // O nome de usuário já está em uso
                completion(false, nil)
            } else {
                // O nome de usuário está disponível
                completion(true, nil)
            }
        } withCancel: { error in
            // Ocorreu um erro ao executar a consulta
            completion(false, error)
        }
    }
    
    func registerUser(completion: @escaping (AuthDataResult?, Error?) -> Void) throws {
        do {
            try verifyAndSetProps()
            
            checkUsernameAvailability(username: userReg.userName) { isAvailable, error in
                if let error = error {
                    completion(nil, error)
                } else if !isAvailable {
                    completion(nil, RegistrationError.usernameAlreadyExists)
                } else {
                    Auth.auth().createUser(withEmail: self.userReg.email, password: self.userReg.password) { (result, error) in
                        if let error = error {
                            completion(nil, error)
                            return
                        }
                        
                        self.result = result
                        self.profileImageToUrl()
                                               
                        completion(result, nil)
                    }
                }
            }
            
        } catch let error as RegistrationError {
            completion(nil, error)
        } catch {
            completion(nil, error)
        }        
    }
        
    func profileImageToUrl() {
        guard let imageData = self.profileImageReg.jpegData(compressionQuality: 0.3) else {return}
        let fileName = NSUUID().uuidString
        
        let storageRef = STORAGE_PROFILE_IMAGES.child(fileName)
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { (url, error) in
                guard let profileImageURL = url?.absoluteString else { return }
                
                self.userReg.profileImageUrl = profileImageURL
                self.insertUser()
            }
        }
    }
    
    func insertUser() {
        guard let userId = self.result?.user.uid else { return }
        userReg.userId = userId
        
        // updateChildValues needs to be a Dictionary
        let userDictionary: [String: Any] = [
            "email": userReg.email,
            "fullName": userReg.fullName,
            "userName": userReg.userName,
            "profileImageUrl": userReg.profileImageUrl
        ]
        
        REF_USERS.child(userReg.userId).updateChildValues(userDictionary) { erro, ref in
            print("Success update user")
            self.sendVerUser()
        }
    }
    
    func sendVerUser() {
        guard let user = Auth.auth().currentUser else {return}
        
        user.sendEmailVerification { error in
            if let error = error {
                print("DEBUG: Error sending verification email: \(error.localizedDescription)")
            }
        }
    }
    
}

enum RegistrationError: Error {
    case missingEmail
    case missingPassword
    case missingFullName
    case missingUsername
    case usernameAlreadyExists
    
    var errorMessage: String {
        switch self {
        case .missingEmail:
            return "Please enter your email."
        case .missingPassword:
            return "Please enter your password."
        case .missingFullName:
            return "Please enter your full name."
        case .missingUsername:
            return "Please enter your username."
        case .usernameAlreadyExists:
            return "Username already exists. Please choose a different username."
        }
    }
}
