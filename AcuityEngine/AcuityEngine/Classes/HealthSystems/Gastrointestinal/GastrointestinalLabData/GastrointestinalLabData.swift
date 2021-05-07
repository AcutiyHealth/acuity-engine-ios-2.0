//
//  GastrointestinalLabData.swift
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
 Potassium level
 chloride
 BUN
 Creatinine
 Albumin
 AST
 ALT
 */
struct GastrointestinalLabRelativeImportance {
    static let bloodGlucose:Double = 75
    static let sodium:Double = 60
    static let potassiumLevel:Double = 50
    static let chloride:Double = 50
    static let BUN:Double = 75
    static let creatinine:Double = 75
    static let albumin:Double = 70
    static let AST:Double = 100
    static let ALT:Double = 100
}
class GastrointestinalLabData:LabCalculation {
    
    init(type:LabType) {
        super.init()
        super.metricType = type
        super.systemName = SystemName.Gastrointestinal
        switch type {
        //bloodGlucose
        case .bloodGlucose:
            self.relativeValue = GastrointestinalLabRelativeImportance.bloodGlucose
        //sodium
        case .sodium:
            self.relativeValue = GastrointestinalLabRelativeImportance.sodium
        //potassiumLevel
        case .potassiumLevel:
            self.relativeValue = GastrointestinalLabRelativeImportance.potassiumLevel
        //chloride
        case .chloride:
            self.relativeValue = GastrointestinalLabRelativeImportance.chloride
        //BUN
        case .BUN:
            self.relativeValue = GastrointestinalLabRelativeImportance.BUN
        //creatinine
        case .creatinine:
            self.relativeValue = GastrointestinalLabRelativeImportance.creatinine
        //albumin
        case .albumin:
            self.relativeValue = GastrointestinalLabRelativeImportance.albumin
        //AST
        case .AST:
            self.relativeValue = GastrointestinalLabRelativeImportance.AST
        //ALT
        case .ALT:
            self.relativeValue = GastrointestinalLabRelativeImportance.ALT
            
        default:
            break
        }
        
        
    }
    
}

