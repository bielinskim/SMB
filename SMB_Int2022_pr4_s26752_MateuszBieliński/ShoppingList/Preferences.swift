//
//  Preferences.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 11/11/2022.
//

import SwiftUI

class Preferences: ObservableObject {
    let defaults = UserDefaults.standard
    @Published var listColor: Color = Color.black
    @Published var listFontSize: Int = 18
    
    init() {
        loadPreferences()
    }
    
    func loadPreferences()
    {
        let colorArray = defaults.object(forKey: "LIST_COLOR") as? [CGFloat] ?? [250,250,250,250]
        self.listColor = Color(.sRGB,
                                     red: colorArray[0],
                                     green: colorArray[1],
                                     blue: colorArray[2],
                                     opacity:colorArray[3])
        
        self.listFontSize = defaults.integer(forKey: "LIST_FONT_SIZE")
    }
    
    func savePreferences(colorToSave: Color, sizeToSave: Int) {
        let color = colorToSave.cgColor
        
        if(color?.components != nil) {
            defaults.set(color?.components, forKey: "LIST_COLOR")
        }
        
        defaults.set(sizeToSave, forKey: "LIST_FONT_SIZE")
        
        loadPreferences()
    }
}
