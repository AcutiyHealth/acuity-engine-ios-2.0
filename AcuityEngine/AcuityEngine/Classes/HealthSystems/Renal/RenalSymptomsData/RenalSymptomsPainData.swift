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
   
    var title:String = ""

     init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        switch type {
        case .rapidPoundingOrFlutteringHeartbeat:
            self.title = SymptomsName.rapidHeartbeat.rawValue
            self.relativeValue = RenalSymptomsRelativeImportance.rapidHeartbeat
        case .lowerBackPain:
            self.title = SymptomsName.lowerBackPain.rawValue
            self.relativeValue = RenalSymptomsRelativeImportance.lowerBackPain
        case .dizziness:
            self.title = SymptomsName.dizziness.rawValue
            self.relativeValue = RenalSymptomsRelativeImportance.dizziness
        case .fainting:
            self.title = SymptomsName.fainting.rawValue
            self.relativeValue = RenalSymptomsRelativeImportance.fainting
        case .fatigue:
            self.title = SymptomsName.fatigue.rawValue
            self.relativeValue = RenalSymptomsRelativeImportance.fatigue
        case .nausea:
            self.title = SymptomsName.nausea.rawValue
            self.relativeValue = RenalSymptomsRelativeImportance.nausea
        case .vomiting:
            self.title = SymptomsName.vomiting.rawValue
            self.relativeValue = RenalSymptomsRelativeImportance.vomiting
  
        default:
            break
        }
       
        
    }
        
}

