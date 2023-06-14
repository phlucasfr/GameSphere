//
//  UserService.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 12/06/23.
//

import Firebase

struct UserProfile {
    var email: String
    var fullName: String
    var userName: String
    var profileImageUrl: URL?
    var uid: String
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.email = dictionary["email"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.userName = dictionary["userName"] as? String ?? ""
        
        if let profileImageString = dictionary["profileImageUrl"] as? String {
            guard let url = URL(string: profileImageString) else { return }
            self.profileImageUrl = url
        }
    }
}

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
