//
//  LoginController.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 23/05/23.
//

import UIKit
import SnapKit

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
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.gameSpherePurple, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account?", " Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
        
    //MARK - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK - Selectors
    @objc private func handleLogin() {
        print("Implement login in model")
    }
    
    @objc private func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK - Helpers
    private func configureUI() {
        view.backgroundColor = .gameSpherePurple
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.height.equalTo(150)
        }
        
        let stack = UIStackView(arrangedSubviews: [
            emailContainerView,
            passwordContainerView,
            loginButton
        ])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(32)
            make.right.equalTo(view.snp.right).offset(-32)
        }
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.right.equalTo(view.snp.right).offset(-40)
        }
    }    
}
