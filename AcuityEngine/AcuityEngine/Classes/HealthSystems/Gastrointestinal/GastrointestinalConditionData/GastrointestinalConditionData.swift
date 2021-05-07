//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

struct GastrointestinalConditionRelativeImportance {
    /*GERD
     Hyperlipidemia
     Ulcerative Colitis
     Crohns disease
     Gastroentritis
     Irritable Bowel disease
     Obesity/overweight
     sleep apnea
     underweight/malnutrition
     Liver DIsease
     diabetes*/
    static let GERD:Double = 100
    static let hyperlipidemia:Double = 100
    static let ulcerativeColitis:Double = 100
    static let crohnsDisease:Double = 100
    static let gastroentritis:Double = 100
    static let irritableBowelDisease:Double = 100
    static let overweight:Double = 100
    static let sleepApnea:Double = 50
    static let underweightMalnutrition:Double = 100
    static let liverDisease:Double = 100
    static let diabetes:Double = 50
}

class GastrointestinalConditionData:ConditionCalculation {
    
    init(type:ConditionType) {
        super.init()
        super.type = type
        switch type {
        //GERD
        case .GERD:
            self.relativeValue = GastrointestinalConditionRelativeImportance.GERD
        //hyperlipidemia
        case .hyperlipidemia:
            self.relativeValue = GastrointestinalConditionRelativeImportance.hyperlipidemia
        //ulcerativeColitis
        case .ulcerativeColitis:
            self.relativeValue = GastrointestinalConditionRelativeImportance.ulcerativeColitis
        //crohnsDisease
        case .crohnsDisease:
            self.relativeValue = GastrointestinalConditionRelativeImportance.crohnsDisease
        //gastroentritis
        case .gastroentritis:
            self.relativeValue = GastrointestinalConditionRelativeImportance.gastroentritis
        //irritableBowelDisease
        case .irritableBowelDisease:
            self.relativeValue = GastrointestinalConditionRelativeImportance.irritableBowelDisease
        //overweight
        case .overweightOrObesity:
            self.relativeValue = GastrointestinalConditionRelativeImportance.overweight
        //sleepApnea
        case .sleepApnea:
            self.relativeValue = GastrointestinalConditionRelativeImportance.sleepApnea
        //underweightMalnutrition
        case .underweightOrMalnutrition:
            self.relativeValue = GastrointestinalConditionRelativeImportance.underweightMalnutrition
        //liverDisease
        case .liverDisease:
            self.relativeValue = GastrointestinalConditionRelativeImportance.liverDisease
        //diabetes
        case .diabetes:
            self.relativeValue = GastrointestinalConditionRelativeImportance.diabetes
        default:break
        }
        
    }
    
}

