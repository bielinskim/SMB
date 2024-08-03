//
//  ShopMap.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 20/12/2022.
//

import SwiftUI
import MapKit

struct ShopMap: View {
    @StateObject var userLocation = UserLocation.shared
    
    
    @StateObject var shopDataManager = ShopDataManager.shared
    @ObservedObject private var location = UserLocation()
    
    var body: some View {
        
        
        Map(coordinateRegion: $userLocation.userRegion,
            showsUserLocation: true,
            annotationItems: shopDataManager.shops) {
            MapPin(coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude), tint: Color.purple)
        }
        .ignoresSafeArea()
    }
    
}

struct ShopMap_Previews: PreviewProvider {
    static var previews: some View {
        ShopMap()
    }
}
