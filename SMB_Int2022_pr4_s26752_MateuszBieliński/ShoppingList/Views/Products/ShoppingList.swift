//
//  ShoppingList.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 07/11/2022.
//

import SwiftUI

struct ShoppingList: View {
    @StateObject var dataManager = DataManager.shared
    @EnvironmentObject var preferences: Preferences
    @StateObject var authService = AuthService.shared
    @State var productsType = "common"
    
    var body: some View {
        HStack {
            Button("Wspólna") {
                productsType = "common"
                DataManager.shared.getProducts(type: productsType)
            }
            .foregroundColor(productsType == "common" ? .black : .gray)
            
            Button("Użytkownika") {
                productsType = "user"
                DataManager.shared.getProducts(type: productsType)
            }
            .foregroundColor(productsType == "user" ? .black : .gray)
        }
        
        
        VStack {
            ForEach(dataManager.products) { product in
                ProductRow(product: product, productType: productsType)
                    .environmentObject(preferences)
                
                Divider()
            }
            
            Spacer()
            
            NavigationLink {
                ProductForm(productType: productsType)
            } label: {
                Label("Dodaj", systemImage: "plus.app")
                    .foregroundColor(.green)
                    .padding(10)
                
            }
            
        }
        .padding(.vertical, 10)
        .navigationBarTitle("Lista zakupów")
        
    }
    
}

struct ShoppingList_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingList()
    }
}
