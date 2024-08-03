//
//  ShoppingList.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 07/11/2022.
//

import SwiftUI

struct ShoppingList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var preferences: Preferences

    var body: some View {
            VStack {
                ForEach(modelData.products) { product in
                    ProductRow(product: product)
                        .environment(\.managedObjectContext, viewContext)
                        .environmentObject(modelData)
                        .environmentObject(preferences)

                    Divider()
                }

                Spacer()
            
                NavigationLink {
                    ProductForm()
                        .environment(\.managedObjectContext, viewContext)
                        .environmentObject(modelData)
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
        ShoppingList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
