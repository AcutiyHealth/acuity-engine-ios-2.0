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
    static let bloodPressureSystolic:Double = 70
    static let bloodPressureDiastolic:Double = 70
    static let age:Double = 65
    static let BMI:Double = 20
    static let oxygenSaturation:Double = 75
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
        default:
            break
        }
        
    }
    
    
}

