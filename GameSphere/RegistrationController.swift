//
//  RegistrationController.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 24/05/23.
//

import UIKit

class RegistrationController: UIViewController {
    
    //MARK - Properties
    private let imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        return picker
    }()
    
    private lazy var plusPhotoButtom:UIButton = {
        let buttom = UIButton(type: .system)
        buttom.setImage(UIImage(named: "plus_photo"), for: .normal)
        buttom.tintColor = .white
        buttom.addTarget(self, action: #selector(handleAddPhotoProfile), for: .touchUpInside)
        return buttom
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(imageLiteralResourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
        
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(imageLiteralResourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
        
        return view
    }()
    private lazy var fullnameContainerView: UIView = {
        let image = UIImage(imageLiteralResourceName: "ic_person_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: fullnameTextField)
        
        return view
    }()
    
    private lazy var usernameContainerView: UIView = {
        let image = UIImage(imageLiteralResourceName: "ic_person_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: usernameTextField)
        
        return view
    }()
    
    private let emailTextField = Utilities().inputTextField(placeHolderText: "Email")
    private let passwordTextField = Utilities().inputTextField(placeHolderText: "Password")
    private let fullnameTextField = Utilities().inputTextField(placeHolderText: "Full Name")
    private let usernameTextField = Utilities().inputTextField(placeHolderText: "Username")
    
    private lazy var signUpButtom: UIButton = {
        let buttom = UIButton(type: .system)
        buttom.setTitle("Sign Up", for: .normal)
        buttom.setTitleColor(.gameSpherePurple, for: .normal)
        buttom.backgroundColor = .white
        buttom.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttom.layer.cornerRadius = 5
        buttom.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        buttom.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return buttom
    }()
    
    private lazy var alreadyHaveAccountButtom: UIButton = {
        let buttom = Utilities().attributedButton("Already have an account?", " Login")
        buttom.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        return buttom
    }()
    
    //MARK - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK - Selectors
    @objc private func handleShowLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleAddPhotoProfile(){
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func handleRegister(){
        print("Registred...")
    }
    
    //MARK - Helpers
    
    func configureUI(){
        view.backgroundColor = .gameSpherePurple
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(plusPhotoButtom)
        plusPhotoButtom.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButtom.setDimensions(width: 128, height: 128)
        
        let stack = UIStackView(arrangedSubviews: [
            emailContainerView,
            passwordContainerView,
            fullnameContainerView,
            usernameContainerView,
            signUpButtom
        ])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButtom.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButtom)
        alreadyHaveAccountButtom.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 40,
            paddingRight: 40
        )
    }
    
}

//MARK - UIImagePickerControllerDelegate
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {return}
        plusPhotoButtom.layer.cornerRadius = 128 / 2
        plusPhotoButtom.layer.masksToBounds = true
        plusPhotoButtom.imageView?.contentMode = .scaleAspectFill
        plusPhotoButtom.imageView?.clipsToBounds = true
        plusPhotoButtom.layer.borderColor = UIColor.white.cgColor
        plusPhotoButtom.layer.borderWidth = 3
        
        self.plusPhotoButtom.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
                                                        
    }
    
}
