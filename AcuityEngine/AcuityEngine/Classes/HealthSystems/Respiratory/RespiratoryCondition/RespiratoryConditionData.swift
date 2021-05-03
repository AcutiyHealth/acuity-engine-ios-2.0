//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

struct RespiratoryConditionRelativeImportance {
    static let asthma:Double = 100
    static let pneumonia:Double = 100
    static let respiratoryInfection:Double = 30
    static let covid:Double = 100
    static let allergicRhiniitis:Double = 30
    static let smoking:Double = 100
    static let sleepApnea :Double = 100
    static let heartFailure:Double = 50
    static let coronaryArteryDisease:Double = 50
}

class RespiratoryConditionData:ConditionCalculation {
    
    init(type:ConditionType) {
        super.init()
        super.type = type
        switch type {
        case .asthma:
            self.relativeValue = RespiratoryConditionRelativeImportance.asthma
        case .pneumonia:
            self.relativeValue = RespiratoryConditionRelativeImportance.pneumonia
        case .respiratoryInfection:
            self.relativeValue = RespiratoryConditionRelativeImportance.respiratoryInfection
        case .covid:
            self.relativeValue = RespiratoryConditionRelativeImportance.covid
        case .allergicRhiniitis:
            self.relativeValue = RespiratoryConditionRelativeImportance.allergicRhiniitis
        case .smoking:
            self.relativeValue = RespiratoryConditionRelativeImportance.smoking
        case .sleepApnea:
            self.relativeValue = RespiratoryConditionRelativeImportance.sleepApnea
        case .heartFailure:
            self.relativeValue = RespiratoryConditionRelativeImportance.heartFailure
        case .coronaryArteryDisease:
            self.relativeValue = RespiratoryConditionRelativeImportance.coronaryArteryDisease
        default:
            break
        }
        
    }

}

