//
//  ShoppingListApp.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 07/11/2022.
//

import SwiftUI

@main
struct ShoppingListApp: App {
    let context = PersistenceController.shared.container.viewContext
    
    var body: some Scene {
        WindowGroup {
            
            let modelData = ModelData(context: context)
            let preferences = Preferences()
            
            
            NavigationView {
                VStack {
                    NavigationLink {
                        ShoppingList()
                            .environment(\.managedObjectContext, context)
                            .environmentObject(modelData)
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
                    
                }
                .padding(.vertical, 10)
                .navigationBarTitle("Menu")
                
            }
        }
    }

}
