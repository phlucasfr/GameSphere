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
}

struct UserProfile {
    var email: String
    var fullName: String
    var userName: String
    var profileImageUrl: String
    var uid: String
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.email = dictionary["email"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.userName = dictionary["userName"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}

protocol UserLogin {
    var email: String { get set }
    var password: String { get set }
}

protocol UserRegistration {    
    var userReg: User { get set }
}

protocol ForgotPassword {
    var email: String { get set }
}




