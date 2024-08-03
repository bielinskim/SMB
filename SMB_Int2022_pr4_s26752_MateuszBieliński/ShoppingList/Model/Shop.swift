//
//  Shop.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 21/12/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Shop: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var latitude: Double
    var longitude: Double
    var radius: Double
    var description: String
}
