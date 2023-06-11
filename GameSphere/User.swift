//
//  UserAuth.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 27/05/23.
//

import UIKit

struct User {
    var userId: String
    var email: String
    var password: String
    var fullName: String
    var userName: String
    var profileImageUrl: String
    var emailVerified: Bool
}

protocol UserLogin {
    var email: String { get set }
    var password: String { get set }
}

protocol UserRegistration {    
    var userReg: User { get set }
}




