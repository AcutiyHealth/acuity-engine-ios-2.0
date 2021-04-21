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
    static let fever:Double = 80
    static let diarrhea:Double = 80
    static let fatigue:Double = 50
    static let cough:Double = 80
    static let nausea:Double = 70
    static let vomiting:Double = 70
    static let chills:Double = 80
    static let bladderIncontinence:Double = 50
    static let headache:Double = 20
    static let abdominalCramps:Double = 65
    static let shortnessofBreath:Double = 65
    static let dizziness:Double = 30
}

class IDiseaseSymptomsPainData:SymptomCalculation {
    
    var title:String = ""
    
    init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        switch type {
        //fever
        case .fever:
            self.title = SymptomsName.fever.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.fever
        //diarrhea
        case .diarrhea:
            self.title = SymptomsName.diarrhea.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.diarrhea
        //fatigue
        case .fatigue:
            self.title = SymptomsName.fatigue.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.fatigue
        //cough
        case .coughing:
            self.title = SymptomsName.cough.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.cough
        //nausea
        case .nausea:
            self.title = SymptomsName.nausea.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.nausea
        //vomiting
        case .vomiting:
            self.title = SymptomsName.vomiting.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.vomiting
        //chills
        case .chills:
            self.title = SymptomsName.chills.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.chills
        //bladderIncontinence
        case .bladderIncontinence:
            self.title = SymptomsName.bladder_Incontinence.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.bladderIncontinence
        //headache
        case .headache:
            self.title = SymptomsName.headache.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.headache
        //abdominalCramps
        case .abdominalCramps:
            self.title = SymptomsName.abdominal_Cramps.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.abdominalCramps
        //shortnessofBreath
        case .shortnessOfBreath:
            self.title = SymptomsName.shortnessOfBreath.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.shortnessofBreath
        //dizziness
        case .dizziness:
            self.title = SymptomsName.dizziness.rawValue
            self.relativeValue = IDiseaseSymptomsRelativeImportance.dizziness
        default:
            break
        }
        
        
    }
    
}

