//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

struct RenalVitalRelativeImportance {
    static let bloodPressureSystolic:Double = 100
    static let bloodPressureDiastolic:Double = 100
    static let waterIntake:Double = 100
}

class RenalVitalsData:VitalCalculation {
    
    
    init(type:VitalsName) {
        super.init()
        super.title = type
        super.systemName = SystemName.Renal
        switch type {
        case .bloodPressureSystolic:
            self.relativeValue = RenalVitalRelativeImportance.bloodPressureSystolic
        case .bloodPressureDiastolic:
            self.relativeValue = RenalVitalRelativeImportance.bloodPressureDiastolic
        case .waterIntake:
            self.relativeValue = RenalVitalRelativeImportance.waterIntake
        default:break
        }
        
        
    }
    
}

