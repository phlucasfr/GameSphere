//
//  ConversationController.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 10/06/23.
//

import UIKit

class ConversationController: UIViewController {
    // MARK - Properties
    
    // MARK - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK - Helpers
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Messages"
    }
}
