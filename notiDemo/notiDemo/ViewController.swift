//
//  ViewController.swift
//  notiDemo
//
//  Created by Sarika scc on 01/09/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sendNotidfication()
        sendNoti2dfication()
    }

    
    func sendNotidfication(){
        
        let acceptAction = UNNotificationAction(identifier: "ACCEPT_ACTION",
                                                title: "Accept",
                                                options: [])
        let declineAction = UNNotificationAction(identifier: "DECLINE_ACTION",
                                                 title: "Decline",
                                                 options: [])
        // Define the notification type
        let meetingInviteCategory =
        UNNotificationCategory(identifier: "MEETING_INVITATION",
                               actions: [acceptAction, declineAction],
                               intentIdentifiers: [],
                               hiddenPreviewsBodyPlaceholder: "",
                               options: .customDismissAction)
        // Register the notification type.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.setNotificationCategories([meetingInviteCategory])
        
        let content = UNMutableNotificationContent()
        content.title = "Weekly Staff Meeting"
        content.body = "Every Tuesday at 2pm"
        content.userInfo = ["MEETING_ID" : "Meeting",
                            "USER_ID" : "User" ]
        content.categoryIdentifier = "MEETING_INVITATION"
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 60,
            repeats: true)
        
        let request = UNNotificationRequest(
            identifier: "MEETING_INVITATION",
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error)
            }
        }
        
    }
    
    func sendNoti2dfication(){
        
        let acceptAction = UNNotificationAction(identifier: "YES_ACTION",
                                                title: "Yes",
                                                options: [])
        let declineAction = UNNotificationAction(identifier: "NO_ACTION",
                                                 title: "NO",
                                                 options: [])
        // Define the notification type
        let meetingInviteCategory =
        UNNotificationCategory(identifier: "DELETE_INVITATION",
                               actions: [acceptAction, declineAction],
                               intentIdentifiers: [],
                               hiddenPreviewsBodyPlaceholder: "",
                               options: .customDismissAction)
        // Register the notification type.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.setNotificationCategories([meetingInviteCategory])
        
        let content = UNMutableNotificationContent()
        content.title = "Delete Notification"
        content.body = "Every Tuesday at 2pm"
        content.userInfo = ["MEETING_ID" : "Meeting",
                            "USER_ID" : "User" ]
        content.categoryIdentifier = "DELETE_INVITATION"
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 80,
            repeats: true)
        
        let request = UNNotificationRequest(
            identifier: "DELETE_INVITATION",
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error)
            }
        }
        
    }
    
}

