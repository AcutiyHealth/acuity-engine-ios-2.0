//
//  SDHSymptomsPainData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

/*Chest pain (5/6
 dizziness
 fatigue
 Rapid or fluttering heartbeat
 Memory lapse
 Shortness of breath
 Headache
 Sleep changes  */

struct SDHSymptomsRelativeImportance {
    static let chestPain:Double = 40
    static let dizziness:Double = 40
    static let fatigue:Double = 40
    static let rapidHeartbeat:Double = 70
    static let memoryLapse:Double = 90
    static let shortnessOfBreath:Double = 80
    static let headache:Double = 50
    static let sleepChanges:Double = 30
}

class SDHSymptomsPainData:SymptomCalculation {
    
    
    init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        super.systemName = SystemName.SocialDeterminantsofHealth
        switch type {
        //chestPain
        case .chestTightnessOrPain:
            super.title = SymptomsName.chestPain.rawValue
            self.relativeValue = SDHSymptomsRelativeImportance.chestPain
        //dizziness
        case .dizziness:
            super.title = SymptomsName.dizziness.rawValue
            self.relativeValue = SDHSymptomsRelativeImportance.dizziness
            
        //fatigue
        case .fatigue:
            super.title = SymptomsName.fatigue.rawValue
            self.relativeValue = SDHSymptomsRelativeImportance.fatigue
        //rapidPoundingOrFlutteringHeartbeat
        case .rapidPoundingOrFlutteringHeartbeat:
            super.title = SymptomsName.rapidHeartbeat.rawValue
            self.relativeValue = SDHSymptomsRelativeImportance.rapidHeartbeat
            
        //memoryLapse
        case .memoryLapse:
            super.title = SymptomsName.memoryLapse.rawValue
            self.relativeValue = SDHSymptomsRelativeImportance.memoryLapse
        //shortnessOfBreath
        case .shortnessOfBreath:
            super.title = SymptomsName.shortnessOfBreath.rawValue
            self.relativeValue = SDHSymptomsRelativeImportance.shortnessOfBreath
            
        //headache
        case .headache:
            super.title = SymptomsName.headache.rawValue
            self.relativeValue = SDHSymptomsRelativeImportance.headache
        //sleepChanges
        case .sleepChanges:
            super.title = SymptomsName.sleepChanges.rawValue
            self.relativeValue = SDHSymptomsRelativeImportance.sleepChanges
            
        default:
            break
        }
        
        
    }
    
}

