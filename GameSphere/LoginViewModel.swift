//
//  LoginViewModel.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 28/05/23.
//

import UIKit
import Firebase

class LoginViewModel {
    
    let emailTextField = Utilities().inputTextField(placeHolderText: "Email")
    let passwordTextField = Utilities().inputTextField(placeHolderText: "Password", isSecureField: true)
    var email = ""
    var password = ""
    
    func goToRegistration(actualNavController: UINavigationController){
        let controller = RegistrationController()
        actualNavController.pushViewController(controller, animated: true)
    }
    
    func goToForgotPassword(actualNavController: UINavigationController){
        let controller = ForgotPasswordController()
        actualNavController.pushViewController(controller, animated: true)
    }
    
    private func verifyAndSetProps() throws {
        guard let email = emailTextField.text, !email.isEmpty else {
            throw LoginError.missingEmail
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            throw LoginError.missingPassword
        }
        
        self.email = email
        self.password = password
    }
    
    func logUserIn(completion: ((AuthDataResult?, Error?) -> Void)?) throws {
        try verifyAndSetProps()
        Auth.auth().signIn(withEmail: self.email, password: self.password, completion: completion)
    }
}

enum LoginError: Error {
    case missingEmail
    case missingPassword
    
    var errorMessage: String {
        switch self {
        case .missingEmail:
            return "Please enter your email."
        case .missingPassword:
            return "Please enter your password."
        }
    }
}
