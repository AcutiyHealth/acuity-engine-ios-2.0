//
//  HeentVitalsData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6
/*
 Headphone Audio Levels
 Temperature
 Oxygen saturation
 Inhaler usage (times/day)
 */
struct HeentVitalRelativeImportance {
    static let headPhoneAudioLevel:Double = 80
    static let temperature:Double = 100
    static let oxygenSaturation:Double = 80
    //static let InhalerUsage:Double = 20
}

class HeentVitalsData:VitalCalculation {
    
    init(type:VitalsName) {
        super.init()
        super.title = type
        super.systemName = SystemName.Heent
        switch type {
        //headPhoneAudioLevel
        case .headPhoneAudioLevel:
            self.relativeValue = HeentVitalRelativeImportance.headPhoneAudioLevel
        //temperature
        case .temperature:
            self.relativeValue = HeentVitalRelativeImportance.temperature
        //oxygenSaturation
        case .oxygenSaturation:
            self.relativeValue = HeentVitalRelativeImportance.oxygenSaturation
        
        default:
            break
        }
        
    }
    
    
}

