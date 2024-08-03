//
//  ProductForm.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 07/11/2022.
//

import SwiftUI

struct ProductForm: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var mode: String
    @State var validation: String
    
    var product: Product?
    @State var name: String
    @State var price: Double
    @State var amount: Int
    @State var isBought: Bool
    var productType: String
    

    init(productType: String) {
        self.mode = "Add"
        _validation = State(initialValue: "")
        
        _name = State(initialValue: "")
        _price = State(initialValue: 0.99)
        _amount = State(initialValue: 1)
        _isBought = State(initialValue: false)
        
        self.productType = productType
    }
    
    init(product: Product, productType: String) {
        self.mode = "Edit"
        _validation = State(initialValue: "")
        
        self.product = product
        _name = State(initialValue: product.name ?? "")
        _price = State(initialValue: product.price)
        _amount =  State(initialValue: Int(product.amount))
        _isBought = State(initialValue: product.isBought)
        
        self.productType = productType
    }
    
    
    var body: some View {
        VStack {
            Text(validation)
                .foregroundColor(.red)
            
            
            Form {
                VStack {
                    Text("Nazwa")
                        .foregroundColor(.gray)
                        
                    TextField("Nazwa", text: $name)
                }
                    
                VStack {
                    Text("Cena")
                        .foregroundColor(.gray)
                    TextField("Cena", value: $price, format: .number)
                }
                    
                VStack {
                    Text("Ilość")
                        .foregroundColor(.gray)
                    TextField("Ilość", value: $amount, format: .number)
                }
                
            }
            .background(Color.white)
            
            Button("Zapisz") {
                saveProduct()
            }
            .padding(10)
        }
        .padding(.vertical, 10)
        .navigationBarTitle(mode == "Add" ? "Dodaj" : "Edytuj")
        
    }
    
    private func validate() -> Bool {
        if(self.name.isEmpty) {
            self.validation = "Uzupełnij nazwę"
            return false;
        }
        
        return true;
    }
    
    private func saveProduct() {
        withAnimation {
            if(validate()) {
                if(mode == "Add") {
                    let newProduct = Product(name: self.name, price: self.price, amount: self.amount, isBought: false)
                    
                    DataManager.shared.addProduct(product: newProduct, type: productType)
                }
                
                if(mode == "Edit") {
                    var updatedProduct = product!
                    
                    updatedProduct.name = self.name
                    updatedProduct.price = self.price
                    updatedProduct.amount = self.amount
                    updatedProduct.isBought = self.isBought
                    
                    DataManager.shared.updateProduct(product: updatedProduct, type: productType)
                }
            
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductForm_Previews: PreviewProvider {
    static var previews: some View {
        
        ProductForm(productType: "common")
    }
}
