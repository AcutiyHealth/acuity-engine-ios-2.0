//
//  ConditionsModel.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 04/03/21.
//

import Foundation

class ConditionsModel {
    
    var title: String?
    var isOn: Bool?
    var value:ConditionValue = .No
    var color: UIColor = ChartColor.GREENCOLOR
    var startTime: Double = 0
    var endTime: Double = 0
    var textValue: String = ConditionValueText.No.rawValue
    init(title:String,isOn:Bool) {
        self.title = title
        self.isOn = isOn
    }
    init(title:String,value:ConditionValue) {
        self.title = title
        self.value = value
        if value == ConditionValue.Yes{
            color = ChartColor.REDCOLOR
            textValue = ConditionValueText.Yes.rawValue
        }
    }
}
class SymptomsModel {
    
    var title: String?
    var value: SymptomsValue?
    var textValue: SymptomsTextValue?
    var startTime: Double = 0
    var endTime: Double = 0
    var color: UIColor = ChartColor.GREENCOLOR
    init(title:String,textValue:SymptomsTextValue,startTime:Double,endTime:Double) {
        self.title = title
        self.textValue = textValue
        self.startTime = startTime
        self.endTime = endTime
    }
    init(title:String,value:SymptomsValue) {
        self.title = title
        self.value = value
        switch value {
        case .Mild:
            do {
                self.textValue = SymptomsTextValue.Mild
                color = ChartColor.YELLOWCOLOR
            }
        case .Severe:
            do{
                self.textValue = SymptomsTextValue.Severe
                color = ChartColor.REDCOLOR
            }
        case .Present:
            do{
                self.textValue = SymptomsTextValue.Present
                color = ChartColor.YELLOWCOLOR
            }
        case .Not_Present:
            do{
                self.textValue = SymptomsTextValue.Not_Present
                color = ChartColor.GREENCOLOR
            }
        case .Moderate:
            do{
                self.textValue = SymptomsTextValue.Moderate
                color = ChartColor.REDCOLOR
            }
        }
    }
}
class LabModel {
    
    var title: String?
    var value: String?
    var startTime: Double = 0
    var endTime: Double = 0
    var color: UIColor = ChartColor.GREENCOLOR
    
    init(title:String,value:String) {
        self.title = title
        self.value = value
      
    }
   
}
class VitalsModel {
    
    var title: String?
    var value: String?
    var startTime: Double = 0
    var endTime: Double = 0
    var color: UIColor = ChartColor.GREENCOLOR
  
    init(title:String,value:String) {
        self.title = title
        self.value = value
     
    }
   
}
class Symptoms {
    
    var title: String?
  
    init(title:String) {
        self.title = title
    }
   
}

