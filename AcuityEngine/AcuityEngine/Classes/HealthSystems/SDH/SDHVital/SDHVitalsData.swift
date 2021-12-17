//
//  SDHVitalsData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6
/*
 body mass index
 */
struct SDHVitalRelativeImportance {
    static let bloodPressureSystolic:Double = 100
    static let bloodPressureDiastolic:Double = 100
    static let age:Double = 100
    static let BMI:Double = 100
    static let oxygenSaturation:Double = 100
    static let steps:Double = 80
    static let waterIntake:Double = 80
    static let sleep:Double = 100
}

class SDHVitalsData:VitalCalculation {
    
    init(type:VitalsName) {
        super.init()
        super.title = type
        super.systemName = SystemName.SocialDeterminantsofHealth
        switch type {
            //bloodPressureSystolic
        case .bloodPressureSystolic:
            self.relativeValue = SDHVitalRelativeImportance.bloodPressureSystolic
            //bloodPressureDiastolic
        case .bloodPressureDiastolic:
            self.relativeValue = SDHVitalRelativeImportance.bloodPressureDiastolic
            //age
        case .age:
            self.relativeValue = SDHVitalRelativeImportance.age
            //BMI
        case .BMI:
            self.relativeValue = SDHVitalRelativeImportance.BMI
            //oxygenSaturation
        case .oxygenSaturation:
            self.relativeValue = SDHVitalRelativeImportance.oxygenSaturation
            //steps
        case .steps:
            self.relativeValue = SDHVitalRelativeImportance.steps
            //waterIntake
        case .waterIntake:
            self.relativeValue = SDHVitalRelativeImportance.waterIntake
            //sleep
        case .sleep:
            self.relativeValue = SDHVitalRelativeImportance.sleep
        default:
            break
        }
        
    }
    
    
}

