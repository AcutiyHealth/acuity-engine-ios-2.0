//
//  HeentSymptomsPainData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

/*Acne
 Dry Heent
 Hair Loss
 chills
 fever  */

struct HeentSymptomsRelativeImportance {
    static let chills:Double = 40
    static let fever:Double = 40
    static let dizziness:Double = 50
    static let fatigue:Double = 30
    static let lossOfSmell:Double = 100
    static let runnyNose:Double = 100
    static let soreThroat:Double = 100
    static let sleepChanges:Double = 30
}

class HeentSymptomsPainData:SymptomCalculation {
    
    
    init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        super.systemName = SystemName.Heent
        switch type {
        
        //fever
        case .fever:
            super.title = SymptomsName.fever.rawValue
            self.relativeValue = HeentSymptomsRelativeImportance.fever
        //chills
        case .chills:
            super.title = SymptomsName.chills.rawValue
            self.relativeValue = HeentSymptomsRelativeImportance.chills
        //dizziness
        case .dizziness:
            super.title = SymptomsName.dizziness.rawValue
            self.relativeValue = HeentSymptomsRelativeImportance.dizziness
        //fatigue
        case .fatigue:
            super.title = SymptomsName.fatigue.rawValue
            self.relativeValue = HeentSymptomsRelativeImportance.fatigue
            
        //lossOfSmell
        case .lossOfSmell:
            super.title = SymptomsName.lossOfSmell.rawValue
            self.relativeValue = HeentSymptomsRelativeImportance.lossOfSmell
        //runnyNose
        case .runnyNose:
            super.title = SymptomsName.runnyNose.rawValue
            self.relativeValue = HeentSymptomsRelativeImportance.runnyNose
            
        //soreThroat
        case .soreThroat:
            super.title = SymptomsName.soreThroat.rawValue
            self.relativeValue = HeentSymptomsRelativeImportance.soreThroat
        //sleepChanges
        case .sleepChanges:
            super.title = SymptomsName.sleepChanges.rawValue
            self.relativeValue = HeentSymptomsRelativeImportance.sleepChanges
            
        default:
            break
        }
        
        
    }
    
}

