//
//  VitalModel.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 09/03/21.
//

import Foundation
import HealthKit

class VitalModel
{
    
    var name: VitalsName!
    var healthQuantityType: HKQuantityTypeIdentifier?
    var healthCategoryType: HKCategoryTypeIdentifier?
    
    init(name:VitalsName) {
        self.name = name
        getObjectType(name: self.name)
    }
    
    func getObjectType(name:VitalsName){
        
        switch name {
        case .heartRate: do {
            healthQuantityType =  .heartRate
        }
        case .highHeartRate: do {
            healthCategoryType = .highHeartRateEvent
        }
        case .BloodPressure: do {
            healthQuantityType = .bloodPressureSystolic
        }
        case .BloodPressureDiastolic: do {
            healthQuantityType = .bloodPressureDiastolic
        }
        case .lowHeartRate: do {
            healthCategoryType = .lowHeartRateEvent
        }
        case .vo2Max: do {
            healthQuantityType = .vo2Max
        }
        case .irregularRhymesNotification: do {
            healthCategoryType = .irregularHeartRhythmEvent
        }
        case .peakflowRate:
            healthQuantityType = .peakExpiratoryFlowRate
            
            
        case .InhalerUsage:
            healthQuantityType = .inhalerUsage
            
        case .Temperature:
            healthQuantityType = .bodyTemperature
            
        case .BMI:
            healthQuantityType = .bodyMassIndex
            
        case .bloodSuger:
            healthQuantityType = .bloodGlucose
            
        case .weight:
            healthQuantityType = .bodyMass
        case .OxygenSaturation:
            healthQuantityType = .oxygenSaturation
        case .respiratoryRate:
            healthQuantityType = .respiratoryRate
        case .stepLength:
            if #available(iOS 14.0, *) {
                healthQuantityType = .walkingStepLength
            } else {
                // Fallback on earlier versions
                break
            }
        case .headPhoneAudioLevel:
            healthQuantityType = .headphoneAudioExposure
            
        }
    }
}


enum VitalsName:String {
    case heartRate = "Heart Rate"
    case BloodPressure = "Blood Pressure"
    case BloodPressureDiastolic = "Blood Pressure Diastolic"
    case highHeartRate = "High Heart Rate"
    case lowHeartRate = "Low Heart Rate"
    case vo2Max = "VO2 Max"
    case irregularRhymesNotification = "Irregular Rhymes Notification"
    case respiratoryRate = "Respiratory Rate (breaths/min)"
    case peakflowRate = "Peak Flow  Rate(L/min) - male"
    case InhalerUsage = "Inhaler usage (times/day)"
    case Temperature = "Temperature"
    case BMI = "Body Mass Index"
    case bloodSuger = "Blood Sugar"
    case weight = "Weight"
    case OxygenSaturation = "Oxygen saturation"
    case stepLength = "Step Length"
    case headPhoneAudioLevel = "Headphone Audio Levels"
}

