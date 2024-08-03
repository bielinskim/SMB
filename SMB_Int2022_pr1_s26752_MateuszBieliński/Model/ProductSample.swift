//
//  ProductSample.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 07/11/2022.
//

import Foundation

import Foundation
import SwiftUI
import CoreLocation

struct ProductSample: Hashable, Codable {
    var name: String
    var price: Double
    var amount: Int
    var isBought: Bool
}
