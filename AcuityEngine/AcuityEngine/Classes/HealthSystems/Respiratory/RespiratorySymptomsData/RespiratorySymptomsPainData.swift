//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6


struct RespiratorySymptomsRelativeImportance {
    static let chestPain:Double = 40
    static let rapidHeartbeat:Double = 30
    static let cough:Double = 60
    static let fainting:Double = 25
    static let shortnessOfBreath:Double = 60
    static let runnyNose:Double = 100
    static let soreThroat:Double = 100
    static let fever:Double = 40
    static let chills:Double = 40
}

class RespiratorySymptomsPainData:SymptomCalculation {
   
    var title:String = ""

     init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        super.systemName = SystemName.Respiratory
        switch type {
        case .chestTightnessOrPain:
            self.title = SymptomsName.chestPain.rawValue
            self.relativeValue = RespiratorySymptomsRelativeImportance.chestPain
        case .rapidPoundingOrFlutteringHeartbeat:
            self.title = SymptomsName.rapidHeartbeat.rawValue
            self.relativeValue = RespiratorySymptomsRelativeImportance.rapidHeartbeat
        case .coughing:
            self.title = SymptomsName.cough.rawValue
            self.relativeValue = RespiratorySymptomsRelativeImportance.cough
        case .fainting:
            self.title = SymptomsName.fainting.rawValue
            self.relativeValue = RespiratorySymptomsRelativeImportance.fainting
        case .shortnessOfBreath:
            self.title = SymptomsName.shortnessOfBreath.rawValue
            self.relativeValue = RespiratorySymptomsRelativeImportance.shortnessOfBreath
        case .runnyNose:
            self.title = SymptomsName.runnyNose.rawValue
            self.relativeValue = RespiratorySymptomsRelativeImportance.runnyNose
        case .soreThroat:
            self.title = SymptomsName.soreThroat.rawValue
            self.relativeValue = RespiratorySymptomsRelativeImportance.soreThroat
        case .fever:
            self.title = SymptomsName.fever.rawValue
            self.relativeValue = RespiratorySymptomsRelativeImportance.fever
        case .chills:
            self.title = SymptomsName.chills.rawValue
            self.relativeValue = RespiratorySymptomsRelativeImportance.chills

        default:
            break
        }
       
        
    }
        
}

