//
//  ExploreController.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 09/06/23.
//

import UIKit

class ExploreController: UIViewController {
    // MARK - Properties
    
    // MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Explore"

    }
}
