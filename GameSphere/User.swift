//
//  UserAuth.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 27/05/23.
//

import UIKit

protocol UserRegistration {
    var emailTextField: UITextField { get set }
    var passwordTextField: UITextField { get set }
    var fullnameTextField: UITextField { get set }
    var usernameTextField: UITextField { get set }
    var profileImageReg: UIImage { get set }
    
    func registerUser()
    func insertUser()
    func sendVerUser()
}

struct User {
    var userId: String
    let email: String
    let password: String
    let fullName: String
    let userName: String
    let profileImage: UIImage
}

