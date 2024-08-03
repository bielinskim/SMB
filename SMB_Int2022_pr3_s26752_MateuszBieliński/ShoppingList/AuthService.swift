//
//  AuthService.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 10/12/2022.
//

import Foundation
import Firebase

class AuthService: ObservableObject {
    static let shared = AuthService()
    
    @Published var user: User?
    
    init() {
        addAuthListener()
    }
    
    func addAuthListener() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.user = user
            
            DataManager.shared.resetProducts(user: user)
        }
    }
    
    func register(email: String, password: String, callback: @escaping (AuthDataResult?, Error?)->()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if (error != nil) {
                print(error!.localizedDescription)
            }
            
            callback(result, error)
        }
    }
    
    func login(email: String, password: String, callback: @escaping (AuthDataResult?, Error?)->()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if (error != nil) {
                print(error!.localizedDescription)
            }
            
            callback(result, error)
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error while signing out", error)
        }
    }
}
