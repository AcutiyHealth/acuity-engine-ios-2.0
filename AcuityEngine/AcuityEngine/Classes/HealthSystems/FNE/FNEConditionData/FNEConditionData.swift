//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

struct FNEConditionRelativeImportance {
    /*UTI
     bronchitis/pneumonia
     cellulitis
     Covid
     Otitis
     Upper respiratory infection
     Gastroentritis
     diabetes*/
    static let electrolyteDisorders:Double = 100
    static let underweightOrMalnutrition:Double = 100
    static let overweightOrObesity:Double = 100
    static let kidneyDiease:Double = 100
    static let pneumonia:Double = 50
    static let gastroentritis :Double = 50
    static let diabetes :Double = 100
}

class FNEConditionData:ConditionCalculation {
    
    init(type:ConditionType) {
        super.init()
        
        switch type {
        //UTI
        case .electrolyteDisorders:
            self.relativeValue = FNEConditionRelativeImportance.electrolyteDisorders
        //underweightOrMalnutrition
        case .underweightOrMalnutrition:
            self.relativeValue = FNEConditionRelativeImportance.underweightOrMalnutrition
        //overweightOrObesity
        case .overweightOrObesity:
            self.relativeValue = FNEConditionRelativeImportance.overweightOrObesity
        //kidneyDiease
        case .kidneyDiease:
            self.relativeValue = FNEConditionRelativeImportance.kidneyDiease
        //pneumonia
        case .pneumonia:
            self.relativeValue = FNEConditionRelativeImportance.pneumonia
        //gastroentritis
        case .gastroentritis:
            self.relativeValue = FNEConditionRelativeImportance.gastroentritis
        //diabetes
        case .diabetes:
            self.relativeValue = FNEConditionRelativeImportance.diabetes
        default:break
        }
        
    }
    
}

