//
//  MuscConditionData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import Foundation
import HealthKitReporter

struct MuscConditionRelativeImportance {
    /*Muscular Sprain/Strain
     Osteoarthritis
     Osteoporosis
     Rheumatoid Arthritis
     Gout
     Hx of Stroke
     Neuropathy*/
    static let muscularSprain:Double = 100
    static let osteoporosis:Double = 100
    static let osteoarthritis:Double = 100
    static let rheumatoidArthritis:Double = 100
    static let Gout:Double = 100
    static let HxOfStroke:Double = 60
    static let neuropathy:Double = 50
}

class MuscConditionData:ConditionCalculation {
    
    init(type:ConditionType) {
        super.init()
        super.type = type
        switch type {
        //muscularSprain
        case .muscularSprain:
            self.relativeValue = MuscConditionRelativeImportance.muscularSprain
        //osteoporosis
        case .osteoporosis:
            self.relativeValue = MuscConditionRelativeImportance.osteoporosis
        //osteoarthritis
        case .osteoarthritis:
            self.relativeValue = MuscConditionRelativeImportance.osteoarthritis
        //rheumatoidArthritis
        case .rheumatoidArthritis:
            self.relativeValue = MuscConditionRelativeImportance.rheumatoidArthritis
        //Gout
        case .Gout:
            self.relativeValue = MuscConditionRelativeImportance.Gout
        //HxOfStroke
        case .HxOfStroke:
            self.relativeValue = MuscConditionRelativeImportance.HxOfStroke
        //neuropathy
        case .neuropathy:
            self.relativeValue = MuscConditionRelativeImportance.neuropathy
            
        default:break
        }
        
    }
    
}

