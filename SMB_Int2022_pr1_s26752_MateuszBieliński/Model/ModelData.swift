/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Storage for model data.
*/

import Foundation
import CoreData
import SwiftUI

var productsSample: [ProductSample] = load("shoppingListData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}


class ModelData: ObservableObject {
    @Published var products: [Product] = []
    
    init(context: NSManagedObjectContext) {
        fetchProducts(context: context)
    }
    
    func fetchProducts(context: NSManagedObjectContext)
    {
        do
        {
            products = try context.fetch(Product.fetchRequest())
        }
        catch let error
        {
            fatalError("Unresolved error \(error)")
        }
    }
    
    func saveContext(context: NSManagedObjectContext) {
        do {
            try context.save()
            fetchProducts(context: context)
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
