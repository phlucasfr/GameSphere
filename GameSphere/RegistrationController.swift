//
//  RegistrationController.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 24/05/23.
//

import UIKit
import Firebase
import SnapKit

class RegistrationController: UIViewController {
    
    //MARK - Properties
    private let imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        return picker
    }()
    
    private let user = RegistrationVM()
    private let utilities = Utilities()
    private var profileImage: UIImage?
    private var handlPopupMsg: String?
    
    private lazy var plusPhotoButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .gameSphereWhite
        button.addTarget(self, action: #selector(handleAddPhotoProfile), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(imageLiteralResourceName: "ic_mail_outline_white_2x-1")
        let view = utilities.inputContainerView(withImage: image, textField: user.emailTextField)
        
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(imageLiteralResourceName: "ic_lock_outline_white_2x")
        let view = utilities.inputContainerView(withImage: image, textField: user.passwordTextField)
        
        return view
    }()
    private lazy var fullnameContainerView: UIView = {
        let image = UIImage(imageLiteralResourceName: "ic_person_outline_white_2x")
        let view = utilities.inputContainerView(withImage: image, textField: user.fullnameTextField)
        
        return view
    }()
    
    private lazy var usernameContainerView: UIView = {
        let image = UIImage(imageLiteralResourceName: "ic_person_outline_white_2x")
        let view = utilities.inputContainerView(withImage: image, textField: user.usernameTextField)
        
        return view
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.gameSpherePurple, for: .normal)
        button.backgroundColor = .gameSphereWhite
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = utilities.attributedButton("Already have an account?", " Login")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        return button
    }()
    
    //MARK - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK - Selectors
    @objc private func handleShowLogin() {
        navigationController?.popViewController(animated: true)

        guard let targetViewController = navigationController?.topViewController else {
            return
        }

        if let msg = self.handlPopupMsg, !msg.isEmpty {
            self.utilities.showPopUpMessage(title: "Success", message: msg, viewController: targetViewController)
        }
    }
      
    @objc private func handleAddPhotoProfile(){
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func handleRegister() {
        LoadingIndicator.showLoadingIndicator(in: self.view)
        
        let profileImage = self.profileImage
        if profileImage == nil {
            self.utilities.showPopUpMessage(title: "Error", message: "Please select a profile image", viewController: self)
            LoadingIndicator.hideLoadingIndicator()
            return
        }
        user.profileImageReg = profileImage!
        
        do {
            try user.registerUser { (result, error) in
                LoadingIndicator.hideLoadingIndicator()
                
                if let error = error {
                    if let registrationError = error as? RegistrationError {
                        // Handle specific RegistrationError
                        self.utilities.showPopUpMessage(title: "Error", message: registrationError.errorMessage, viewController: self)
                    } else {
                        // Handle other errors
                        self.utilities.showPopUpMessage(title: "Error", message: "\(error.localizedDescription)", viewController: self)
                    }
                    return
                } else if result != nil {
                    // Registration successful
                    self.handlPopupMsg = "Please verify your email to complete the registration."
                    self.handleShowLogin()
                }
            }
        } catch let error {
            // Handle any other errors
            LoadingIndicator.hideLoadingIndicator()
            self.utilities.showPopUpMessage(title: "Error", message: "\(error.localizedDescription)", viewController: self)
        }
    }
    
    //MARK - Helpers    
    func configureUI() {
        view.backgroundColor = .gameSpherePurple
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.height.equalTo(128)
        }
        
        let stack = UIStackView(arrangedSubviews: [
            emailContainerView,
            passwordContainerView,
            fullnameContainerView,
            usernameContainerView,
            signUpButton
        ])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(plusPhotoButton.snp.bottom).offset(32)
            make.left.equalTo(view.snp.left).offset(32)
            make.right.equalTo(view.snp.right).offset(-32)
        }
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.right.equalTo(view.snp.right).offset(-40)
        }
    }
}

//MARK - UIImagePickerControllerDelegate
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {return}
        self.profileImage = profileImage
        
        plusPhotoButton.layer.cornerRadius = 128 / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.gameSphereWhite.cgColor
        plusPhotoButton.layer.borderWidth = 3
        plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }    
}
