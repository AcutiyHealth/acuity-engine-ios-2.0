//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6


struct RespiratoryLabRelativeImportance {
    static let sodium:Double = 40
    static let carbonDioxide:Double = 30
    static let chloride:Double = 20
    static let WBC:Double = 30
    static let neutrophil:Double = 50
}
class RespiratoryLabData:LabCalculation {
    
    init(type:LabType) {
        super.init()
        super.metricType = type
        switch type {
        case .sodium:
            self.relativeValue = RespiratoryLabRelativeImportance.sodium
        case .chloride:
            self.relativeValue = RespiratoryLabRelativeImportance.chloride
        case .carbonDioxide:
            self.relativeValue = RespiratoryLabRelativeImportance.carbonDioxide
        case .WBC:
            self.relativeValue = RespiratoryLabRelativeImportance.WBC
        case .neutrophil:
            self.relativeValue = RespiratoryLabRelativeImportance.neutrophil
            
        default:
            break
        }
        
        
    }
    
}

