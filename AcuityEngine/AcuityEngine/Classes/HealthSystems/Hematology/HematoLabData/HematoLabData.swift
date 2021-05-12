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
 Hemaglobin
 Platelets
 WBCs
 Neutrophil %
 MCV
 Alkaline Phosphatase
 Anion gap
 B12 level
 */
struct HematoLabRelativeImportance {
    static let hemoglobin:Double = 100
    static let platelets:Double = 100
    static let WBC:Double = 40
    static let neutrophil:Double = 40
    static let MCV:Double = 100
    static let alkalinePhosphatase:Double = 60
    static let anionGap:Double = 30
    static let b12Level:Double = 100
}
class HematoLabData:LabCalculation {
    
    var type:LabType = .sodium{
        didSet{
            
            super.metricType = type
            switch type {
            //hemoglobin
            case .hemoglobin:
                self.relativeValue = HematoLabRelativeImportance.hemoglobin
            //platelets
            case .platelets:
                self.relativeValue = HematoLabRelativeImportance.platelets
            //WBC
            case .WBC:
                self.relativeValue = HematoLabRelativeImportance.WBC
            //neutrophil
            case .neutrophil:
                self.relativeValue = HematoLabRelativeImportance.neutrophil
            //MCV
            case .MCV:
                self.relativeValue = HematoLabRelativeImportance.MCV
            //alkalinePhosphatase
            case .alkalinePhosphatase:
                self.relativeValue = HematoLabRelativeImportance.alkalinePhosphatase
            //anionGap
            case .anionGap:
                self.relativeValue = HematoLabRelativeImportance.anionGap
            //b12Level
            case .b12Level:
                self.relativeValue = HematoLabRelativeImportance.b12Level
                
            default:
                break
            }
            
            
        }
    }
    override init() {
        super.init()
        super.systemName = SystemName.Hematology
    }
    
}

