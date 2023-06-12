//
//  ForgotPasswordController.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 12/06/23.
//

import UIKit

class ForgotPasswordController: UIViewController {
    
    //MARK - Properties
    private let forgotPasswordVM = ForgotPasswordVM()
    private let utilities = Utilities()
    private var handlPopupMsg: String?
    
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = UIImage(imageLiteralResourceName: "GameSphereLogo")
        
        return view
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(imageLiteralResourceName: "ic_mail_outline_white_2x-1")
        let view = utilities.inputContainerView(withImage: image, textField: forgotPasswordVM.emailTextField)
        
        return view
    }()
    
    private lazy var recoveryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Recovery", for: .normal)
        button.setTitleColor(.gameSpherePurple, for: .normal)
        button.backgroundColor = .gameSphereWhite
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleRecovery), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var dontNeedMoreButton: UIButton = {
        let button = utilities.attributedButton("Still need this? ", "If not, click to go back.")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        return button
    }()
    
    //MARK - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK - Selectors
    @objc private func handleRecovery() {
        LoadingIndicator.showLoadingIndicator(in: self.view)
        
        forgotPasswordVM.sendPasswordReset { (error) in
            if let error = error as? ForgotPasswordError {
                self.utilities.showPopUpMessage(title: "Error", message: error.errorMessage, viewController: self)
            } else if let error = error {
                self.utilities.showPopUpMessage(title: "Error", message: "\(error.localizedDescription)", viewController: self)
            } else {
                self.handlPopupMsg = "Please verify your email to complete the password reset."
                self.handleShowLogin()
            }
            
            LoadingIndicator.hideLoadingIndicator()            
        }
    }
    
    @objc private func handleShowLogin() {
        navigationController?.popViewController(animated: true)
        
        guard let targetViewController = navigationController?.topViewController else {
            return
        }

        if let msg = self.handlPopupMsg, !msg.isEmpty {
            self.utilities.showPopUpMessage(title: "Success", message: msg, viewController: targetViewController)
        }
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
            recoveryButton
        ])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(view.snp.left).offset(32)
            make.right.equalTo(view.snp.right).offset(-32)
        }
        
        view.addSubview(dontNeedMoreButton)
        dontNeedMoreButton.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.right.equalTo(view.snp.right).offset(-40)
        }
    }
}

