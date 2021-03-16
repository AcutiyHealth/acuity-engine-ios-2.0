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
    var healthObjectType: HKObjectType?
    var bloodPressureHealthObjectType: [HKObjectType]?
    init(name:VitalsName) {
        self.name = name
        getObjectType(name: self.name)
    }
    
    func getObjectType(name:VitalsName){
    
        switch name {
        case .heartRate: do {
            healthObjectType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        }
        case .highHeartRate: do {
            healthObjectType = HKObjectType.categoryType(forIdentifier: .highHeartRateEvent)!
        }
        case .BloodPressure: do {
            healthObjectType = HKObjectType.quantityType(forIdentifier: .bloodPressureSystolic)!
        }
        case .lowHeartRate: do {
            healthObjectType = HKObjectType.categoryType(forIdentifier: .lowHeartRateEvent)!
        }
        case .vo2Max: do {
            healthObjectType = HKObjectType.quantityType(forIdentifier: .vo2Max)!
        }
        case .irregularRhymesNotification: do {
            healthObjectType = HKObjectType.categoryType(forIdentifier: .irregularHeartRhythmEvent)!
        }
        case .peakflowRate: break
           
        case .FEV1: break
            
        case .InhalerUsage:break
            
        case .Temperature:break
            
        case .BMI:break
            
        case .bloodSuger:break
            
        case .weight:break
            
        case .BloodOxygenLevel:break
            
        }
       
    }
}


    enum VitalsName:String {
        case heartRate = "Heart Rate"
        case BloodPressure = "Blood Pressure"
        case highHeartRate = "High Heart Rate"
        case lowHeartRate = "Low Heart Rate"
        case vo2Max = "VO2 Max"
        case irregularRhymesNotification = "Irregular Rhymes Notification"
        case peakflowRate = "Peak Flow  Rate(L/min) - male"
        case FEV1 = "FEV1 (L)"
        case InhalerUsage = "Inhaler usage (times/day)"
        case Temperature = "Temperature"
        case BMI = "Body Mass Index"
        case bloodSuger = "Blood Sugar"
        case weight = "Weight"
        case BloodOxygenLevel = "Blood Oxygen Level"
    }

