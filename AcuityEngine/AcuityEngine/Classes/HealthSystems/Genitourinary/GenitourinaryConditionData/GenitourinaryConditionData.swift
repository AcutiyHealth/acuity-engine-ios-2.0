//
//  GenitourinaryConditionData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import Foundation
import HealthKitReporter

struct GenitourinaryConditionRelativeImportance {
    /*UTI
     Urinary problems
     kidney stones
     chronic kidney disease
     diabetes*/
    static let UTI:Double = 100
    static let urinaryProblems:Double = 100
    static let kidneyStones:Double = 100
    static let chronicKidneyDisease:Double = 100
    static let diabetes:Double = 75
}

class GenitourinaryConditionData:ConditionCalculation {
    
    init(type:ConditionType) {
        super.init()
        super.type = type
        switch type {
        //UTI
        case .UTI:
            self.relativeValue = GenitourinaryConditionRelativeImportance.UTI
        //urinaryProblems
        case .urinaryProblems:
            self.relativeValue = GenitourinaryConditionRelativeImportance.urinaryProblems
        //kidneyStones
        case .kidneyStones:
            self.relativeValue = GenitourinaryConditionRelativeImportance.kidneyStones
        //chronicKidneyDisease
        case .kidneyDiease:
            self.relativeValue = GenitourinaryConditionRelativeImportance.chronicKidneyDisease
        //diabetes
        case .diabetes:
            self.relativeValue = GenitourinaryConditionRelativeImportance.diabetes
       
        default:break
        }
        
    }
    
}

