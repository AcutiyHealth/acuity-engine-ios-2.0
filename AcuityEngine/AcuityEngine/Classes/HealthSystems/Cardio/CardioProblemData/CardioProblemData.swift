//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

struct CardioConditionRelativeImportance {
    static let hypertension:Double = 100
    static let arrhythmia:Double = 100
    static let heartFailure:Double = 100
    static let arteryDisease:Double = 100
    static let anemia:Double = 45
    static let diabetes:Double = 100
    static let hyperlipidemia:Double = 75
}

class CardioConditionData:ConditionCalculation {
   
     init(type:CardioConditionType) {
        super.init()
        
        switch type {
        case .hypertension:
            self.relativeValue = CardioConditionRelativeImportance.hypertension
        case .arrhythmia:
            self.relativeValue = CardioConditionRelativeImportance.arrhythmia
        case .heartFailure:
            self.relativeValue = CardioConditionRelativeImportance.heartFailure
        case .arteryDisease:
            self.relativeValue = CardioConditionRelativeImportance.arteryDisease
        case .anemia:
            self.relativeValue = CardioConditionRelativeImportance.anemia
        case .diabetes:
            self.relativeValue = CardioConditionRelativeImportance.diabetes
        case .hyperlipidemia:
            self.relativeValue = CardioConditionRelativeImportance.hyperlipidemia
        }
       
        
    }
        
}

