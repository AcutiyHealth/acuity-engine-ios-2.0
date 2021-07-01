//
//  MuscVitalsData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6
/*
 Step Length
 body mass index
 */
struct MuscVitalRelativeImportance {
    static let stepLength:Double = 100
    static let BMI:Double = 50
}

class MuscVitalsData:VitalCalculation {
    
    init(type:VitalsName) {
        super.init()
        super.title = type
        super.systemName = SystemName.Musculatory
        switch type {
        //stepLength
        case .stepLength:
            self.relativeValue = MuscVitalRelativeImportance.stepLength
        //BMI
        case .BMI:
            self.relativeValue = MuscVitalRelativeImportance.BMI
            
        default:
            break
        }
        
    }
    
    
}

