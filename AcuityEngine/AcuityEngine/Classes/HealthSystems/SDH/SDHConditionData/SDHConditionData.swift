//
//  SDHConditionData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import Foundation
import HealthKitReporter

struct SDHConditionRelativeImportance {
    /*Single
     Sedintary lifestyle
     unsafe Housing
     Overweight/Obesity
     Unemployed
     Smoking
     diabetes*/
    static let single:Double = 100
    static let sedintaryLifestyle:Double = 100
    static let unsafeHousing:Double = 100
    static let overweightOrObesity:Double = 75
    static let unemployed:Double = 100
    static let smoking:Double = 100
    static let diabetes:Double = 100
}

class SDHConditionData:ConditionCalculation {
    
    init(type:ConditionType) {
        super.init()
        super.type = type
        switch type {
        //single
        case .single:
            self.relativeValue = SDHConditionRelativeImportance.single
        //Sedintary
        case .sedintaryLifestyle:
            self.relativeValue = SDHConditionRelativeImportance.sedintaryLifestyle
        //unsafeHousing
        case .unsafeHousing:
            self.relativeValue = SDHConditionRelativeImportance.unsafeHousing
        //overweightOrObesity
        case .overweightOrObesity:
            self.relativeValue = SDHConditionRelativeImportance.overweightOrObesity
        //unemployed
        case .unemployed:
            self.relativeValue = SDHConditionRelativeImportance.unemployed
        //smoking
        case .smoking:
            self.relativeValue = SDHConditionRelativeImportance.smoking
        //diabetes
        case .diabetes:
            self.relativeValue = SDHConditionRelativeImportance.diabetes
            
        default:break
        }
        
    }
    
}

