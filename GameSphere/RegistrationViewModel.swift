//
//  RegistrationViewModel.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 28/05/23.
//

import UIKit

class RegistrationViewModel: UserAuth {
               
    func registerUser(email: String?, password: String?) {
        guard let email = email, let password = password else {
            //Maybe some validation for the password or email is needed here.
            return
        }
        
        userRegister(email: email, password: password)
    }
}
