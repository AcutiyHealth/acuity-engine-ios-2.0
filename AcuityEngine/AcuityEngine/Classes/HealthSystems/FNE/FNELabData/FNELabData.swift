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
 blood glucose
 Sodium
 potassium
 BUN
 Creatinine
 eGFR
 Albumin
 microalbumin/creat ratio
 carbon dioxide
 Anion gap
 Calcium
 chloride
 Urine ketone
 MCV
 AST
 ALT
 */
struct FNELabRelativeImportance {
    static let bloodGlucose:Double = 100
    static let sodium:Double = 100
    static let potassiumLevel:Double = 100
    static let BUN:Double = 100
    static let creatinine:Double = 100
    static let eGFR:Double = 100
    static let albumin:Double = 100
    static let microalbumin:Double = 100
    static let carbonDioxide:Double = 100
    static let anionGap:Double = 100
    static let calcium:Double = 100
    static let chloride:Double = 100
    static let urineKetone:Double = 85
    static let MCV:Double = 70
    static let AST:Double = 75
    static let ALT:Double = 75
}
class FNELabData:LabCalculation {
    
    init(type:LabType) {
        super.init()
        super.metricType = type
        super.systemName = SystemName.Fluids
        switch type {
        //bloodGlucose
        case .bloodGlucose:
            self.relativeValue = FNELabRelativeImportance.bloodGlucose
        //sodium
        case .sodium:
            self.relativeValue = FNELabRelativeImportance.sodium
        //potassiumLevel
        case .potassiumLevel:
            self.relativeValue = FNELabRelativeImportance.potassiumLevel
        //BUN
        case .BUN:
            self.relativeValue = FNELabRelativeImportance.BUN
        //Creatinine
        case .creatinine:
            self.relativeValue = FNELabRelativeImportance.creatinine
        //eGFR
        case .eGFR:
            self.relativeValue = FNELabRelativeImportance.eGFR
        //albumin
        case .albumin:
            self.relativeValue = FNELabRelativeImportance.albumin
        //microalbumin
        case .microalbumin:
            self.relativeValue = FNELabRelativeImportance.microalbumin
        //carbonDioxide
        case .carbonDioxide:
            self.relativeValue = FNELabRelativeImportance.carbonDioxide
        //anionGap
        case .anionGap:
            self.relativeValue = FNELabRelativeImportance.anionGap
        //calcium
        case .calcium:
            self.relativeValue = FNELabRelativeImportance.calcium
        //chloride
        case .chloride:
            self.relativeValue = FNELabRelativeImportance.chloride
        //urineKetone
        case .urineKetone:
            self.relativeValue = FNELabRelativeImportance.urineKetone
        //MCV
        case .MCV:
            self.relativeValue = FNELabRelativeImportance.MCV
        //AST
        case .AST:
            self.relativeValue = FNELabRelativeImportance.AST
        //ALT
        case .ALT:
            self.relativeValue = FNELabRelativeImportance.ALT
        default:
            break
        }
        
        
    }
    
}

