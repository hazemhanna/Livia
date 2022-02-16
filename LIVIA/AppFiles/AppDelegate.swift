//
//  AppDelegate.swift
//  Shanab
//
//  Created by Macbook on 3/22/20.
//  Copyright © 2020 Dtag. All rights reserved.
//


import UIKit
import CoreData
import UserNotifications
import Firebase
import FirebaseMessaging
import IQKeyboardManagerSwift
import MOLH
import AlamofireNetworkActivityLogger
import Urway
import CoreLocation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MOLHResetable {
    static var type = String()
    static var body = String()
    
    static var item_id = Int()
    static var notification_flag = false
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    

    let token = Helper.getApiToken() ?? ""
    func reset() {
        let sb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar")
        UIApplication.shared.windows.first?.rootViewController = sb
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        MOLH.shared.activate(true)
        MOLH.shared.specialKeyWords = ["Cancel","Done"]
        MOLH.setLanguageTo("ar")
        MOLH.reset()
        UIView.appearance().semanticContentAttribute = .forceRightToLeft

        if ("lang".localized == "en") {
            MOLHLanguage.setDefaultLanguage("en")
        } else {
            MOLHLanguage.setDefaultLanguage("ar")
        }
  
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        Messaging.messaging().delegate = self

        UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 0.00800000038, green: 0.1019999981, blue: 0.2705882353, alpha: 1)
        
        if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self
          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        return true
    }


    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        print(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
        
    }
    
   func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    print("APNs token retrieved: \(deviceToken)")
    Messaging.messaging().apnsToken = deviceToken
    InstanceID.instanceID().instanceID { (result, error) in
        if let error = error {
            print("Error Fetching Remote Instance ID: \(error)")
        } else if let result = result {
            print("Remote Instance ID Token: \(result.token)")
            Helper.saveDeviceToken(token: result.token)
            if Helper.getApiToken() ?? "" != "" {
                    Services.postUserSetToken(type: "ios", device_token: Helper.getDeviceToken() ?? "") { (error: Error?, result: SuccessError_Model?) in
                        
                    }
                }
            }
            
        }
    }
}


//}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        completionHandler([.alert, .badge, .sound])

    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        let type = userInfo["type"] as? String ?? ""
        let item_id = userInfo["item_id"] as? String ?? ""
        let body = userInfo["body"] as? String ?? ""
        print(type)
        print(item_id)
        print(body)
        if let type = userInfo["type"] as? String, let body = userInfo["body"] as? String, let item_id = userInfo["item_id"] as? String {
            switch Singletone.instance.appUserType {
            case .Driver:
                switch type {
                case "newRequest":
                    let sb = UIStoryboard(name: "DeliveryMan", bundle: nil).instantiateViewController(withIdentifier: "ChartNav")
                    AppDelegate.item_id = Int(item_id) ?? 0
                    AppDelegate.notification_flag = true
                    window?.rootViewController = sb

                default:
                    break
                }
            case .Customer:
                switch type {
                case "newRequest":
                    let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "CustomerProfileNav")
                    AppDelegate.item_id = Int(item_id) ?? 0
                    AppDelegate.notification_flag = true
                    window?.rootViewController = sb
                case "order":
                    let sb = UIStoryboard(name: "OrderDetails", bundle: nil).instantiateViewController(withIdentifier: "OrderDetailsNav")
                    AppDelegate.item_id = Int(item_id) ?? 0
                    AppDelegate.notification_flag = true
                    window?.rootViewController = sb

                default:
                    break
                }
            default:
                break
            }



        }
        
        
        completionHandler()
    }
}

extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    }
 
}


extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


