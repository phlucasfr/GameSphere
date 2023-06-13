//
//  FeedController.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 09/06/23.
//

import UIKit

class FeedController: UIViewController {
    // MARK - Properties
    var user: UserProfile? {
        didSet{ print("Did set user in feed")}
    }
    
    // MARK - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "GameSphereLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .gameSpherePurple
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}
