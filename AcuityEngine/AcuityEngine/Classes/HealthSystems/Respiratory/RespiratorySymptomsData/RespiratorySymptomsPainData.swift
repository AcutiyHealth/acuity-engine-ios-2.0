//
//  RespiratorySymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

class RespiratorySymptomsPainData:RespiratorySymptomCalculation {
    override var value:Double{
        didSet{
            super.value = value
        }
    }
    override var startTime:Double{
        didSet{
            super.startTime = startTime
        }
    }
    override var endTime:Double{
        didSet{
            super.endTime = endTime
        }
    }
     init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        switch type {
        case .chestTightnessOrPain:
            self.relativeValue = 40
        case .skippedHeartbeat:
            self.relativeValue = 40
        case .coughing:
            self.relativeValue = 40
        case .wheezing:
            self.relativeValue = 40
        case .rapidPoundingOrFlutteringHeartbeat:
            self.relativeValue = 40
        case .fainting:
            self.relativeValue = 40
        case .shortnessOfBreath:
            self.relativeValue = 10
    
        default:
            self.relativeValue = 40
        }
       
        
    }
        
}

