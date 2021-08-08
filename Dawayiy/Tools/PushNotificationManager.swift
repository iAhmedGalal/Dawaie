//
//  PushNotificationManager.swift
//  harajKamel
//
//  Created by AL Badr  on 10/31/19.
//  Copyright © 2019 ALBadr. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Firebase
import FirebaseFirestore
import FirebaseMessaging
import UserNotifications

class PushNotificationManager: NSObject, MessagingDelegate, UNUserNotificationCenterDelegate {
    let userID: String
    var window: UIWindow?
    
    init(userID: String) {
        self.userID = userID
        super.init()
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM)
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        UIApplication.shared.registerForRemoteNotifications()
        updateFirestorePushTokenIfNeeded()
    }
    
    func updateFirestorePushTokenIfNeeded() {
        if let token = Messaging.messaging().fcmToken {
            let usersRef = Firestore.firestore().collection("users_table").document(userID)
            usersRef.setData(["fcmToken": token], merge: true)
            print("fcmToken", token)
            Helper.saveUserDefault(key: Constants.userDefault.player_id, value: token)
            
        }
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("remoteMessage", remoteMessage.appData)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        updateFirestorePushTokenIfNeeded()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let dict = response.notification.request.content.userInfo as! [String: Any]
        
        let json = JSON(dict)
        print("Message userInfo", json)
        
        let type = json["type"].stringValue
        let message_id = json["message_id"].intValue
        let adv_id = json["adv_id"].intValue
        let follower_id = json["follower_id"].intValue
        let voter_id = json["advertiser_id"].intValue
        
        self.window = UIWindow(frame: UIScreen.main.bounds)

        switch (type) {
        case "1", "5":
            if let controller = UIStoryboard(name: Constants.storyBoard.user, bundle: nil).instantiateViewController(withIdentifier: "ChatNC") as? UINavigationController,
                let vc = controller.viewControllers.first as? ChatVC {
                vc.title = "الرسائل"
                vc.message_id = message_id
                vc.fromRemoteNotifications = true
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
            }
        case "2", "3", "4", "10", "11":
            if let controller = UIStoryboard(name: Constants.storyBoard.main, bundle: nil).instantiateViewController(withIdentifier: "detailsNV") as? UINavigationController,
                let vc = controller.viewControllers.first as? AdvDetailsVC {
                vc.title = "تفاصيل الإعلان"
                vc.advId = adv_id
                vc.fromRemoteNotifications = true
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
            }
        case "6":
            if let controller = UIStoryboard(name: Constants.storyBoard.user, bundle: nil).instantiateViewController(withIdentifier: "userNV") as? UINavigationController,
                let vc = controller.viewControllers.first as? AdvertiserProfileVC {
                vc.title = "صفحة المعلن"
                vc.advertiser_id = follower_id
                vc.fromRemoteNotifications = true
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
            }
        case "7":
            if let controller = UIStoryboard(name: Constants.storyBoard.user, bundle: nil).instantiateViewController(withIdentifier: "userNV") as? UINavigationController,
                let vc = controller.viewControllers.first as? AdvertiserProfileVC {
                vc.title = "صفحة المعلن"
                vc.advertiser_id = voter_id
                vc.fromRemoteNotifications = true
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
            }
        default:
            print("default")
            let main = UIStoryboard(name: Constants.storyBoard.main, bundle: nil)
            let mainvc = main.instantiateViewController(withIdentifier: "mainNC")
            self.window?.rootViewController = mainvc
            self.window?.makeKeyAndVisible()
        }
        
        Messaging.messaging().appDidReceiveMessage(dict)
        
        completionHandler()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        completionHandler(.newData)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print full message.
        print("Message", userInfo)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        
        
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([.alert, .badge, .sound])
    }
}
