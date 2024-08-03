//
//  ShopDataManager.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 21/12/2022.
//

import Foundation
import Firebase

class ShopDataManager: ObservableObject {
    static let shared = ShopDataManager()
    
    private let store = Firestore.firestore()
    private var path: String = "shops"
    private var shopsListener: ListenerRegistration?
    
    @Published var shops: [Shop] = []
    
    func getPath() -> String {
        let userId = AuthService.shared.user?.uid
        
        return userId != nil ? "users/\(userId!)/shops" : "shops"
    }
    
    func resetShops(user: User?) {
        if(user != nil) {
            getShops()
        } else {
            shops = []
        }
    }
    
    func getShops() {
        if(shopsListener != nil) {
            shopsListener!.remove()
        }
        
        shopsListener = store.collection(getPath())
            .addSnapshotListener { querySnapshot, error in
                if(error != nil) {
                    print("Error while fetching shops", error!)
                } else {
                    UserLocation.shared.resetMonitoring()
                    
                    self.shops = querySnapshot?.documents.compactMap { document in
                        let shop = try? document.data(as: Shop.self)
                        
                        UserLocation.shared.startMonitoringRegion(name: shop!.name, latitude: shop!.latitude, longitude: shop!.longitude, radius: shop!.radius, identifier: shop!.id!)
                        
                        return shop
                    } ?? []
                }
            }
    }
    
    func getShopWithCallback(id: String, callback: @escaping (Shop) -> ()) {
        store.collection(getPath()).document(id).getDocument(as: Shop.self) { result in
            switch result {
            case .success(let shop):
                callback(shop)
            case .failure(let error):
                print("Error while getting shop", error)
            }
        }
    }
    
    func addShop(shop: Shop) {
        do {
            try store.collection(getPath()).addDocument(from: shop)
        } catch {
            print("Error while adding shop", error)
        }
    }
    
    func updateShop(shop: Shop) {
        do {
            try store.collection(getPath()).document(shop.id!).setData(from: shop)
        } catch {
            print("Error while updating shop", error)
        }
    }
    
    func deleteShop(shop: Shop) {
        store.collection(getPath()).document(shop.id!).delete { error in
            if(error != nil) {
                print("Error while updating shop", error!)
            }
        }
    }
}
