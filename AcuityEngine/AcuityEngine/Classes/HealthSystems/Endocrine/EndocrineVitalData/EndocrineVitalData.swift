//
//  EndocrineVitalsData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6
/*
 S Blood pressure
 D Blood pressure
 body mass index
 Temperature
 */
struct EndocrineVitalRelativeImportance {
    static let bloodPressureSystolic:Double = 70
    static let bloodPressureDiastolic:Double = 70
    static let heartRate:Double = 50
    static let bloodSugar:Double = 100
    static let temperature:Double = 50
}

class EndocrineVitalsData:VitalCalculation {
    /*
     Note: Logic for Blood Sugar is remaining
     */
    
    init(type:VitalsName) {
        super.init()
        super.title = type
        super.systemName = SystemName.Endocrine
        switch type {
        //bloodPressureSystolic
        case .bloodPressureSystolic:
            self.relativeValue = EndocrineVitalRelativeImportance.bloodPressureSystolic
        //bloodPressureDiastolic
        case .bloodPressureDiastolic:
            self.relativeValue = EndocrineVitalRelativeImportance.bloodPressureDiastolic
        //heartRate
        case .heartRate:
            self.relativeValue = EndocrineVitalRelativeImportance.heartRate
        //bloodSugar
        case .bloodSugar:
            self.relativeValue = EndocrineVitalRelativeImportance.bloodSugar
        //temperature
        case .temperature:
            self.relativeValue = EndocrineVitalRelativeImportance.temperature
            
        default:break
        }
        
    }
    
  
}

