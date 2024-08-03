//
//  ShopForm.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 21/12/2022.
//

import SwiftUI

struct ShopForm: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @State var validation: String
    
    @State var name: String
    @State var radius: Double
    @State var description: String
    
    init() {
        _validation = State(initialValue: "")
        
        _name = State(initialValue: "")
        _radius = State(initialValue: 100)
        _description = State(initialValue: "")
        
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
                    Text("Promień")
                        .foregroundColor(.gray)
                    TextField("Promień", value: $radius, format: .number)
                }
                
                VStack {
                    Text("Opis")
                        .foregroundColor(.gray)
                        
                    TextField("Opis", text: $description)
                }
                
            }
            .background(Color.white)
            
            Button("Zapisz") {
                saveShop()
            }
            .padding(10)
        }
        .padding(.vertical, 10)
        .navigationBarTitle("Dodaj")
    }
    
    private func validate() -> Bool {
        if(self.name.isEmpty) {
            self.validation = "Uzupełnij nazwę"
            return false;
        }
        
        return true;
    }
    
    func saveShop() {
        withAnimation {
            if(validate()) {
                let currentLocation = UserLocation.shared.getCurrentLocation()
                
                let newShop = Shop(name: self.name, latitude: currentLocation.latitude, longitude: currentLocation.longitude, radius: self.radius, description: self.description)
                
                ShopDataManager.shared.addShop(shop: newShop)
                
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ShopForm_Previews: PreviewProvider {
    static var previews: some View {
        ShopForm()
    }
}
