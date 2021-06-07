//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

/*fatigue
 Body and Muscle Ache
 diarrhea
 nausea
 vomiting
 headache
 dizziness
 fainting
 hair loss*/
struct FNESymptomsRelativeImportance {
    static let fatigue:Double = 65
    static let generalizedBodyAche:Double = 40
    static let diarrhea:Double = 85
    
    static let nausea:Double = 35
    static let vomiting:Double = 85
    static let headache:Double = 75
    
    static let dizziness:Double = 40
    static let fainting:Double = 40
    static let hairLoss:Double = 75
}

class FNESymptomsPainData:SymptomCalculation {
   
    init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        super.systemName = SystemName.Fluids
        switch type {
        //fatigue
        case .fatigue:
            super.title = SymptomsName.fatigue.rawValue
            self.relativeValue = FNESymptomsRelativeImportance.fatigue
        //body_Ache
        case .generalizedBodyAche:
            super.title = SymptomsName.body_Ache.rawValue
            self.relativeValue = FNESymptomsRelativeImportance.generalizedBodyAche
        //diarrhea
        case .diarrhea:
            super.title = SymptomsName.diarrhea.rawValue
            self.relativeValue = FNESymptomsRelativeImportance.diarrhea
            
        //nausea
        case .nausea:
            super.title = SymptomsName.nausea.rawValue
            self.relativeValue = FNESymptomsRelativeImportance.nausea
        //vomiting
        case .vomiting:
            super.title = SymptomsName.vomiting.rawValue
            self.relativeValue = FNESymptomsRelativeImportance.vomiting
        //headache
        case .headache:
            super.title = SymptomsName.headache.rawValue
            self.relativeValue = FNESymptomsRelativeImportance.headache
            
        //dizziness
        case .dizziness:
            super.title = SymptomsName.dizziness.rawValue
            self.relativeValue = FNESymptomsRelativeImportance.dizziness
        //fainting
        case .fainting:
            super.title = SymptomsName.fainting.rawValue
            self.relativeValue = FNESymptomsRelativeImportance.fainting
        //hairLoss
        case .hairLoss:
            super.title = SymptomsName.hairLoss.rawValue
            self.relativeValue = FNESymptomsRelativeImportance.hairLoss
        default:
            break
        }
        
        
    }
    
}

