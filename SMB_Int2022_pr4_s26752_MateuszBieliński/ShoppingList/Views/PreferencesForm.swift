//
//  PreferencesForm.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 11/11/2022.
//

import SwiftUI

struct PreferencesForm: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var preferences: Preferences
    @State var listColor: Color
    @State var listFontSize: Int
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack {
            
            ColorPicker("Wybierz kolor listy", selection: $listColor)
            
            HStack {
                Text("Wpisz rozmiar czcionki listy")
                
                Spacer()
                
                TextField("Wpisz rozmiar", value: $listFontSize, format: .number)
            }
            
            Spacer()
            
            Button("Zapisz") {
                preferences.savePreferences(colorToSave: listColor, sizeToSave: listFontSize)
                
                presentationMode.wrappedValue.dismiss()
            }
            .padding(10)
        }
        .padding(10)
    }
        
}

struct PreferencesForm_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesForm(listColor: Color.black, listFontSize: 18)
    }
}

