//
//  NeuroVitalsData.swift
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
struct NeuroVitalRelativeImportance {
    static let bloodPressureSystolic:Double = 70
    static let bloodPressureDiastolic:Double = 70
    static let bloodOxygenLevel:Double = 70
    static let vo2Max:Double = 60
    static let steps:Double = 80
    static let sleep:Double = 100
}

class NeuroVitalsData:VitalCalculation {
    
    init(type:VitalsName) {
        super.init()
        super.title = type
        super.systemName = SystemName.Nuerological
        switch type {
            //bloodPressureSystolic
        case .bloodPressureSystolic:
            self.relativeValue = NeuroVitalRelativeImportance.bloodPressureSystolic
            //bloodPressureDiastolic
        case .bloodPressureDiastolic:
            self.relativeValue = NeuroVitalRelativeImportance.bloodPressureDiastolic
            //oxygenSaturation
        case .oxygenSaturation:
            self.relativeValue = NeuroVitalRelativeImportance.bloodOxygenLevel
            //vo2Max
        case .vo2Max:
            self.relativeValue = NeuroVitalRelativeImportance.vo2Max
            //vo2Max
        case .steps:
            self.relativeValue = NeuroVitalRelativeImportance.steps
            //vo2Max
        case .sleep:
            self.relativeValue = NeuroVitalRelativeImportance.sleep
        default:
            break
        }
        
    }
    
    
}

