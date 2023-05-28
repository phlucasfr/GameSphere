//
//  UserAuth.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 27/05/23.
//

import UIKit
import Firebase

class UserAuth {
    
    func userRegister(email:String, password:String){
        
        Auth.auth().createUser(withEmail: email, password: password){(result,error) in
            if let error = error {
                print("Debug: Error is \(error.localizedDescription)")
            }
            
            print("Debug: Successfully registered user.")
            if let user = Auth.auth().currentUser {
                user.sendEmailVerification { error in
                    if let error = error {
                        print("Error sending verification email:\(error.localizedDescription)")
                    } else {
                        print("Verification email sent to \(user.email ?? "")")
                    }
                }
            }
        }
    }
    
}
