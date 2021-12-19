//
//  MuscSymptomsPainData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

/*Chest pain (6/6
 Body and Muscle Ache
 fatigue
 lower back pain
 Mood Changes
 Sleep changes   */

struct MuscSymptomsRelativeImportance {
    static let chestPain:Double = 40
    static let bodyMuscleAche:Double = 100
    static let fatigue:Double = 70
    static let lowerBackPain:Double = 100
    static let moodChanges:Double = 40
    static let sleepChanges:Double = 30
}

class MuscSymptomsPainData:SymptomCalculation {
    
    
    init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        super.systemName = SystemName.Musculatory
        switch type {
        //chestPain
        case .chestTightnessOrPain:
            super.title = SymptomsName.chestPain.rawValue
            self.relativeValue = MuscSymptomsRelativeImportance.chestPain
        //bodyMuscleAche
        case .generalizedBodyAche:
            super.title = SymptomsName.body_Ache.rawValue
            self.relativeValue = MuscSymptomsRelativeImportance.bodyMuscleAche
            
        //fatigue
        case .fatigue:
            super.title = SymptomsName.fatigue.rawValue
            self.relativeValue = MuscSymptomsRelativeImportance.fatigue
        //lowerBackPain
        case .lowerBackPain:
            super.title = SymptomsName.lowerBackPain.rawValue
            self.relativeValue = MuscSymptomsRelativeImportance.lowerBackPain
            
        //moodChanges
        case .moodChanges:
            super.title = SymptomsName.moodChanges.rawValue
            self.relativeValue = MuscSymptomsRelativeImportance.moodChanges
            
        //sleepChanges
        case .sleepChanges:
            super.title = SymptomsName.sleepChanges.rawValue
            self.relativeValue = MuscSymptomsRelativeImportance.sleepChanges
            
        default:
            break
        }
        
        
    }
    
}

