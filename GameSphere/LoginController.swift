//
//  LoginController.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 23/05/23.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK - Properties
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = UIImage(imageLiteralResourceName: "GameSphereLogo")
        
        return view
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
    
    private let emailTextField = Utilities().inputTextField(placeHolderText: "Email")
    private let passwordTextField = Utilities().inputTextField(placeHolderText: "Password", isSecureField: true)
    
    private lazy var loginButtom: UIButton = {
        let buttom = UIButton(type: .system)
        buttom.setTitle("Log In", for: .normal)
        buttom.setTitleColor(.gameSpherePurple, for: .normal)
        buttom.backgroundColor = .white
        buttom.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttom.layer.cornerRadius = 5
        buttom.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        buttom.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        return buttom
    }()
    
    private lazy var dontHaveAccountButtom: UIButton = {
        let buttom = Utilities().attributedButton("Don't have an account?", " Sign Up")
        buttom.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return buttom
    }()
        
    //MARK - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK - Selectors
    @objc private func handleLogin(){
        print("Implement login in model")
    }
    @objc private func handleShowSignUp(){
        print("Implement Sign up in model")
    }
    
    //MARK - Helpers
    private func configureUI(){
        view.backgroundColor = .gameSpherePurple
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [
            emailContainerView,
            passwordContainerView,
            loginButtom
        ])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButtom)
        dontHaveAccountButtom.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 40,
            paddingRight: 40
        )
    }
    
}
