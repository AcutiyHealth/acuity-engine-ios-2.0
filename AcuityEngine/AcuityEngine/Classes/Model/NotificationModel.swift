//
//  NotificationModel.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 26/10/21.
//

import Foundation

class NotificationModel {
    
    var id: String?
    var title: String?
    var body: String?
    var triggerDate: Date?
    var isRepeat:Bool = false
    var numberOfDays: Int?

    init(identifier:String){
        self.id = identifier;
    }
    init(title:String,body:String,triggerDate:Date,identifier:String,isRepeat:Bool){
        self.id = identifier;
        self.title = title
        self.body = body
        self.triggerDate = triggerDate
        self.isRepeat = isRepeat
    }

   
    init(title:String,body:String,numberOfDays:Int,identifier:String,isRepeat:Bool){
        self.id = identifier;
        self.title = title
        self.body = body
        self.numberOfDays = numberOfDays
        self.isRepeat = isRepeat
    }
}
