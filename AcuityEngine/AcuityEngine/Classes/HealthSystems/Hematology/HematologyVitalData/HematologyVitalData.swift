//
//  HematoVitalsData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6
/*
 S Blood pressure
 D Blood pressure
 body mass index
 Temperature
 */
struct HematoVitalRelativeImportance {
    static let bloodPressureSystolic:Double = 70
    static let bloodPressureDiastolic:Double = 70
    static let BMI:Double = 75
    static let temperature:Double = 50
}

class HematoVitalsData:VitalCalculation {
    
    
    init(type:VitalsName) {
        super.init()
        super.title = type
        super.systemName = SystemName.Hematology
        switch type {
        case .bloodPressureSystolic:
            self.relativeValue = HematoVitalRelativeImportance.bloodPressureSystolic
        case .bloodPressureDiastolic:
            self.relativeValue = HematoVitalRelativeImportance.bloodPressureDiastolic
        case .temperature:
            self.relativeValue = HematoVitalRelativeImportance.temperature
        case .BMI:
            self.relativeValue = HematoVitalRelativeImportance.BMI
        default:break
        }
        
        
    }
   
}

