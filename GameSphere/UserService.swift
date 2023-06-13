//
//  UserService.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 12/06/23.
//

import Firebase

class UserService {
    static let shared = UserService()
    
    func fetchUser(completion: @escaping(UserProfile) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let fetchedUserProfile = UserProfile(uid: uid, dictionary: dictionary)            
            completion(fetchedUserProfile)
        }
    }
}
