//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

struct RenalConditionRelativeImportance {
    /*kidney diease
 kidney stones
 hypertension
 electrolyte disorders
 underweight/malnutrition
 diabetes
 UTI*/
    static let kidneyDiease:Double = 100
    static let kidneyStones:Double = 100
    static let hypertension:Double = 50
    static let electrolyteDisorders:Double = 50
    static let underweightOrMalnutrition:Double = 50
    static let diabetes :Double = 100
    static let UTI:Double = 100
}

class RenalConditionData:ConditionCalculation {
    
    init(type:ConditionType) {
        super.init()
        super.type = type
        switch type {
        case .kidneyDiease:
            self.relativeValue = RenalConditionRelativeImportance.kidneyDiease
        case .kidneyStones:
            self.relativeValue = RenalConditionRelativeImportance.kidneyStones
        case .hypertension:
            self.relativeValue = RenalConditionRelativeImportance.hypertension
        case .electrolyteDisorders:
            self.relativeValue = RenalConditionRelativeImportance.electrolyteDisorders
        case .underweightOrMalnutrition:
            self.relativeValue = RenalConditionRelativeImportance.underweightOrMalnutrition
        case .diabetes:
            self.relativeValue = RenalConditionRelativeImportance.diabetes
        case .UTI:
            self.relativeValue = RenalConditionRelativeImportance.UTI
        default:break
        }
        
    }

}

