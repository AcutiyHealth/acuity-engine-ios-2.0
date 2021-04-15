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
    static let bloodPressureSystolic:Double = 70
    static let bloodPressureDiastolic:Double = 70
    static let heartRate:Double = 60
    static let irregularRhymesNotification:Double = 40
    static let highHeartRate:Double = 20
    static let lowHeartRate:Double = 20
    static let vo2Max:Double = 40
    static let oxygenSaturation:Double = 30
}

class CardioVitalsData:VitalCalculation {
    
    
    init(type:VitalsName) {
        super.init()
        super.title = type
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

