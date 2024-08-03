//
//  ProductRow.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 07/11/2022.
//

import SwiftUI

struct ProductRow: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var preferences: Preferences
    
    var product: Product
    
    var body: some View {
        HStack {
            Button {
                toggleBought(productToToggle: product)
            } label: {
                Label("Toggle bought", systemImage: product.isBought ? "circle.fill" : "circle")
                    .labelStyle(.iconOnly)
                    .foregroundColor(product.isBought ? .green : .gray)
            }
            
            Group {
                Text(product.name ?? "")
                Text("\(String(product.amount)) szt.")
                Text("\(String(product.price)) zł")
            }
            .foregroundColor(preferences.listColor)
            .font(.system(size: CGFloat(preferences.listFontSize)))


            Spacer()
            
            
            NavigationLink {
                ProductForm(product: product)
                    .environment(\.managedObjectContext, viewContext)
                    .environmentObject(modelData)
            } label: {
                Label("Toggle Favorite", systemImage: "square.and.pencil")
                    .labelStyle(.iconOnly)
                    .foregroundColor(.blue)
            }
            
            Spacer()
                .frame(width: 10)
            
            Button {
                deleteProduct(productToDelete: product)
            } label: {
                Label("Delete product", systemImage: "trash.fill")
                    .labelStyle(.iconOnly)
                    .foregroundColor(.red)
            }
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 10)
    }
    
    func toggleBought(productToToggle: Product) {
        withAnimation {
            productToToggle.isBought = !productToToggle.isBought

            modelData.saveContext(context: viewContext)
        }
    }
    
    func deleteProduct(productToDelete: Product) {
        withAnimation {
            viewContext.delete(productToDelete)

            modelData.saveContext(context: viewContext)
        }
    }
}



struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
            ProductRow(product: Product()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

    }
}

