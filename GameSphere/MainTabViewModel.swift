//
//  MainTabViewModel.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 10/06/23.
//

import Firebase

protocol MainTabViewModelProtocol {
    var user: UserProfile? { get }
    
    func authenticateUser(completion: @escaping (Bool) -> Void)
    func fetchUser(completion: @escaping (UserProfile?) -> Void)
    func logUserOut()
}

class MainTabViewModel: MainTabViewModelProtocol {
    private let userService: UserService
    
    var user: UserProfile?
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func authenticateUser(completion: @escaping (Bool) -> Void) {
        if Auth.auth().currentUser == nil {
            completion(false)
        } else {
            print("DEBUG: User is logged in.")
            completion(true)
        }
    }
        
    func fetchUser(completion: @escaping (UserProfile?) -> Void) {
        userService.fetchUser { user in
            self.user = user
            completion(user)
        }
    }
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
            print("DEBUG: User logged out.")
        } catch let error {
            print("DEBUG: \(error.localizedDescription)")
        }
    }
}
