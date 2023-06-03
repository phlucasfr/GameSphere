//
//  LoginViewModel.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 28/05/23.
//

import UIKit

struct LoginVM {
    let emailTextField = Utilities().inputTextField(placeHolderText: "Email")
    let passwordTextField = Utilities().inputTextField(placeHolderText: "Password", isSecureField: true)
    
    func goToRegistration(actualNavController:UINavigationController){
        let controller = RegistrationController()
        actualNavController.pushViewController(controller, animated: true)
    }
}
