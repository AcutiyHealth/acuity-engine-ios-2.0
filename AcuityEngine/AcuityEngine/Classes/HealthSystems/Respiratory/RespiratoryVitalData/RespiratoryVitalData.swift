//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

struct RespiratoryVitalRelativeImportance {
    static let bloodPressureSystolic:Double = 30
    static let bloodPressureDiastolic:Double = 30
    static let respiratoryRate:Double = 100
    static let oxygenSaturation:Double = 100
    static let heartRate:Double = 50
    static let irregularRhymesNotification:Double = 50
    static let peakFlowRate:Double = 100
    static let vo2Max:Double = 100
    static let steps:Double = 100
    static let sleep:Double = 50
    //static let inhalerUsage:Double = 20
}

class RespiratoryVitalsData:VitalCalculation {
    
    
    init(type:VitalsName) {
        super.init()
        super.title = type
        super.systemName = SystemName.Respiratory
        switch type {
        case .bloodPressureSystolic:
            self.relativeValue = RespiratoryVitalRelativeImportance.bloodPressureSystolic
        case .bloodPressureDiastolic:
            self.relativeValue = RespiratoryVitalRelativeImportance.bloodPressureDiastolic
        case .respiratoryRate:
            self.relativeValue = RespiratoryVitalRelativeImportance.respiratoryRate
        case .oxygenSaturation:
            self.relativeValue = RespiratoryVitalRelativeImportance.oxygenSaturation
        case .heartRate:
            self.relativeValue = RespiratoryVitalRelativeImportance.heartRate
        case .irregularRhymesNotification:
            self.relativeValue = RespiratoryVitalRelativeImportance.irregularRhymesNotification
        case .peakflowRate:
            self.relativeValue = RespiratoryVitalRelativeImportance.peakFlowRate
        case .vo2Max:
            self.relativeValue = RespiratoryVitalRelativeImportance.vo2Max
        case .steps:
            self.relativeValue = RespiratoryVitalRelativeImportance.steps
        case .sleep:
            self.relativeValue = RespiratoryVitalRelativeImportance.sleep
//        case .InhalerUsage:
//            self.relativeValue = RespiratoryVitalRelativeImportance.inhalerUsage
        default:break
        }
        
        
    }
    
  
}

