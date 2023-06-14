//
//  FeedController.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 09/06/23.
//

import UIKit
import SDWebImage

class FeedController: UIViewController {
    // MARK - Properties
    var user: UserProfile? {
        didSet{
            configureLeftBarButtom()
        }
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
        imageView.setDimensions(width: 44, height: 44)
        navigationItem.titleView = imageView
    }
    
    func configureLeftBarButtom(){
        guard let user = self.user else { return }
        
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .gameSpherePurple
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true         
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}
