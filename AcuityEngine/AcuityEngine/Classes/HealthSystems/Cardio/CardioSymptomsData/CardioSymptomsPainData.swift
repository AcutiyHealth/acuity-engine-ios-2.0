//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6


struct CardioSymptomsRelativeImportance {
    static let chestPain:Double = 100
    static let skippedHeartBeat:Double = 100
    static let dizziness:Double = 50
    static let fatigue:Double = 40
    static let rapidHeartbeat:Double = 100
    static let fainting:Double = 50
    static let nausea:Double = 40
    static let vomiting:Double = 40
    static let memoryLapse:Double = 30
    static let shortnessOfBreath:Double = 90
    static let headache:Double = 70
    static let heartburn:Double = 30
    static let sleepChanges:Double = 10
}

class CardioSymptomsPainData:SymptomCalculation {
   
     init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        super.systemName = SystemName.Cardiovascular
        switch type {
        case .chestTightnessOrPain:
            super.title = SymptomsName.chestPain.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.chestPain
        case .skippedHeartbeat:
            super.title = SymptomsName.skippedHeartBeat.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.skippedHeartBeat
        case .dizziness:
            super.title = SymptomsName.dizziness.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.dizziness
        case .fatigue:
            super.title = SymptomsName.fatigue.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.fatigue
        case .rapidPoundingOrFlutteringHeartbeat:
            super.title = SymptomsName.rapidHeartbeat.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.rapidHeartbeat
        case .fainting:
            super.title = SymptomsName.fainting.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.fainting
        case .nausea:
            super.title = SymptomsName.nausea.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.nausea
        case .vomiting:
            super.title = SymptomsName.vomiting.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.vomiting
        case .memoryLapse:
            super.title = SymptomsName.memoryLapse.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.memoryLapse
        case .shortnessOfBreath:
            super.title = SymptomsName.shortnessOfBreath.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.shortnessOfBreath
        case .headache:
            super.title = SymptomsName.headache.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.headache
        case .heartburn:
            super.title = SymptomsName.heartburn.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.heartburn
        case .sleepChanges:
            super.title = SymptomsName.sleepChanges.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.sleepChanges
        default:
            break
        }
       
        
    }
        
}

