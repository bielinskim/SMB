//
//  DataManager.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 04/12/2022.
//

import Foundation
import Firebase


class DataManager: ObservableObject {
    static let shared = DataManager()
    
    private let store = Firestore.firestore()
    private var path: String = "products"
    private var productsListener: ListenerRegistration?
    private var productsType: String = "common"
    
    @Published var products: [Product] = []
    
    func getPath(type: String = "common") -> String {
        if(type == "common") {
            return "products"
        } else {
            let userId = AuthService.shared.user?.uid
            
            return userId != nil ? "users/\(userId!)/products" : "products"
        }
    }
    
    func resetProducts(user: User?) {
        if(user != nil) {
            getProducts(type: "common")
        } else {
            products = []
        }
    }
    
    func getProducts(type: String = "common") {
        if(productsListener != nil) {
            productsListener!.remove()
        }
        
        productsListener = store.collection(getPath(type: type))
            .addSnapshotListener { querySnapshot, error in
                if(error != nil) {
                    print("Error while fetching products", error!)
                } else {
                    self.products = querySnapshot?.documents.compactMap { document in
                        let product = try? document.data(as: Product.self)
                        
                        return product
                    } ?? []
                }
            }
    }
    
    
    func addProduct(product: Product, type: String = "common") {
        do {
            try store.collection(getPath(type: type)).addDocument(from: product)
        } catch {
            print("Error while adding product", error)
        }
    }
    
    func updateProduct(product: Product, type: String = "common") {
        do {
            try store.collection(getPath(type: type)).document(product.id!).setData(from: product)
        } catch {
            print("Error while updating product", error)
        }
    }
    
    func deleteProduct(product: Product, type: String = "common") {
        store.collection(getPath(type: type)).document(product.id!).delete { error in
            if(error != nil) {
                print("Error while updating product", error!)
            }
        }
    }
    
}
