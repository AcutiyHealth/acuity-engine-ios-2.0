//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

/*Abdominal cramps
 Chest pain (4/6
 cough
 diarrhea
 constipation
 fatigue
 bloating
 nausea
 vomiting
 Heartburn*/

struct GastrointestinalSymptomsRelativeImportance {
    static let abdominalCramps:Double = 95
    static let chestPain:Double = 40
    static let cough:Double = 25
    static let diarrhea:Double = 100
    static let constipation:Double = 100
    static let fatigue:Double = 35
    static let bloating:Double = 50
    static let nausea:Double = 75
    static let vomiting:Double = 100
    static let heartburn:Double = 85
}

class GastrointestinalSymptomsPainData:SymptomCalculation {
    
    
    init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        super.systemName = SystemName.Gastrointestinal
        switch type {
        //abdominalCramps
        case .abdominalCramps:
            super.title = SymptomsName.abdominal_Cramps.rawValue
            self.relativeValue = GastrointestinalSymptomsRelativeImportance.abdominalCramps
        //chestTightnessOrPain
        case .chestTightnessOrPain:
            super.title = SymptomsName.chestPain.rawValue
            self.relativeValue = GastrointestinalSymptomsRelativeImportance.chestPain
        //coughing
        case .coughing:
            super.title = SymptomsName.cough.rawValue
            self.relativeValue = GastrointestinalSymptomsRelativeImportance.cough
            
        //diarrhea
        case .diarrhea:
            super.title = SymptomsName.diarrhea.rawValue
            self.relativeValue = GastrointestinalSymptomsRelativeImportance.diarrhea
        //constipation
        case .constipation:
            super.title = SymptomsName.constipation.rawValue
            self.relativeValue = GastrointestinalSymptomsRelativeImportance.constipation
        //fatigue
        case .fatigue:
            super.title = SymptomsName.fatigue.rawValue
            self.relativeValue = GastrointestinalSymptomsRelativeImportance.fatigue
            
        //bloating
        case .bloating:
            super.title = SymptomsName.bloating.rawValue
            self.relativeValue = GastrointestinalSymptomsRelativeImportance.bloating
        //nausea
        case .nausea:
            super.title = SymptomsName.nausea.rawValue
            self.relativeValue = GastrointestinalSymptomsRelativeImportance.nausea
        //vomiting
        case .vomiting:
            super.title = SymptomsName.vomiting.rawValue
            self.relativeValue = GastrointestinalSymptomsRelativeImportance.vomiting
        //heartburn
        case .heartburn:
            super.title = SymptomsName.heartburn.rawValue
            self.relativeValue = GastrointestinalSymptomsRelativeImportance.heartburn
            
        default:
            break
        }
        
        
    }
    
}

