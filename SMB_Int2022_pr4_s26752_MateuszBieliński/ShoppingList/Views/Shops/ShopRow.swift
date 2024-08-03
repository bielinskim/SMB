//
//  ShopRow.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 21/12/2022.
//

import SwiftUI

struct ShopRow: View {
    var shop: Shop
    
    var body: some View {
        VStack {
            HStack {
                Text(shop.name)
                
                Button {
                    deleteShop(shopToDelete: shop)
                } label: {
                    Label("Delete shop", systemImage: "trash.fill")
                        .labelStyle(.iconOnly)
                        .foregroundColor(.red)
                }
            }
            
            HStack {
                Text("Promień \(String(shop.radius)) m")
            }
            
            HStack {
                Text("X \(String(shop.latitude)) ")
                Text("Y \(String(shop.longitude)) ")
            }
            
            HStack {
                Text(shop.description)
            }
        }
    }
    
    func deleteShop(shopToDelete: Shop) {
        withAnimation {
            ShopDataManager.shared.deleteShop(shop: shopToDelete)
        }
    }
}

struct ShopRow_Previews: PreviewProvider {
    static var previews: some View {
        ShopRow(shop: Shop(name: "Test1", latitude: 51.507222, longitude: -0.1275, radius: 100, description: "Desc1"))
    }
}
