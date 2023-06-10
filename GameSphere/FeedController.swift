//
//  FeedController.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 09/06/23.
//

import UIKit

class FeedController: UIViewController {
    // MARK - Properties
    
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
    }
}
