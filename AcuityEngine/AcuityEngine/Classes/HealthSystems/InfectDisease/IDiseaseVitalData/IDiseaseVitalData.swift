//
//  IDiseaseVitalsData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

struct IDiseaseVitalRelativeImportance {
    static let temprature:Double = 100
    static let heartRate:Double = 70
    static let oxygenSaturation:Double = 80
    static let bloodPressureSystolic:Double = 70
    static let bloodPressureDiastolic:Double = 70
  }

class IDiseaseVitalsData:VitalCalculation {
    
    
    init(type:VitalsName) {
        super.init()
        super.title = type
        switch type {
        case .bloodPressureSystolic:
            self.relativeValue = IDiseaseVitalRelativeImportance.bloodPressureSystolic
        case .bloodPressureDiastolic:
            self.relativeValue = IDiseaseVitalRelativeImportance.bloodPressureDiastolic
        case .Temperature:
            self.relativeValue = IDiseaseVitalRelativeImportance.temprature
        case .heartRate:
            self.relativeValue = IDiseaseVitalRelativeImportance.heartRate
        case .oxygenSaturation:
            self.relativeValue = IDiseaseVitalRelativeImportance.oxygenSaturation
        default:break
        }
        
        
    }
    
    func getStartDate()->String{
        return getDateMediumFormat(time: startTimeStamp)
    }
    func getEndDate()->String{
        return getDateMediumFormat(time: endTimeStamp)
    }
}

