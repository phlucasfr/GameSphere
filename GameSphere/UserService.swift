//
//  UserService.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 12/06/23.
//

import Firebase

class UserService {
    static let shared = UserService()
    var userProfile: UserProfile?
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject],
                  let email = dictionary["email"] as? String,
                  let fullName = dictionary["fullName"] as? String,
                  let userName = dictionary["userName"] as? String,
                  let profileImageUrl = dictionary["profileImageUrl"] as? String
            else {
                return
            }
            
            let fetchedUserProfile = UserProfile(email: email, fullName: fullName, userName: userName, profileImageUrl: profileImageUrl)
            
            self.userProfile = fetchedUserProfile
            print("DEBUG: UserProfile name is: \(self.userProfile?.userName ?? "")")
        }
    }
}
