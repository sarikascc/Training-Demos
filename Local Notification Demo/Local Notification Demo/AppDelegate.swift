//
//  AppDelegate.swift
//  Local Notification Demo
//
//  Created by Sarika scc on 28/11/22.
//

import UIKit
import UserNotifications


@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self

        getRequestToAccessToShowNotification()
        return true
    }
    
    func getRequestToAccessToShowNotification(){
        
        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
               switch notificationSettings.authorizationStatus {
               case .notDetermined:
                   self.requestAuthorization(completionHandler: { (success) in
                                   guard success else { return }

                       self.scheduleLocalNotification()
                    })
               case .authorized:
                   self.scheduleLocalNotification()
               case .denied:
                   print("Application Not Allowed to Display Notifications")
               case .provisional:
                   break
               case .ephemeral:
                   break
               @unknown default:
                   break
               }
           }
    }
    
    func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
        // Request Authorization
        

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }

            completionHandler(success)
        }
        
        UIApplication.shared.registerForRemoteNotifications()
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
    //MARK: schedule notifications
    
    func scheduleLocalNotification() {
        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()
        
        // Configure Notification Content
        notificationContent.title = "Cocoacasts"
        notificationContent.subtitle = "Local Notifications"
        notificationContent.sound = UNNotificationSound.default
        notificationContent.body = "In this tutorial, you learn how to schedule local notifications with the User Notifications framework."
        
        // Add Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: "cocoacasts_local_notification", content: notificationContent, trigger: notificationTrigger)
        
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
            else{
                print("Created")
            }
        }
    }
    
    //MARK: use4rnotification delegate method
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.banner,.sound])
    }

}

