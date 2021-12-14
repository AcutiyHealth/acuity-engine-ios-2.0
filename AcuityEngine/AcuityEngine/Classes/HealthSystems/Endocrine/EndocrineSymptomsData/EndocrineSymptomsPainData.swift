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
 hot flashes
 fainting
 Hair loss
 nausea
 vomiting
 Dry Skin*/

struct EndocrineSymptomsRelativeImportance {
    static let dizziness:Double = 40
    static let fatigue:Double = 100
    static let rapidPoundingOrFlutteringHeartbeat:Double = 70
    static let hotFlashes:Double = 100
    static let fainting:Double = 35
    static let hairLoss:Double = 100
    static let nausea:Double = 60
    static let vomiting:Double = 10
    static let drySkin:Double =  100
}

class EndocrineSymptomsPainData:SymptomCalculation {
    
    init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        super.systemName = SystemName.Endocrine
        switch type {
        //dizziness
        case .dizziness:
            super.title = SymptomsName.dizziness.rawValue
            self.relativeValue = EndocrineSymptomsRelativeImportance.dizziness
        //fatigue
        case .fatigue:
            super.title = SymptomsName.fatigue.rawValue
            self.relativeValue = EndocrineSymptomsRelativeImportance.fatigue
        //rapidPoundingOrFlutteringHeartbeat
        case .rapidPoundingOrFlutteringHeartbeat:
            super.title = SymptomsName.rapidHeartbeat.rawValue
            self.relativeValue = EndocrineSymptomsRelativeImportance.rapidPoundingOrFlutteringHeartbeat
            
        //hotFlashes
        case .hotFlashes:
            super.title = SymptomsName.hotFlashes.rawValue
            self.relativeValue = EndocrineSymptomsRelativeImportance.hotFlashes
        //fainting
        case .fainting:
            super.title = SymptomsName.fainting.rawValue
            self.relativeValue = EndocrineSymptomsRelativeImportance.fainting
        //hairLoss
        case .hairLoss:
            super.title = SymptomsName.hairLoss.rawValue
            self.relativeValue = EndocrineSymptomsRelativeImportance.hairLoss

        //nausea
        case .nausea:
            super.title = SymptomsName.nausea.rawValue
            self.relativeValue = EndocrineSymptomsRelativeImportance.nausea
        //vomiting
        case .vomiting:
            super.title = SymptomsName.vomiting.rawValue
            self.relativeValue = EndocrineSymptomsRelativeImportance.vomiting
        //drySkin
        case .drySkin:
            super.title = SymptomsName.drySkin.rawValue
            self.relativeValue = EndocrineSymptomsRelativeImportance.drySkin

        default:
            break
        }
        
        
    }
    
}

