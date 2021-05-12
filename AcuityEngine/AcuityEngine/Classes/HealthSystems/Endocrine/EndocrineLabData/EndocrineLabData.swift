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
 hemoglobin A1c
 TSH
 microalbumin/creatinine ratio
 Sodium
 Potassium level
 BUN
 creatinine
 chloride
 Calcium
 Albumin
 Anion gap
 blood glucose
 */
struct EndocrineLabRelativeImportance {
    static let hemoglobinA1C:Double = 100
    static let TSH:Double = 100
    static let microalbuminCreatinineRatio:Double = 100
    static let sodium:Double = 40
    static let potassiumLevel:Double = 40
    static let BUN:Double = 85
    static let creatinine:Double = 85
    static let chloride:Double = 40
    static let calcium:Double = 75
    static let albumin:Double = 35
    static let anionGap:Double = 40
    static let bloodGlucose:Double = 50
}
class EndocrineLabData:LabCalculation {
    var type:LabType = .sodium{
        didSet{
            
            super.metricType = type
            switch type {
            //hemoglobinA1C
            case .hemoglobinA1C:
                self.relativeValue = EndocrineLabRelativeImportance.hemoglobinA1C
            //TSH
            case .TSH:
                self.relativeValue = EndocrineLabRelativeImportance.TSH
            //microalbuminCreatinineRatio
            case .microalbuminCreatinineRatio:
                self.relativeValue = EndocrineLabRelativeImportance.microalbuminCreatinineRatio
            //sodium
            case .sodium:
                self.relativeValue = EndocrineLabRelativeImportance.sodium
            //potassiumLevel
            case .potassiumLevel:
                self.relativeValue = EndocrineLabRelativeImportance.potassiumLevel
            //BUN
            case .BUN:
                self.relativeValue = EndocrineLabRelativeImportance.BUN
            //creatinine
            case .creatinine:
                self.relativeValue = EndocrineLabRelativeImportance.creatinine
            //chloride
            case .chloride:
                self.relativeValue = EndocrineLabRelativeImportance.chloride
            //calcium
            case .calcium:
                self.relativeValue = EndocrineLabRelativeImportance.calcium
            //albumin
            case .albumin:
                self.relativeValue = EndocrineLabRelativeImportance.albumin
            //anionGap
            case .anionGap:
                self.relativeValue = EndocrineLabRelativeImportance.anionGap
            //bloodGlucose
            case .bloodGlucose:
                self.relativeValue = EndocrineLabRelativeImportance.bloodGlucose
                
            default:
                break
            }
            
            
        }
    }
    override init() {
        super.init()
        super.systemName = SystemName.Endocrine
    }
    
    
}

