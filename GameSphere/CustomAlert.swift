//
//  CustomAlert.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 17/06/23.
//

import UIKit

struct CustomAlert {
    
    static func handleCustomAlert(from viewController: UIViewController, title: String, placeholder: String, keyboardType: UIKeyboardType, autocorrectionType: UITextAutocorrectionType, completion: @escaping (String) -> Void) {
        let alertController: UIAlertController = {
            let controller = UIAlertController(
                title: title,
                message: nil,
                preferredStyle: .alert
            )
            controller.addTextField { textfield in
                textfield.placeholder = placeholder
                textfield.keyboardType = keyboardType
                textfield.autocorrectionType = autocorrectionType
            }
            
            let cancelAction = UIAlertAction(
                title: "Cancel",
                style: .cancel
            )
            
            let okAction = UIAlertAction(
                title: "OK",
                style: .default
            ) { _ in
                guard let text = controller.textFields?.first?.text else { return }
                completion(text)
            }
            
            [cancelAction, okAction].forEach(controller.addAction(_:))
            
            return controller
        }()
        
        viewController.present(alertController, animated: true)
    }

}
