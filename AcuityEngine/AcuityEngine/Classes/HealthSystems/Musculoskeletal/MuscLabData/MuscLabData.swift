//
//  MuscLab.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//
import Foundation
import HealthKitReporter

// Available from 13.6
/*Alkaline Phosphatase
 Potassium level
 chloride
 Calcium
 ESR*/

struct MuscLabRelativeImportance {
    static let alkalinePhosphatase:Double = 70
    static let potassiumLevel:Double = 40
    static let chloride:Double = 25
    static let calcium:Double = 25
    static let ESR:Double = 90
}
class MuscLabData:LabCalculation {
    var type:LabType = .sodium{
        didSet{
            
            super.metricType = type
            switch type {
            //alkalinePhosphatase
            case .alkalinePhosphatase:
                self.relativeValue = MuscLabRelativeImportance.alkalinePhosphatase
            //potassiumLevel
            case .potassiumLevel:
                self.relativeValue = MuscLabRelativeImportance.potassiumLevel
            //chloride
            case .chloride:
                self.relativeValue = MuscLabRelativeImportance.chloride
            //calcium
            case .calcium:
                self.relativeValue = MuscLabRelativeImportance.calcium
            //ESR
            case .ESR:
                self.relativeValue = MuscLabRelativeImportance.ESR
                
            default:
                break
            }
            
            
        }
    }
    override init() {
        super.init()
        super.systemName = SystemName.Musculatory
    }
    
}

