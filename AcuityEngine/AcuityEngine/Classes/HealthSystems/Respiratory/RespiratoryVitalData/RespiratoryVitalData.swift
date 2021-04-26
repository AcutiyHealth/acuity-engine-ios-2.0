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
    static let respiratoryRate:Double = 0
    static let oxygenSaturation:Double = 80
    static let heartRate:Double = 30
    static let irregularRhymesNotification:Double = 30
    static let peakFlowRate:Double = 70
    static let vo2Max:Double = 60
    static let inhalerUsage:Double = 20
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
        case .InhalerUsage:
            self.relativeValue = RespiratoryVitalRelativeImportance.inhalerUsage
        default:break
        }
        
        
    }
    
    func getStartDate()->String{
        return getDateMediumFormat(time: startTimeStamp)
    }
    func getEndDate()->String{
        return getDateMediumFormat(time: endTimeStamp)
    }
}

