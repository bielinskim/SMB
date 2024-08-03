//
//  Location.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 21/12/2022.
//

import Foundation
import CoreLocation
import MapKit

class UserLocation: NSObject, ObservableObject, CLLocationManagerDelegate  {
    static let shared = UserLocation()
    
    private let locationManager = CLLocationManager()
    @Published var userRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinate = locations.last!.coordinate
        
        userRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
    }
    
    func getCurrentLocation() -> CLLocationCoordinate2D {
        return locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0);
    }
    
    func startMonitoringRegion(name: String, latitude: Double, longitude: Double, radius: Double, identifier: String) {
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = CLCircularRegion(center: center, radius: radius, identifier: identifier)
        
        region.notifyOnEntry = true
        region.notifyOnExit = true
        
        locationManager.startMonitoring(for: region)
        
        print("Start monitoring for \(identifier) ")
    }
    
    func stopMonitoringRegion(identifier: String) {
        for region in locationManager.monitoredRegions {
            if(region.identifier == identifier) {
                locationManager.stopMonitoring(for: region)
                
                print("Stop monitoring for \(identifier) ")
            }
        }
    }
    
    func resetMonitoring() {
        for region in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: region)
            
            print("Stop monitoring for \(region.identifier) ")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        ShopDataManager.shared.getShopWithCallback(id: region.identifier, callback: Notification.shared.sendEnterShopNotification)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        ShopDataManager.shared.getShopWithCallback(id: region.identifier, callback: Notification.shared.sendLeaveShopNotification)
    }
    
}
