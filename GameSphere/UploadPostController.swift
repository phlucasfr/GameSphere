//
//  UploadPostController.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 14/06/23.
//

import UIKit

class UploadPostController: UIViewController {
    //MARK - Properties
    private let utilities = Utilities()
    
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
       
    //MARK - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
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
