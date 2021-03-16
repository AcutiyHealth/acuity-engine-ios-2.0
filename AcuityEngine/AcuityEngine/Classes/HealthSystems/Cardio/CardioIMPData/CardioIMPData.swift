//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

class CardioVitals:CardioIMPCalculation {
    override var value:Double{
        didSet{
            super.value = value
        }
    }
    
     init(type:CardioVitalsType) {
        super.init()
        super.VitalsType = type
        switch type {
        case .heartRate:
            self.relativeValue = 100
        case .lowHeartRate:
            self.relativeValue = 20
        case .highHeartRate:
            self.relativeValue = 30
        case .systolicBP:
            self.relativeValue = 70
        case .diastolicBP:
            self.relativeValue = 70
        case .irregularRhymesNotification:
            self.relativeValue = 80
        case .vo2Max:
            self.relativeValue = 20
      
        }
       
        
    }
    
    func getStartDate()->String{
        return getDateMediumFormat(time: startTimeStamp)
    }
    func getEndDate()->String{
        return getDateMediumFormat(time: endTimeStamp)
    }
}

