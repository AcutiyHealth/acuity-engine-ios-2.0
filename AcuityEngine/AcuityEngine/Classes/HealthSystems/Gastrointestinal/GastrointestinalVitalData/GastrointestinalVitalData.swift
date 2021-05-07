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
            
        default:
            break
        }
        
    }
    
    func getStartDate()->String{
        return getDateMediumFormat(time: startTimeStamp)
    }
    func getEndDate()->String{
        return getDateMediumFormat(time: endTimeStamp)
    }
}

