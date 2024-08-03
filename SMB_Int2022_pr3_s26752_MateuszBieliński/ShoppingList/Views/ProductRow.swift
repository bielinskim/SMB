//
//  ProductRow.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 07/11/2022.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var preferences: Preferences
    
    var product: Product
    var productType: String
    
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
                ProductForm(product: product, productType: productType)
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
            var updatedProduct = productToToggle
            
            updatedProduct.isBought = !productToToggle.isBought
            
            DataManager.shared.updateProduct(product: updatedProduct, type: productType)
            
        }
    }
    
    func deleteProduct(productToDelete: Product) {
        withAnimation {
            DataManager.shared.deleteProduct(product: productToDelete, type: productType)
        }
    }
}



struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: Product(name: "Test", price: 1.99, amount: 3, isBought: false), productType: "common")

    }
}

