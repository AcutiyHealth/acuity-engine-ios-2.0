//
//  NotificationManager.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 19/10/21.
//

import Foundation

class NotificationManager {
    
    static let shared = NotificationManager()
    func setNotificationForAppOpen(model:NotificationModel){
        let content = UNMutableNotificationContent()
        content.title = model.title ?? ""
        content.body = model.body ?? ""
        let  fireDate = Calendar.current.dateComponents([.day, .month, .hour, .minute], from:  model.triggerDate!)
    //
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: model.isRepeat)
        //Create the request
        let request = UNNotificationRequest(
            identifier: model.id ?? "",
            content: content,
            trigger: trigger
        )
        Log.d("trigger---\(trigger)")
        addNotificationRequest(request: request)
    }
    
    func addNotificationRequest(request:UNNotificationRequest){
        //Schedule the request
        UNUserNotificationCenter.current().add(
            request, withCompletionHandler: nil)
    }
    
    
}
