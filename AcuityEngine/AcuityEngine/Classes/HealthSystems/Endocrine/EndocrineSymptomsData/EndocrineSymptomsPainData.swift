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
    static let fatigue:Double = 75
    static let rapidPoundingOrFlutteringHeartbeat:Double = 50
    static let hotFlashes:Double = 95
    static let fainting:Double = 35
    static let hairLoss:Double = 75
    static let nausea:Double = 30
    static let vomiting:Double = 10
    static let drySkin:Double = 40
}

class EndocrineSymptomsPainData:SymptomCalculation {
    
    var title:String = ""
    
    init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        super.systemName = SystemName.Endocrine
        switch type {
        //dizziness
        case .dizziness:
            self.title = SymptomsName.dizziness.rawValue
            self.relativeValue = EndocrineSymptomsRelativeImportance.dizziness
        //fatigue
        case .fatigue:
            self.title = SymptomsName.fatigue.rawValue
            self.relativeValue = EndocrineSymptomsRelativeImportance.fatigue
        //rapidPoundingOrFlutteringHeartbeat
        case .rapidPoundingOrFlutteringHeartbeat:
            self.title = SymptomsName.rapidHeartbeat.rawValue
            self.relativeValue = EndocrineSymptomsRelativeImportance.rapidPoundingOrFlutteringHeartbeat
            
        //hotFlashes
        case .hotFlashes:
            self.title = SymptomsName.hotFlashes.rawValue
            self.relativeValue = EndocrineSymptomsRelativeImportance.hotFlashes
        //fainting
        case .fainting:
            self.title = SymptomsName.fainting.rawValue
            self.relativeValue = EndocrineSymptomsRelativeImportance.fainting
        //hairLoss
        case .hairLoss:
            self.title = SymptomsName.hairLoss.rawValue
            self.relativeValue = EndocrineSymptomsRelativeImportance.hairLoss

        //nausea
        case .nausea:
            self.title = SymptomsName.nausea.rawValue
            self.relativeValue = EndocrineSymptomsRelativeImportance.nausea
        //vomiting
        case .vomiting:
            self.title = SymptomsName.vomiting.rawValue
            self.relativeValue = EndocrineSymptomsRelativeImportance.vomiting
        //drySkin
        case .drySkin:
            self.title = SymptomsName.drySkin.rawValue
            self.relativeValue = EndocrineSymptomsRelativeImportance.drySkin

        default:
            break
        }
        
        
    }
    
}

