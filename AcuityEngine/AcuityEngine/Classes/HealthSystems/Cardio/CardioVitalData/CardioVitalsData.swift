//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

struct CardioVitalRelativeImportance {
    static let bloodPressureSystolic:Double = 100
    static let bloodPressureDiastolic:Double = 100
    static let heartRate:Double = 100
    static let irregularRhymesNotification:Double = 100
    static let highHeartRate:Double = 100
    static let lowHeartRate:Double = 100
    static let vo2Max:Double = 50
    static let oxygenSaturation:Double = 100
    static let steps:Double = 85
    static let sleep:Double = 60
    static let waterIntake:Double = 80
}

class CardioVitalsData:VitalCalculation {
    
    
    init(type:VitalsName) {
        super.init()
        super.title = type
        super.systemName = SystemName.Cardiovascular
        switch type {
        case .bloodPressureSystolic:
            self.relativeValue = CardioVitalRelativeImportance.bloodPressureSystolic
        case .bloodPressureDiastolic:
            self.relativeValue = CardioVitalRelativeImportance.bloodPressureDiastolic
        case .heartRate:
            self.relativeValue = CardioVitalRelativeImportance.heartRate
        case .irregularRhymesNotification:
            self.relativeValue = CardioVitalRelativeImportance.irregularRhymesNotification
        case .highHeartRate:
            self.relativeValue = CardioVitalRelativeImportance.highHeartRate
        case .lowHeartRate:
            self.relativeValue = CardioVitalRelativeImportance.lowHeartRate
        case .vo2Max:
            self.relativeValue = CardioVitalRelativeImportance.vo2Max
        case .oxygenSaturation:
            self.relativeValue = CardioVitalRelativeImportance.oxygenSaturation
        case .steps:
            self.relativeValue = CardioVitalRelativeImportance.steps
        case .sleep:
            self.relativeValue = CardioVitalRelativeImportance.sleep
        case .waterIntake:
            self.relativeValue = CardioVitalRelativeImportance.waterIntake
        default:break
        }
        
        
    }
    
}

