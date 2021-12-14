//
//  FNEVitalsData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

struct FNEVitalRelativeImportance {
    static let bloodPressureSystolic:Double = 70
    static let bloodPressureDiastolic:Double = 70
    static let heartRate:Double = 100
    static let irregularRhymesNotification:Double = 80
    static let BMI:Double = 100
    static let waterIntake:Double = 50
}

class FNEVitalsData:VitalCalculation {
    
    
    init(type:VitalsName) {
        super.init()
        super.title = type
        super.systemName = SystemName.Fluids
        switch type {
        case .bloodPressureSystolic:
            self.relativeValue = FNEVitalRelativeImportance.bloodPressureSystolic
        case .bloodPressureDiastolic:
            self.relativeValue = FNEVitalRelativeImportance.bloodPressureDiastolic
        case .heartRate:
            self.relativeValue = FNEVitalRelativeImportance.heartRate
        case .irregularRhymesNotification:
            self.relativeValue = FNEVitalRelativeImportance.irregularRhymesNotification
        case .BMI:
            self.relativeValue = FNEVitalRelativeImportance.BMI
        case .waterIntake:
            self.relativeValue = FNEVitalRelativeImportance.waterIntake
        default:break
        }
        
        
    }
  
}

