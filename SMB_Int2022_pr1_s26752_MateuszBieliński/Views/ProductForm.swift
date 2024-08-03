//
//  ProductForm.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 07/11/2022.
//

import SwiftUI

struct ProductForm: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var modelData: ModelData
    
    var mode: String
    @State var validation: String
    
    var product: Product
    @State var name: String
    @State var price: Double
    @State var amount: Int
    @State var isBought: Bool
    

    init() {
        self.mode = "Add"
        _validation = State(initialValue: "")
        
        self.product = Product()
        _name = State(initialValue: "")
        _price = State(initialValue: 0.99)
        _amount = State(initialValue: 1)
        _isBought = State(initialValue: false)
    }
    
    init(product: Product) {
        self.mode = "Edit"
        _validation = State(initialValue: "")
        
        self.product = product
        _name = State(initialValue: product.name ?? "")
        _price = State(initialValue: product.price)
        _amount =  State(initialValue: Int(product.amount))
        _isBought = State(initialValue: product.isBought)
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
                    let newProduct = Product(context: viewContext)
                    newProduct.name = self.name
                    newProduct.price = self.price
                    newProduct.amount = Int16(self.amount)
                    newProduct.isBought = false
                }
                
                if(mode == "Edit") {
                    product.name = self.name
                    product.price = self.price
                    product.amount = Int16(self.amount)
                    product.isBought = self.isBought
                    
                }
                
                modelData.saveContext(context: viewContext)
            
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductForm_Previews: PreviewProvider {
    static var previews: some View {
        
        ProductForm(product: Product()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
