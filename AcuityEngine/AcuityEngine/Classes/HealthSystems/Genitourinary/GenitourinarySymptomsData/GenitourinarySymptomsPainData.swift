//
//  GenitourinarySymptomsPainData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

/*    fever
 bladder incontinence
 Abdominal cramps
 dizziness
 fatigue
 nausea
 vomiting
 chills
 bloating*/

struct GenitourinarySymptomsRelativeImportance {
    static let fever:Double = 40
    static let bladderIncontinence:Double = 100
    static let abdominalCramps:Double = 50
    static let dizziness:Double = 20
    static let fatigue:Double = 35
    static let nausea:Double = 60
    static let vomiting:Double = 60
    static let chills:Double = 75
    static let bloating:Double = 50
}

class GenitourinarySymptomsPainData:SymptomCalculation {
    
    
    init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        super.systemName = SystemName.Genitourinary
        switch type {
        //fever
        case .fever:
            super.title = SymptomsName.fever.rawValue
            self.relativeValue = GenitourinarySymptomsRelativeImportance.fever
        //bladderIncontinence
        case .bladderIncontinence:
            super.title = SymptomsName.bladder_Incontinence.rawValue
            self.relativeValue = GenitourinarySymptomsRelativeImportance.bladderIncontinence
        //abdominalCramps
        case .abdominalCramps:
            super.title = SymptomsName.abdominal_Cramps.rawValue
            self.relativeValue = GenitourinarySymptomsRelativeImportance.abdominalCramps
            
        //dizziness
        case .dizziness:
            super.title = SymptomsName.dizziness.rawValue
            self.relativeValue = GenitourinarySymptomsRelativeImportance.dizziness
            
        //fatigue
        case .fatigue:
            super.title = SymptomsName.fatigue.rawValue
            self.relativeValue = GenitourinarySymptomsRelativeImportance.fatigue
            
        //nausea
        case .nausea:
            super.title = SymptomsName.nausea.rawValue
            self.relativeValue = GenitourinarySymptomsRelativeImportance.nausea
        //vomiting
        case .vomiting:
            super.title = SymptomsName.vomiting.rawValue
            self.relativeValue = GenitourinarySymptomsRelativeImportance.vomiting
            
        //chills
        case .chills:
            super.title = SymptomsName.chills.rawValue
            self.relativeValue = GenitourinarySymptomsRelativeImportance.chills
        //bloating
        case .bloating:
            super.title = SymptomsName.bloating.rawValue
            self.relativeValue = GenitourinarySymptomsRelativeImportance.bloating
            
            
        default:
            break
        }
        
        
    }
    
}

