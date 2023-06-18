//
//  RegistrationViewModel.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 28/05/23.
//

import UIKit
import Firebase
import FirebaseStorage

class RegistrationViewModel: User {
    
    var emailTextField = Utilities().inputTextField(placeHolderText: "Email")
    var passwordTextField = Utilities().inputTextField(placeHolderText: "Password", isSecureField: true)
    var fullnameTextField = Utilities().inputTextField(placeHolderText: "Full Name")
    var usernameTextField = Utilities().inputTextField(placeHolderText: "Username")
          
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

        self.email = email
        self.password = password
        self.fullName = fullName
        self.userName = userName
    }
    
    func checkUsernameAvailability(username: String, completion: @escaping (Bool, Error?) -> Void) {
        let usernameRef = REF_USERS.queryOrdered(byChild: "userName").queryEqual(toValue: username)
        
        usernameRef.observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                completion(false, nil)
            } else {
                completion(true, nil)
            }
        } withCancel: { error in
            completion(false, error)
        }
    }
    
    func registerUser(completion: @escaping (AuthDataResult?, Error?) -> Void) throws {
        do {
            try verifyAndSetProps()
            
            checkUsernameAvailability(username: self.userName!) { isAvailable, error in
                if let error = error {
                    completion(nil, error)
                } else if !isAvailable {
                    completion(nil, RegistrationError.usernameAlreadyExists)
                } else {
                    Auth.auth().createUser(withEmail: self.email!, password: self.password!) { (result, error) in
                        if let error = error {
                            completion(nil, error)
                            return
                        }
                                             
                        guard let userId = result?.user.uid else { return }
                        self.userId = userId
                        
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
        guard let imageData = self.profileImage?.jpegData(compressionQuality: 0.3) else {return}
        let fileName = NSUUID().uuidString
        
        let storageRef = STORAGE_PROFILE_IMAGES.child(fileName)
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { (url, error) in
                guard let profileImageURL = url?.absoluteString else { return }
                
                self.profileImageUrl = profileImageURL
                self.insertUser()
            }
        }
    }
    
    func insertUser() {                
        // updateChildValues needs to be a Dictionary
        let userDictionary: [String: Any] = [
            "email": self.email!,
            "fullName": self.fullName!,
            "userName": self.userName!,
            "profileImageUrl": self.profileImageUrl!
        ]
        
        REF_USERS.child(self.userId!).updateChildValues(userDictionary) { erro, ref in
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
