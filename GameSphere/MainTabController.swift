//
//  MainTabController.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 09/06/23.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    // MARK - Properties    
    private let mainTabviewModel = MainTabVM()
    private let utilities = Utilities()
    
    private var user: UserProfile? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            
            feed.user = user
        }
    }
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .gameSphereWhite
        button.backgroundColor = .gameSpherePurple
        button.setImage(UIImage(named: "new_post"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK - API
    func fetchUser(){
        UserService.shared.fetchUser { user in
            self.user = user
        }
    }
    
    func authenticateUserAndConfigureUI(){
        mainTabviewModel.authenticateUser { [weak self] isAuthenticated in
            if isAuthenticated {
                self?.configureViewControllers()
                self?.configureUI()
                self?.fetchUser()
            } else {
                self?.showLoginScreen()
            }
        }
    }
    
    func logUserOut(){
        do {
            try Auth.auth().signOut()
            print("DEBUG: User logged out.")
        } catch let error {
            print("DEBUG: \(error.localizedDescription)")
        }
    }
    
    // MARK - Selector
    @objc func actionButtonTapped() {
        let nav = UINavigationController(rootViewController: UploadPostController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
       
    }
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //logUserOut()
        authenticateUserAndConfigureUI()
    }
    
    // MARK - Helpers
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-64)
            make.right.equalTo(view.snp.right).offset(-16)
            make.width.height.equalTo(56)
        }
        actionButton.layer.cornerRadius = 56 / 2
    }
    
    func showLoginScreen() {
        DispatchQueue.main.async { [weak self] in
            let loginController = LoginController()
            let nav = UINavigationController(rootViewController: loginController)
            nav.modalPresentationStyle = .fullScreen
            self?.present(nav, animated: true, completion: nil)
        }
    }
    
    func configureViewControllers(){
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gameSphereWhite
        
        //tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .gameSpherePurple
        
        let feed = FeedController()
        let nav1 = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: feed)
        
        let explore = ExploreController()
        let nav2 = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: explore)
        
        let notification = NotificationController()
        let nav3 = templateNavigationController(image: UIImage(named: "like_unselected"), rootViewController: notification)
        
        let conversation = ConversationController()
        let nav4 = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: conversation)
        
        viewControllers = [nav1, nav2, nav3, nav4]
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        
        let appearance = utilities.setWhiteNavBar()        
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
        
        return nav
    }
    
}
