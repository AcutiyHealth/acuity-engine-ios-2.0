//
//  SkinVitalsData.swift
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
struct SkinVitalRelativeImportance {
    static let temperature:Double = 100
    static let waterIntake:Double = 80
}

class SkinVitalsData:VitalCalculation {
    
    init(type:VitalsName) {
        super.init()
        super.title = type
        super.systemName = SystemName.Integumentary
        switch type {
            //stepLength
        case .temperature:
            self.relativeValue = SkinVitalRelativeImportance.temperature
            //waterIntake
        case .waterIntake:
            self.relativeValue = SkinVitalRelativeImportance.waterIntake
            
        default:
            break
        }
        
    }
    
    
}

