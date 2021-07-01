//
//  SkinSymptomsPainData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

/*Acne
 Dry Skin
 Hair Loss
 chills
 fever  */

struct SkinSymptomsRelativeImportance {
    static let acne:Double = 40
    static let drySkin:Double = 40
    static let hairLoss:Double = 40
    static let chills:Double = 10
    static let fever:Double = 40
}

class SkinSymptomsPainData:SymptomCalculation {
    
    
    init(type:CategoryType) {
        super.init()
        super.symptomsType = type
        super.systemName = SystemName.Integumentary
        switch type {
        //acne
        case .acne:
            super.title = SymptomsName.acne.rawValue
            self.relativeValue = SkinSymptomsRelativeImportance.acne
        //drySkin
        case .drySkin:
            super.title = SymptomsName.drySkin.rawValue
            self.relativeValue = SkinSymptomsRelativeImportance.drySkin
            
        //hairLoss
        case .hairLoss:
            super.title = SymptomsName.hairLoss.rawValue
            self.relativeValue = SkinSymptomsRelativeImportance.hairLoss
        //chills
        case .chills:
            super.title = SymptomsName.chills.rawValue
            self.relativeValue = SkinSymptomsRelativeImportance.chills
            
        //fever
        case .fever:
            super.title = SymptomsName.fever.rawValue
            self.relativeValue = SkinSymptomsRelativeImportance.fever
         
        default:
            break
        }
        
        
    }
    
}

