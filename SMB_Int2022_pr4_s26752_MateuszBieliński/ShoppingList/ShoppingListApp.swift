//
//  ShoppingListApp.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 07/11/2022.
//

import SwiftUI
import Firebase
import MapKit

@main
struct ShoppingListApp: App {
    @StateObject var authService = AuthService.shared
    
    init() {
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func logout() {
        AuthService.shared.logout()
    }
    
    var body: some Scene {
        WindowGroup {
            let preferences = Preferences()
            
            NavigationView {
                VStack {
                    if(authService.user != nil) {
                        Text("Zalogowany jako \(authService.user!.email!)")
                        
                        NavigationLink {
                            ShoppingList()
                                .environmentObject(preferences)
                        } label: {
                            Text("Lista zakupów")
                            
                        }
                        .padding(10)
                        
                        NavigationLink {
                            PreferencesForm(listColor: preferences.listColor, listFontSize: preferences.listFontSize)
                                .environmentObject(preferences)
                        } label: {
                            Text("Ustawienia")
                            
                        }
                        .padding(10)
                        
                        NavigationLink {
                            FavoriteShopList()
                        } label: {
                            Text("Lista sklepów")
                        }
                        .padding(10)
                        
                        NavigationLink {
                            ShopMap()
                        } label: {
                            Text("Mapa sklepów")
                        }
                        .padding(10)
                        
                        Button("Wyloguj się") {
                            logout()
                        }
                    } else {
                        NavigationLink {
                            Login()
                        } label: {
                            Text("Logowanie")
                        }
                        .padding(10)
                        
                        NavigationLink {
                            Register()
                        } label: {
                            Text("Rejestracja")
                        }
                    }
                    
                }
                .padding(.vertical, 10)
                .navigationBarTitle("Menu")
            }
        }
    }
    
}
