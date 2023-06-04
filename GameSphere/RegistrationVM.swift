//
//  RegistrationViewModel.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 28/05/23.
//

import UIKit
import Firebase

class RegistrationVM: UserRegistration {
    
    var emailTextField = Utilities().inputTextField(placeHolderText: "Email")
    var passwordTextField = Utilities().inputTextField(placeHolderText: "Password", isSecureField: true)
    var fullnameTextField = Utilities().inputTextField(placeHolderText: "Full Name")
    var usernameTextField = Utilities().inputTextField(placeHolderText: "Username")
    var profileImageReg = UIImage()
                
    private lazy var userReg = User(
        userId: "",
        email: emailTextField.text!,
        password: passwordTextField.text!,
        fullName: fullnameTextField.text!,
        userName: usernameTextField.text!,
        profileImage: profileImageReg
    )
    
    private var result: AuthDataResult?
    
    func registerUser(){
        
        Auth.auth().createUser(withEmail: userReg.email, password: userReg.password) { (result, error) in
            if let error = error {
                print("Debug: Error is \(error.localizedDescription)")
                return
            }
            self.result = result
            
            self.insertUser()
            self.sendVerUser()
            print("Debug: Successfully registered user.")
        }
    }
    
    internal func insertUser() {
        
        guard let userId = self.result?.user.uid else { return }
        userReg.userId = userId
        
        // updateChildValues needs to be a Dictionary
        let userDictionary: [String: Any] = [
            "email": userReg.email,
            "password": userReg.password,
            "fullName": userReg.fullName,
            "userName": userReg.userName
        ]
        
        let ref = Database.database().reference().child("users").child(userReg.userId)
        ref.updateChildValues(userDictionary) { erro, ref in
            print("Success update user")
        }
    }
    
    internal func sendVerUser() {
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