//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

/*dizziness
 fatigue
 Rapid or fluttering heartbeat
 fainting
 chest pain (3
 Shortness of breath*/

struct HematoSymptomsRelativeImportance {
    static let dizziness:Double = 50
    static let fatigue:Double = 50
    static let rapidPoundingOrFlutteringHeartbeat:Double = 40
    static let fainting:Double = 40
    static let chestPain:Double = 25
    static let shortnessOfBreath:Double = 25
}

class HematoSymptomsPainData:SymptomCalculation {
   
    init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        super.systemName = SystemName.Hematology
        switch type {
        //dizziness
        case .dizziness:
            super.title = SymptomsName.dizziness.rawValue
            self.relativeValue = HematoSymptomsRelativeImportance.dizziness
        //fatigue
        case .fatigue:
            super.title = SymptomsName.fatigue.rawValue
            self.relativeValue = HematoSymptomsRelativeImportance.fatigue
        //rapidPoundingOrFlutteringHeartbeat
        case .rapidPoundingOrFlutteringHeartbeat:
            super.title = SymptomsName.rapidHeartbeat.rawValue
            self.relativeValue = HematoSymptomsRelativeImportance.rapidPoundingOrFlutteringHeartbeat
            
        //fainting
        case .fainting:
            super.title = SymptomsName.fainting.rawValue
            self.relativeValue = HematoSymptomsRelativeImportance.fainting
        //chestTightnessOrPain
        case .chestTightnessOrPain:
            super.title = SymptomsName.chestPain.rawValue
            self.relativeValue = HematoSymptomsRelativeImportance.chestPain
        //shortnessOfBreath
        case .shortnessOfBreath:
            super.title = SymptomsName.shortnessOfBreath.rawValue
            self.relativeValue = HematoSymptomsRelativeImportance.shortnessOfBreath

        default:
            break
        }
        
        
    }
    
}

