//
//  FavoriteShopList.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 20/12/2022.
//

import SwiftUI

struct FavoriteShopList: View
{
    @StateObject var shopDataManager = ShopDataManager.shared
    
    var body: some View {
        
        VStack {
            ForEach(shopDataManager.shops) { shop in
                ShopRow(shop: shop)
                
                Divider()
            }
            
            Spacer()
            
            NavigationLink {
                ShopForm()
            } label: {
                Label("Dodaj", systemImage: "plus.app")
                    .foregroundColor(.green)
                    .padding(10)
                
            }
        }
    }
}


struct FavoriteShopList_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteShopList()
    }
}
