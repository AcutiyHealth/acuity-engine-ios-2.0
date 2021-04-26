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
    static let chestPain:Double = 50
    static let skippedHeartBeat:Double = 40
    static let dizziness:Double = 20
    static let fatigue:Double = 40
    static let rapidHeartbeat:Double = 40
    static let fainting:Double = 40
    static let nausea:Double = 40
    static let vomiting:Double = 10
    static let memoryLapse:Double = 5
    static let shortnessOfBreath:Double = 40
    static let headache:Double = 30
    static let heartburn:Double = 10
    static let sleepChanges:Double = 5
}

class CardioSymptomsPainData:SymptomCalculation {
   
    var title:String = ""

     init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        super.systemName = SystemName.Cardiovascular
        switch type {
        case .chestTightnessOrPain:
            self.title = SymptomsName.chestPain.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.chestPain
        case .skippedHeartbeat:
            self.title = SymptomsName.skippedHeartBeat.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.skippedHeartBeat
        case .dizziness:
            self.title = SymptomsName.dizziness.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.dizziness
        case .fatigue:
            self.title = SymptomsName.fatigue.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.fatigue
        case .rapidPoundingOrFlutteringHeartbeat:
            self.title = SymptomsName.rapidHeartbeat.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.rapidHeartbeat
        case .fainting:
            self.title = SymptomsName.fainting.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.fainting
        case .nausea:
            self.title = SymptomsName.nausea.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.nausea
        case .vomiting:
            self.title = SymptomsName.vomiting.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.vomiting
        case .memoryLapse:
            self.title = SymptomsName.memoryLapse.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.memoryLapse
        case .shortnessOfBreath:
            self.title = SymptomsName.shortnessOfBreath.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.shortnessOfBreath
        case .headache:
            self.title = SymptomsName.headache.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.headache
        case .heartburn:
            self.title = SymptomsName.heartburn.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.heartburn
        case .sleepChanges:
            self.title = SymptomsName.sleepChanges.rawValue
            self.relativeValue = CardioSymptomsRelativeImportance.sleepChanges
        default:
            break
        }
       
        
    }
        
}

