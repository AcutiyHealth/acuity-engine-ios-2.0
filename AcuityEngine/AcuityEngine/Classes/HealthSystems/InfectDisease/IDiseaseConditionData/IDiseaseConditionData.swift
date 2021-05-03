//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

struct IDiseaseConditionRelativeImportance {
    /*UTI
     bronchitis/pneumonia
     cellulitis
     Covid
     Otitis
     Upper respiratory infection
     Gastroentritis
     diabetes*/
    static let UTI:Double = 100
    static let pneumonia:Double = 100
    static let cellulitis:Double = 100
    static let covid:Double = 100
    static let otitis:Double = 100
    static let respiratoryInfection :Double = 100
    static let gastroentritis :Double = 100
    static let diabetes :Double = 100
}

class IDiseaseConditionData:ConditionCalculation {
    
    init(type:ConditionType) {
        super.init()
        super.type = type
        switch type {
        //UTI
        case .UTI:
            self.relativeValue = IDiseaseConditionRelativeImportance.UTI
        //pneumonia
        case .pneumonia:
            self.relativeValue = IDiseaseConditionRelativeImportance.pneumonia
        //cellulitis
        case .cellulitis:
            self.relativeValue = IDiseaseConditionRelativeImportance.cellulitis
        //covid
        case .covid:
            self.relativeValue = IDiseaseConditionRelativeImportance.covid
        //otitis
        case .otitis:
            self.relativeValue = IDiseaseConditionRelativeImportance.otitis
        //respiratoryInfection
        case .respiratoryInfection:
            self.relativeValue = IDiseaseConditionRelativeImportance.respiratoryInfection
        //gastroentritis
        case .gastroentritis:
            self.relativeValue = IDiseaseConditionRelativeImportance.gastroentritis
        //diabetes
        case .diabetes:
            self.relativeValue = IDiseaseConditionRelativeImportance.diabetes
        default:break
        }
        
    }
    
}

