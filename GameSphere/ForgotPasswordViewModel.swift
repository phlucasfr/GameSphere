//
//  ForgotPasswordVM.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 12/06/23.
//

import Firebase

class ForgotPasswordViewModel: ForgotPassword {
    let emailTextField = Utilities().inputTextField(placeHolderText: "Email")
    var email = ""
    
    private func verifyAndSetProps() throws {
        guard let email = emailTextField.text, !email.isEmpty else {
            throw ForgotPasswordError.missingEmail
        }
        
        self.email = email
    }
    
    func sendPasswordReset(completion: @escaping (Error?) -> Void) {
        do {
            try verifyAndSetProps()
            
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
            }
        } catch let error as ForgotPasswordError {
            completion(error)
        } catch {
            completion(error)
        }
    }
}

enum ForgotPasswordError: Error {
    case missingEmail
    
    var errorMessage: String {
        switch self {
        case .missingEmail:
            return "Please enter your email."
        }
    }
}

