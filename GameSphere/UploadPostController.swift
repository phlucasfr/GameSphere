//
//  UploadPostController.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 14/06/23.
//

import UIKit
import SDWebImage
import SnapKit

class UploadPostController: UIViewController {
    
    //MARK - Properties
    private let utilities = Utilities()
    private let user: UserProfile
    private let captionTextView = CaptionTextView()
    
    private lazy var actionButtom: UIButton = {
        let buttom = UIButton(type: .system)
        buttom.backgroundColor = .gameSpherePurple
        buttom.setTitle("Post", for: .normal)
        buttom.titleLabel?.textAlignment = .center
        buttom.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        buttom.setTitleColor(.white, for: .normal)
        
        buttom.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        buttom.layer.cornerRadius = 32 / 2
        
        buttom.addTarget(self, action: #selector(handleUploadPost), for: .touchUpInside)
        
        return buttom
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.setDimensions(width: 48, height: 48)
        imageView.layer.cornerRadius = 48 / 2
        
        return imageView
    }()
      
    //MARK - LifeCycle
    init(user: UserProfile) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        print("DEBUG: User is \(user)")
    }
    
    //MARK - Selectors
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)        
    }
    
    @objc func handleUploadPost() {
        print("Upload post here")
    }
    
    //MARK - API
    
    //MARK - Helpers
    func configureUI(){
        view.backgroundColor = .white
        configureNavigationBar()
        
        let stack = UIStackView(arrangedSubviews: [
            profileImageView,
            captionTextView
        ])
        stack.axis = .horizontal
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.rightMargin)
        }
        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)        
    }
    
    func configureNavigationBar(){
        navigationController?.navigationBar.tintColor = .gameSpherePurple
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(handleCancel)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButtom)
        
        let appearance = utilities.setWhiteNavBar()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
}
