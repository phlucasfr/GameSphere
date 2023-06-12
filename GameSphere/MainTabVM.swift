//
//  MainTabViewModel.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 10/06/23.
//

import Firebase

class MainTabVM {
    
    func authenticateUser(completion: @escaping (Bool) -> Void) {
        if Auth.auth().currentUser == nil {
            completion(false)
        } else {
            print("DEBUG: User is logged in.")
            completion(true)
        }
    }

}

