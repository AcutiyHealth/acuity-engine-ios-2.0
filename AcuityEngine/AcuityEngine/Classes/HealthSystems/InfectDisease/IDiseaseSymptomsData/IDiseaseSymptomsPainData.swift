//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6


struct IDiseaseSymptomsRelativeImportance {
    static let fever:Double = 100
    static let diarrhea:Double = 100
    static let fatigue:Double = 70
    static let cough:Double = 80
    static let nausea:Double = 70
    static let vomiting:Double = 70
    static let chills:Double = 100
    static let bladderIncontinence:Double = 50
    static let headache:Double = 20
    static let abdominalCramps:Double = 65
    static let shortnessofBreath:Double = 65
    static let dizziness:Double = 30
}

class IDiseaseSymptomsPainData:SymptomCalculation {
    
    init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        super.systemName = SystemName.InfectiousDisease
        switch type {
        //fever
        case .fever:
            super.title = SymptomsName.fever.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.fever
        //diarrhea
        case .diarrhea:
            super.title = SymptomsName.diarrhea.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.diarrhea
        //fatigue
        case .fatigue:
            super.title = SymptomsName.fatigue.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.fatigue
        //cough
        case .coughing:
            super.title = SymptomsName.cough.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.cough
        //nausea
        case .nausea:
            super.title = SymptomsName.nausea.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.nausea
        //vomiting
        case .vomiting:
            super.title = SymptomsName.vomiting.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.vomiting
        //chills
        case .chills:
            super.title = SymptomsName.chills.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.chills
        //bladderIncontinence
        case .bladderIncontinence:
            super.title = SymptomsName.bladder_Incontinence.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.bladderIncontinence
        //headache
        case .headache:
            super.title = SymptomsName.headache.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.headache
        //abdominalCramps
        case .abdominalCramps:
            super.title = SymptomsName.abdominal_Cramps.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.abdominalCramps
        //shortnessofBreath
        case .shortnessOfBreath:
            super.title = SymptomsName.shortnessOfBreath.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.shortnessofBreath
        //dizziness
        case .dizziness:
            super.title = SymptomsName.dizziness.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.dizziness
        default:
            break
        }
        
        
    }
    
}

