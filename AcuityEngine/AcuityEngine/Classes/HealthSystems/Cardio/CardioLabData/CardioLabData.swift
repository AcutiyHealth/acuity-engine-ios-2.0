//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6


struct CardioLabRelativeImportance {
    static let potassiumLevel:Double = 100
    static let sodium:Double = 50
    static let chloride:Double = 40
    static let albumin:Double = 40
    static let microalbumin:Double = 50
    static let bPeptide:Double = 100
    static let hemoglobin:Double = 80
}
class CardioLabData:LabCalculation {
    
    var type:LabType = .sodium{
        didSet{
            
            super.metricType = type
            switch type {
            case .potassiumLevel:
                self.relativeValue = CardioLabRelativeImportance.potassiumLevel
            case .sodium:
                self.relativeValue = CardioLabRelativeImportance.sodium
            case .chloride:
                self.relativeValue = CardioLabRelativeImportance.chloride
            case .albumin:
                self.relativeValue = CardioLabRelativeImportance.albumin
            case .microalbuminCreatinineRatio:
                self.relativeValue = CardioLabRelativeImportance.microalbumin
            case .bPeptide:
                self.relativeValue = CardioLabRelativeImportance.bPeptide
            case .hemoglobin:
                self.relativeValue = CardioLabRelativeImportance.hemoglobin
            default:
                break
                
            }
            
            
        }
    }
    override init() {
        super.init()
        super.systemName = SystemName.Cardiovascular
    }
}

