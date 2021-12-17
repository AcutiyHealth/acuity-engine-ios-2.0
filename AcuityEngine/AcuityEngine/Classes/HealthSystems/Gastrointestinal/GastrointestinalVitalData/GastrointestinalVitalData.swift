//
//  GastrointestinalVitalsData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6
/*
 body mass index
 */
struct GastrointestinalVitalRelativeImportance {
    static let bodyMassIndex:Double = 95
    static let steps:Double = 50
    static let waterIntake:Double = 50
}

class GastrointestinalVitalsData:VitalCalculation {
    /*
     Note: Logic for Blood Sugar is remaining
     */
    
    init(type:VitalsName) {
        super.init()
        super.title = type
        super.systemName = SystemName.Gastrointestinal
        switch type {
            //bodyMassIndex
        case .BMI:
            self.relativeValue = GastrointestinalVitalRelativeImportance.bodyMassIndex
            //steps
        case .steps:
            self.relativeValue = GastrointestinalVitalRelativeImportance.steps
            
            //waterIntake
        case .waterIntake:
            self.relativeValue = GastrointestinalVitalRelativeImportance.waterIntake
            
        default:
            break
        }
        
    }
    
}

