//
//  Product.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 06/12/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Product: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var price: Double
    var amount: Int
    var isBought: Bool
}
