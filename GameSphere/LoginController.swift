//
//  LoginController.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 23/05/23.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK - Properties
        
    //MARK - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK - Selectors

    //MARK - Helpers
    private func configureUI(){
        view.backgroundColor = .systemBlue
    }
    
}
