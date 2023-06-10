//
//  Utilities.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 23/05/23.
//

import UIKit
import SnapKit

class Utilities {
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        
        let iv = UIImageView(image: image)
        view.addSubview(iv)
        iv.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(8)
            make.bottom.equalTo(view.snp.bottom).offset(-8)
            make.width.height.equalTo(24)
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.left.equalTo(iv.snp.right).offset(8)
            make.bottom.equalTo(view.snp.bottom).offset(-8)
            make.right.equalTo(view.snp.right).offset(-8)
        }
        
        let dividerView = UIView()
        dividerView.backgroundColor = .gameSphereWhite
        view.addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(8)
            make.bottom.equalTo(view.snp.bottom)
            make.right.equalTo(view.snp.right).offset(-8)
            make.height.equalTo(0.75)
        }
        
        view.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        return view
    }
    
    func inputTextField(placeHolderText: String, isSecureField: Bool? = false) -> UITextField {
        let textField = UITextField()
        textField.textColor = .gameSphereWhite
        textField.font = .systemFont(ofSize: 16)
        textField.attributedPlaceholder = NSAttributedString(
            string: placeHolderText,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gameSphereWhite
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
                NSAttributedString.Key.foregroundColor: UIColor.gameSphereWhite
            ]
        )
        attributtedTitle.append(
            NSMutableAttributedString(
                string: secondPart,
                attributes: [
                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                    NSAttributedString.Key.foregroundColor: UIColor.gameSphereWhite
                ]
            )
        )
        
        button.setAttributedTitle(attributtedTitle, for: .normal)
        
        return button
    }
}
