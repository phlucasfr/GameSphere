//
//  LoginViewModel.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 28/05/23.
//

import UIKit
import Firebase

class LoginVM: UserLogin {
    
    let emailTextField = Utilities().inputTextField(placeHolderText: "Email")
    let passwordTextField = Utilities().inputTextField(placeHolderText: "Password", isSecureField: true)
    var email = ""
    var password = ""
        
    func goToRegistration(actualNavController: UINavigationController){
        let controller = RegistrationController()
        actualNavController.pushViewController(controller, animated: true)
    }
    
    private func verifyAndSetProps(){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        self.email = email
        self.password = password
    }
    
    func logUserIn(completion: ((AuthDataResult?, Error?) -> Void)?) {
        verifyAndSetProps()        
        Auth.auth().signIn(withEmail: self.email, password: self.password, completion: completion)
    }

}
