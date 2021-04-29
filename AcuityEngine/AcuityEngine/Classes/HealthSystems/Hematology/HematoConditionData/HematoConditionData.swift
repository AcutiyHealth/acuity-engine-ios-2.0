//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

struct HematoConditionRelativeImportance {
    /*Anemia
     Cancer (of any type)
     Other Heme/Onc problem*/
    static let anemia:Double = 100
    static let cancer:Double = 100
    static let otherHematoProblem:Double = 100
}

class HematoConditionData:ConditionCalculation {
    
    init(type:ConditionType) {
        super.init()
        
        switch type {
        //anemia
        case .anemia:
            self.relativeValue = HematoConditionRelativeImportance.anemia
        //cancer
        case .cancer:
            self.relativeValue = HematoConditionRelativeImportance.cancer
        //otherHematoProblem
        case .otherHematoProblem:
            self.relativeValue = HematoConditionRelativeImportance.otherHematoProblem
            
        default:break
        }
        
    }
    
}

