//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6


struct RenalLabRelativeImportance {
    static let BUN:Double = 100
    static let creatinine:Double = 100
    static let bloodGlucose:Double = 60
    static let carbonDioxide:Double = 100
    static let potassiumLevel:Double = 100
    static let calcium:Double = 30
    static let chloride:Double = 50
    static let albumin:Double = 60
    static let anionGap:Double = 70
    static let hemoglobin:Double = 80
    static let microalbumin:Double = 100
    static let eGFR:Double = 100
}
class RenalLabData:LabCalculation {
    
    var type:LabType = .sodium{
        didSet{
            
            super.metricType = type
            switch type {
            //BUN
            case .BUN:
                self.relativeValue = RenalLabRelativeImportance.BUN
            //creatinine
            case .creatinine:
                self.relativeValue = RenalLabRelativeImportance.creatinine
            //bloodGlucose
            case .bloodGlucose:
                self.relativeValue = RenalLabRelativeImportance.bloodGlucose
            //carbonDioxide
            case .carbonDioxide:
                self.relativeValue = RenalLabRelativeImportance.carbonDioxide
            //potassiumLevel
            case .potassiumLevel:
                self.relativeValue = RenalLabRelativeImportance.potassiumLevel
            //calcium
            case .calcium:
                self.relativeValue = RenalLabRelativeImportance.calcium
            //chloride
            case .chloride:
                self.relativeValue = RenalLabRelativeImportance.chloride
            //albumin
            case .albumin:
                self.relativeValue = RenalLabRelativeImportance.albumin
            //anionGap
            case .anionGap:
                self.relativeValue = RenalLabRelativeImportance.anionGap
            //hemoglobin
            case .hemoglobin:
                self.relativeValue = RenalLabRelativeImportance.hemoglobin
            //microalbumin
            case .microalbuminCreatinineRatio:
                self.relativeValue = RenalLabRelativeImportance.microalbumin
            //eGFR
            case .eGFR:
                self.relativeValue = RenalLabRelativeImportance.eGFR
                
            default:
                break
            }
            
            
        }
    }
    override init() {
        super.init()
        super.systemName = SystemName.Renal
    }
   
}

