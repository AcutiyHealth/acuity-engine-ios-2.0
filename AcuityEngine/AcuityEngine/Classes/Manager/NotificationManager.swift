//
//  NotificationManager.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 19/10/21.
//

import Foundation
import UserNotifications
extension TimeInterval {
    private var milliseconds: Int {
        return Int((truncatingRemainder(dividingBy: 1)) * 1000)
    }
    
    private var seconds: Int {
        return Int(self) % 60
    }
    
    private var minutes: Int {
        return (Int(self) / 60 ) % 60
    }
    
    private var hours: Int {
        return Int(self) / 3600
    }
    
    var stringTime: String {
        if hours != 0 {
            return "\(hours)h \(minutes)m \(seconds)s"
        } else if minutes != 0 {
            return "\(minutes)m \(seconds)s"
        } else if milliseconds != 0 {
            return "\(seconds)s \(milliseconds)ms"
        } else {
            return "\(seconds)s"
        }
    }
}
class NotificationManager {
    
    static let shared = NotificationManager()
    func setNotificationForAppOpen(model:NotificationModel){
        let content = UNMutableNotificationContent()
        content.title = model.title ?? ""
        content.body = model.body ?? ""
        content.sound = UNNotificationSound.default
        //let  fireDate = Calendar.current.dateComponents([.day, .month, .hour, .minute], from:  model.triggerDate!)
        
        //let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: model.isRepeat)
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: (Double(model.numberOfDays!*24)*60*60),
            repeats: true)
        //Create the request
        let request = UNNotificationRequest(
            identifier: model.id ?? "",
            content: content,
            trigger: trigger
        )
        Log.d("trigger---\(trigger)")
        addNotificationRequest(request: request)
    }
    func setNotificationForSymptoms(model:NotificationModel){
        let content = UNMutableNotificationContent()
        content.title = model.title ?? ""
        content.body = model.body ?? ""
        content.sound = UNNotificationSound.default
        //let  fireDate = Calendar.current.dateComponents([.day, .month, .hour, .minute], from:  model.triggerDate!)
        //print("stringTime",model.triggerDate!.timeIntervalSinceNow.stringTime)
        //UNTimeIntervalNotificationTrigger acceps values in seconds.....
        //So convert 2 days into seconds and set notification
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: (Double(model.numberOfDays!*24)*60*60),
            repeats: true)
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
    func removeScheduledNotification(model:NotificationModel) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
           var identifiers: [String] = []
           for notification:UNNotificationRequest in notificationRequests {
               if notification.identifier == model.id {
                  identifiers.append(notification.identifier)
               }
           }
           UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
        }
    }
}
