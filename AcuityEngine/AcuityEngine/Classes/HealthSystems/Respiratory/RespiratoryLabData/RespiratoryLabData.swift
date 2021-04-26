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
    static let sodium:Double = 25
    static let carbonDioxide:Double = 60
    static let chloride:Double = 25
    static let WBC:Double = 70
    static let neutrophil:Double = 70
}
class RespiratoryLabData:LabCalculation {
    
    init(type:LabType) {
        super.init()
        super.metricType = type
        super.systemName = SystemName.Respiratory
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

