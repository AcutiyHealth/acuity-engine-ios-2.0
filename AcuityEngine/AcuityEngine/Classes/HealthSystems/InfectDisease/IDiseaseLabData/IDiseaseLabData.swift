//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

/*
 WBC's
 Neutrophil %
 blood glucose
 Urine nitrites
 Urine Blood
 Anion gap
 */
struct IDiseaseLabRelativeImportance {
    static let WBC:Double = 100
    static let neutrophil:Double = 100
    static let bloodGlucose:Double = 50
    static let urineNitrites:Double = 97
    static let urineBlood:Double = 75
    static let anionGap:Double = 25
}
class IDiseaseLabData:LabCalculation {
    
    init(type:LabType) {
        super.init()
        super.metricType = type
        switch type {
        //WBC
        case .WBC:
            self.relativeValue = IDiseaseLabRelativeImportance.WBC
        //neutrophil
        case .neutrophil:
            self.relativeValue = IDiseaseLabRelativeImportance.neutrophil
        //bloodGlucose
        case .bloodGlucose:
            self.relativeValue = IDiseaseLabRelativeImportance.bloodGlucose
        //urineNitrites
        case .urineNitrites:
            self.relativeValue = IDiseaseLabRelativeImportance.urineNitrites
        //urineBlood
        case .urineBlood:
            self.relativeValue = IDiseaseLabRelativeImportance.urineBlood
        //anionGap
        case .anionGap:
            self.relativeValue = IDiseaseLabRelativeImportance.anionGap
            
        default:
            break
        }
        
        
    }
    
}

