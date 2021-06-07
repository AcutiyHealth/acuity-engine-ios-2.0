//
//  GenitourinaryVitalsData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6
/*
 body mass index
 */
struct GenitourinaryVitalRelativeImportance {
    static let heartRate:Double = 100
    static let temprature:Double = 100
    static let bloodPressureSystolic:Double = 70
    static let bloodPressureDiastolic:Double = 70
}

class GenitourinaryVitalsData:VitalCalculation {
    /*
     Note: Logic for Blood Sugar is remaining
     */
    
    init(type:VitalsName) {
        super.init()
        super.title = type
        super.systemName = SystemName.Genitourinary
        switch type {
        //heartRate
        case .heartRate:
            self.relativeValue = GenitourinaryVitalRelativeImportance.heartRate
        //temperature
        case .temperature:
            self.relativeValue = GenitourinaryVitalRelativeImportance.temprature
        //bloodPressureSystolic
        case .bloodPressureSystolic:
            self.relativeValue = GenitourinaryVitalRelativeImportance.bloodPressureSystolic
        //bloodPressureDiastolic
        case .bloodPressureDiastolic:
            self.relativeValue = GenitourinaryVitalRelativeImportance.bloodPressureDiastolic
      
        default:
            break
        }
        
    }
    
   
}

