//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6


struct RenalSymptomsRelativeImportance {

    static let rapidHeartbeat:Double = 30
    static let lowerBackPain:Double = 50
    static let dizziness:Double = 20
    static let fatigue:Double = 30
    static let fainting:Double = 20
    static let nausea:Double = 30
    static let vomiting:Double = 30
}

class RenalSymptomsPainData:SymptomCalculation {
   
     init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        super.systemName = SystemName.Renal
        switch type {
        case .rapidPoundingOrFlutteringHeartbeat:
            super.title = SymptomsName.rapidHeartbeat.rawValue
            self.relativeValue = RenalSymptomsRelativeImportance.rapidHeartbeat
        case .lowerBackPain:
            super.title = SymptomsName.lowerBackPain.rawValue
            self.relativeValue = RenalSymptomsRelativeImportance.lowerBackPain
        case .dizziness:
            super.title = SymptomsName.dizziness.rawValue
            self.relativeValue = RenalSymptomsRelativeImportance.dizziness
        case .fainting:
            super.title = SymptomsName.fainting.rawValue
            self.relativeValue = RenalSymptomsRelativeImportance.fainting
        case .fatigue:
            super.title = SymptomsName.fatigue.rawValue
            self.relativeValue = RenalSymptomsRelativeImportance.fatigue
        case .nausea:
            super.title = SymptomsName.nausea.rawValue
            self.relativeValue = RenalSymptomsRelativeImportance.nausea
        case .vomiting:
            super.title = SymptomsName.vomiting.rawValue
            self.relativeValue = RenalSymptomsRelativeImportance.vomiting
  
        default:
            break
        }
       
        
    }
        
}

