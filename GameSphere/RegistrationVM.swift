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
    
    private var result: AuthDataResult?
    
    private func verifyAndSetProps() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullName = fullnameTextField.text else { return }
        guard let userName = usernameTextField.text else { return }
        
        userReg.email = email
        userReg.password = password
        userReg.fullName = fullName
        userReg.userName = userName
    }
    
    func registerUser() -> Bool {
        
        var isCreated: Bool = false
        verifyAndSetProps()
        
        Auth.auth().createUser(withEmail: userReg.email, password: userReg.password) { (result, error) in
            if let error = error {
                print("Debug: Error is \(error.localizedDescription)")
                return
            }
            self.result = result
            self.profileImageToUrl()
            print("Debug: Successfully registered user.")
            isCreated = true
        }
        
        return isCreated
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
            "password": userReg.password,
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
                print("Error sending verification email: \(error.localizedDescription)")
            } else {
                if let email = user.email {
                    print("Verification email sent to \(email)")
                } else {
                    print("Verification email sent.")
                }
            }
        }
    }
    
}
