//
//  HeentConditionData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import Foundation
import HealthKitReporter

struct HeentConditionRelativeImportance {
    /*Allergic Rhnitis
     Upper respiratory infection
     Covid
     Decreased vision
     Hearing Loss
     Otitis
     diabetes*/
    static let allergicRhiniitis:Double = 100
    static let respiratoryInfection:Double = 100
    static let covid:Double = 100
    static let decreasedVision:Double = 100
    static let hearingLoss:Double = 100
    static let otitis:Double = 100
    static let diabetes:Double = 30
   
}

class HeentConditionData:ConditionCalculation {
    
    init(type:ConditionType) {
        super.init()
        super.type = type
        switch type {
        //allergicRhiniitis
        case .allergicRhiniitis:
            self.relativeValue = HeentConditionRelativeImportance.allergicRhiniitis
        //respiratoryInfection
        case .respiratoryInfection:
            self.relativeValue = HeentConditionRelativeImportance.respiratoryInfection
        //covid
        case .covid:
            self.relativeValue = HeentConditionRelativeImportance.covid
        //decreasedVision
        case .decreasedVision:
            self.relativeValue = HeentConditionRelativeImportance.decreasedVision
        //hearingLoss
        case .hearingLoss:
            self.relativeValue = HeentConditionRelativeImportance.hearingLoss
        //otitis
        case .otitis:
            self.relativeValue = HeentConditionRelativeImportance.otitis
        //diabetes
        case .diabetes:
            self.relativeValue = HeentConditionRelativeImportance.diabetes
        default:break
        }
        
    }
    
}

