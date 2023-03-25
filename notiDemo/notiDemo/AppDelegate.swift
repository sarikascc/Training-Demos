//
//  AppDelegate.swift
//  notiDemo
//
//  Created by Sarika scc on 01/09/22.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _  in
                
                if granted {
                    
                    print("Granted")
                }
            }
        return true
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
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler:
                                @escaping () -> Void) {
        
       // Get the meeting ID from the original notification.
       let userInfo = response.notification.request.content.userInfo
       let meetingID = userInfo["MEETING_ID"] as! String
       let userID = userInfo["USER_ID"] as! String
            
       // Perform the task associated with the action.
       switch response.actionIdentifier {
       case "ACCEPT_ACTION":
          print("Accept")
          break
            
       case "DECLINE_ACTION":
           print("Decline")
          break
            
       // Handle other actions…
     
       default:
          break
       }
        
       // Always call the completion handler when done.
       completionHandler()
    }


}

