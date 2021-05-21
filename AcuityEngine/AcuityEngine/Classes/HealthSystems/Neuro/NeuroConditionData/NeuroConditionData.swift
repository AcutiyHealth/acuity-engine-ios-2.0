//
//  NeuroConditionData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import Foundation
import HealthKitReporter

struct NeuroConditionRelativeImportance {
    /*UTI
     Urinary problems
     kidney stones
     chronic kidney disease
     diabetes*/
    static let depressionAnxiety:Double = 100
    static let bipolarDisorder:Double = 100
    static let HxOfStroke:Double = 100
    static let memoryLoss:Double = 100
    static let neuropathy:Double = 100
    static let diabetes:Double = 85
    static let hypertension:Double = 85
    static let arrhythmia:Double = 35
    static let coronaryArteryDisease:Double = 75
}

class NeuroConditionData:ConditionCalculation {
    
    init(type:ConditionType) {
        super.init()
        super.type = type
        switch type {
        //depressionAnxiety
        case .depressionAnxiety:
            self.relativeValue = NeuroConditionRelativeImportance.depressionAnxiety
        //bipolarDisorder
        case .bipolarDisorder:
            self.relativeValue = NeuroConditionRelativeImportance.bipolarDisorder
        //HxOfStroke
        case .HxOfStroke:
            self.relativeValue = NeuroConditionRelativeImportance.HxOfStroke
        //memoryLoss
        case .memoryLoss:
            self.relativeValue = NeuroConditionRelativeImportance.memoryLoss
        //neuropathy
        case .neuropathy:
            self.relativeValue = NeuroConditionRelativeImportance.neuropathy
        //diabetes
        case .diabetes:
            self.relativeValue = NeuroConditionRelativeImportance.diabetes
        //hypertension
        case .hypertension:
            self.relativeValue = NeuroConditionRelativeImportance.hypertension
        //arrhythmia
        case .arrhythmia:
            self.relativeValue = NeuroConditionRelativeImportance.arrhythmia
        //coronaryArteryDisease
        case .coronaryArteryDisease:
            self.relativeValue = NeuroConditionRelativeImportance.coronaryArteryDisease
        default:break
        }
        
    }
    
}

