//
//  RegistrationViewModel.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 28/05/23.
//

import UIKit
import Firebase

class RegistrationVM {
    
    let emailTextField = Utilities().inputTextField(placeHolderText: "Email")
    let passwordTextField = Utilities().inputTextField(placeHolderText: "Password", isSecureField: true)
    let fullnameTextField = Utilities().inputTextField(placeHolderText: "Full Name")
    let usernameTextField = Utilities().inputTextField(placeHolderText: "Username")
    
    func registerUser(input: User){
        
        Auth.auth().createUser(withEmail: input.email, password: input.password) { (result, error) in
            if let error = error {
                print("Debug: Error is \(error.localizedDescription)")
                return
            }
            
            print("Debug: Successfully registered user.")
            
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
}
