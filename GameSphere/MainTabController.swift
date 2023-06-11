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
    private let mainTabviewModel = MainTabViewModel()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .gameSphereWhite
        button.backgroundColor = .gameSpherePurple
        button.setImage(UIImage(named: "new_post"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK - API
    func authenticateUserAndConfigureUI(){
        mainTabviewModel.authenticateUser { [weak self] isAuthenticated in
            if isAuthenticated {
                self?.configureViewControllers()
                self?.configureUI()
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
        print("Hello button!")
    }
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gameSpherePurple
        
        logUserOut()
        authenticateUserAndConfigureUI()
    }
    
    // MARK - Helpers
    func configureUI(){
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
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
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
        
        return nav
    }
    
}
