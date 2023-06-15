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
    private let loginVM = LoginViewModel()
    private let utilities = Utilities()
    
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = UIImage(imageLiteralResourceName: "GameSphereLogo")
        
        return view
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(imageLiteralResourceName: "ic_mail_outline_white_2x-1")
        let view = utilities.inputContainerView(withImage: image, textField: loginVM.emailTextField)
        
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(imageLiteralResourceName: "ic_lock_outline_white_2x")
        let view = utilities.inputContainerView(withImage: image, textField: loginVM.passwordTextField)
        
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.gameSpherePurple, for: .normal)
        button.backgroundColor = .gameSphereWhite
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        let button = utilities.attributedButton("Don't have an account?", " Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = utilities.attributedButton("Forgot your password?", "")
        button.addTarget(self, action: #selector(handleShowForgotPassword), for: .touchUpInside)
        
        return button
    }()
    
    //MARK - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK - Selectors
    @objc private func handleLogin() {
        LoadingIndicator.showLoadingIndicator(in: self.view)
        
        do {
            try loginVM.logUserIn(completion: { (result, error) in
                if let error = error as? LoginError {
                    self.utilities.showPopUpMessage(title: "Error", message: error.errorMessage, viewController: self)
                } else if let error = error {
                    self.utilities.showPopUpMessage(title: "Error", message: "\(error.localizedDescription)", viewController: self)
                } else if let user = result?.user {
                    if user.isEmailVerified {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                              let window = windowScene.windows.first(where: { $0.isKeyWindow }),
                              let tab = window.rootViewController as? MainTabController else {
                            return
                        }
                        
                        tab.authenticateUserAndConfigureUI()
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        self.utilities.showPopUpMessage(title: "Error", message: "Please check your email to log in.", viewController: self)
                    }
                }
                
                LoadingIndicator.hideLoadingIndicator()
            })
        } catch let error as LoginError {
            self.utilities.showPopUpMessage(title: "Error", message: "\(error.errorMessage)", viewController: self)
            LoadingIndicator.hideLoadingIndicator()
        } catch {
            self.utilities.showPopUpMessage(title: "Error", message: "\(error.localizedDescription)", viewController: self)
            LoadingIndicator.hideLoadingIndicator()
        }
    }
    
    @objc private func handleShowSignUp() {
        loginVM.goToRegistration(actualNavController: navigationController!)
    }
    
    @objc private func handleShowForgotPassword() {     
        loginVM.goToForgotPassword(actualNavController: navigationController!)
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
        
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(2)
            make.right.equalTo(loginButton.snp.right)
        }

        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.right.equalTo(view.snp.right).offset(-40)
        }
    }
}
