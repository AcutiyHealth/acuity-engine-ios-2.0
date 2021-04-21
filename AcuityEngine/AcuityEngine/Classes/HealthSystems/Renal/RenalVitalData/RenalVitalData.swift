//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

struct RenalVitalRelativeImportance {
    static let bloodPressureSystolic:Double = 70
    static let bloodPressureDiastolic:Double = 70
}

class RenalVitalsData:VitalCalculation {
    
    
    init(type:VitalsName) {
        super.init()
        super.title = type
        switch type {
        case .bloodPressureSystolic:
            self.relativeValue = RenalVitalRelativeImportance.bloodPressureSystolic
        case .bloodPressureDiastolic:
            self.relativeValue = RenalVitalRelativeImportance.bloodPressureDiastolic
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

