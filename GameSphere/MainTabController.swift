//
//  MainTabController.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 09/06/23.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    private var mainTabViewModel: MainTabViewModelProtocol!
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
    
    // MARK: - Lifecycle
    init(viewModel: MainTabViewModelProtocol) {
        self.mainTabViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        authenticateUserAndConfigureUI()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-64)
            make.right.equalTo(view.snp.right).offset(-16)
            make.width.height.equalTo(56)
        }
        actionButton.layer.cornerRadius = 56 / 2
    }
    
    private func showLoginScreen() {
        DispatchQueue.main.async { [weak self] in
            let loginController = LoginController()
            let nav = UINavigationController(rootViewController: loginController)
            nav.modalPresentationStyle = .fullScreen
            self?.present(nav, animated: true, completion: nil)
        }
    }
    
    // MARK: - Authentication
    func authenticateUserAndConfigureUI() {
        mainTabViewModel.authenticateUser { [weak self] isAuthenticated in
            if isAuthenticated {
                self?.configureViewControllers()
                self?.configureUI()
                self?.fetchUser()
            } else {
                self?.showLoginScreen()
            }
        }
    }
    
    private func fetchUser() {
        mainTabViewModel.fetchUser { [weak self] user in
            self?.user = user
        }
    }
    
    private func logUserOut() {
        mainTabViewModel.logUserOut()
    }
    
    // MARK: - Selector
    @objc private func actionButtonTapped() {
        let nav = UINavigationController(rootViewController: UploadPostController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    // MARK: - Helpers    
    private func configureViewControllers() {
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
    
    private func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        
        let appearance = utilities.setWhiteNavBar()
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
        
        return nav
    }
}
