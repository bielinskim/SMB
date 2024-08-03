//
//  Notification.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 22/12/2022.
//

import Foundation
import UserNotifications

class Notification: NSObject, UNUserNotificationCenterDelegate {
    static let shared = Notification()
    
    override init() {
        super.init()
        
        UNUserNotificationCenter.current().delegate = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }
    
    func sendEnterShopNotification(shop: Shop) {
        let title = "Sklep \(shop.name)"
        let subtitle = "Zapraszamy, promocja dnia..."
        
        sendNotification(title: title, subtitle: subtitle)
    }
    
    func sendLeaveShopNotification(shop: Shop)  {
        let title = "Sklep \(shop.name)"
        let subtitle = "Dziękujemy za wizytę"
        
        sendNotification(title: title, subtitle: subtitle)
    }
    
    func sendNotification(title: String, subtitle: String) {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = title
        notificationContent.subtitle = subtitle
        notificationContent.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "Location", content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
}
