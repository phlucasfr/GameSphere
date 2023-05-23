//
//  Utilities.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 23/05/23.
//

import UIKit

class Utilities {
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        
        let view = UIView()
        let iv = UIImageView(image: image)
        view.addSubview(iv)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        iv.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            paddingLeft: 8,
            paddingBottom: 8
        )
        iv.setDimensions(
            width: 24,
            height: 24
        )
        
        view.addSubview(textField)
        textField.anchor(
            left: iv.rightAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 8,
            paddingBottom: 8
        )
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 8,
            height: 0.75
        )
        
        return view
    }
    
    func inputTextField(placeHolderText: String, isSecureField: Bool? = false) -> UITextField {
        let textField = UITextField()
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 16)
        textField.attributedPlaceholder = NSAttributedString(
            string: placeHolderText,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
        )
        
        if isSecureField! {
            textField.isSecureTextEntry = true
        }
        
        return textField
    }
    
    func attributedButton(_ firstPart: String, _ secondPart:String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributtedTitle = NSMutableAttributedString(
            string: firstPart,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
        )
        attributtedTitle.append(
            NSMutableAttributedString(
                string: secondPart,
                attributes: [
                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                    NSAttributedString.Key.foregroundColor: UIColor.white
                ]
            )
        )
        
        button.setAttributedTitle(attributtedTitle, for: .normal)
        
        return button
    }
}
