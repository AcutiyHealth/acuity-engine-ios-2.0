//
//  SkinConditionData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import Foundation
import HealthKitReporter

struct SkinConditionRelativeImportance {
    /*Rash/Acne
     Psoriasis/Eczema
     Cellulitis
     diabetes*/
    static let rashOrAcne:Double = 100
    static let psoriasisEczema:Double = 100
    static let cellulitis:Double = 100
    static let diabetes:Double = 70
}

class SkinConditionData:ConditionCalculation {
    
    init(type:ConditionType) {
        super.init()
        super.type = type
        switch type {
        //rashOrAcne
        case .rashOrAcne:
            self.relativeValue = SkinConditionRelativeImportance.rashOrAcne
        //psoriasisEczema
        case .psoriasisEczema:
            self.relativeValue = SkinConditionRelativeImportance.psoriasisEczema
        //cellulitis
        case .cellulitis:
            self.relativeValue = SkinConditionRelativeImportance.cellulitis
        //diabetes
        case .diabetes:
            self.relativeValue = SkinConditionRelativeImportance.diabetes
            
        default:break
        }
        
    }
    
}

