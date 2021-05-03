//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

struct EndocrineConditionRelativeImportance {
    /*diabetes
     Thyroid disorder
     Polycystic Ovarian Disease
     Hormone problems*/
    static let diabetes:Double = 100
    static let thyroidDisorder:Double = 100
    static let polycysticOvarianDisease:Double = 0
    static let hormoneProblems:Double = 0
}

class EndocrineConditionData:ConditionCalculation {
    
    init(type:ConditionType) {
        super.init()
        super.type = type
        switch type {
        //diabetes
        case .diabetes:
            self.relativeValue = EndocrineConditionRelativeImportance.diabetes
        //thyroidDisorder
        case .thyroidDisorder:
            self.relativeValue = EndocrineConditionRelativeImportance.thyroidDisorder
        //polycysticOvarianDisease
        case .polycysticOvarianDisease:
            self.relativeValue = EndocrineConditionRelativeImportance.polycysticOvarianDisease
        //hormoneProblems
        case .hormoneProblems:
            self.relativeValue = EndocrineConditionRelativeImportance.hormoneProblems
        default:break
        }
        
    }
    
}

