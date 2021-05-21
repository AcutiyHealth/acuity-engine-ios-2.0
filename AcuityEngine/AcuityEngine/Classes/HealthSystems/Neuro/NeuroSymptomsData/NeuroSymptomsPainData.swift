//
//  NeuroSymptomsPainData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

/* Mood Changes
 dizziness
 Body and Muscle Ache
 fatigue
 fainting
 nausea
 vomiting
 Memory lapse
 Headache
 Sleep changes */

struct NeuroSymptomsRelativeImportance {
    static let moodChanges:Double = 100
    static let dizziness:Double = 95
    static let bodyAndMuscleAche:Double = 25
    static let fatigue:Double = 40
    static let fainting:Double = 75
    static let nausea:Double = 30
    static let vomiting:Double = 10
    static let memoryLapse:Double = 80
    static let headache:Double = 95
    static let sleepChanges:Double = 65
}

class NeuroSymptomsPainData:SymptomCalculation {
    
    
    init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        super.systemName = SystemName.Nuerological
        switch type {
        //moodChanges
        case .moodChanges:
            super.title = SymptomsName.moodChanges.rawValue
            self.relativeValue = NeuroSymptomsRelativeImportance.moodChanges
        //dizziness
        case .dizziness:
            super.title = SymptomsName.dizziness.rawValue
            self.relativeValue = NeuroSymptomsRelativeImportance.dizziness
        //generalizedBodyAche
        case .generalizedBodyAche:
            super.title = SymptomsName.body_Ache.rawValue
            self.relativeValue = NeuroSymptomsRelativeImportance.bodyAndMuscleAche
        //fatigue
        case .fatigue:
            super.title = SymptomsName.fatigue.rawValue
            self.relativeValue = NeuroSymptomsRelativeImportance.fatigue
            
        //fainting
        case .fainting:
            super.title = SymptomsName.fainting.rawValue
            self.relativeValue = NeuroSymptomsRelativeImportance.fainting
            
        //nausea
        case .nausea:
            super.title = SymptomsName.nausea.rawValue
            self.relativeValue = NeuroSymptomsRelativeImportance.nausea
        //vomiting
        case .vomiting:
            super.title = SymptomsName.vomiting.rawValue
            self.relativeValue = NeuroSymptomsRelativeImportance.vomiting
            
        //memoryLapse
        case .memoryLapse:
            super.title = SymptomsName.memoryLapse.rawValue
            self.relativeValue = NeuroSymptomsRelativeImportance.memoryLapse
        //headache
        case .headache:
            super.title = SymptomsName.headache.rawValue
            self.relativeValue = NeuroSymptomsRelativeImportance.headache
        //sleepChanges
        case .sleepChanges:
            super.title = SymptomsName.sleepChanges.rawValue
            self.relativeValue = NeuroSymptomsRelativeImportance.sleepChanges
            
        default:
            break
        }
        
        
    }
    
}

