//
//  NeuroLab.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//
import Foundation
import HealthKitReporter
// Available from 13.6

/*
 Vitamin B12
 Sodium
 carbon dioxide
 */
struct NeuroLabRelativeImportance {
    static let vitaminB12:Double = 100
    static let sodium:Double = 35
    static let carbonDioxide:Double = 35
}
class NeuroLabData:LabCalculation {
    var type:LabType = .sodium{
        didSet{
            
            super.metricType = type
            switch type {
            //vitaminB12
            case .vitaminB12:
                self.relativeValue = NeuroLabRelativeImportance.vitaminB12
            //sodium
            case .sodium:
                self.relativeValue = NeuroLabRelativeImportance.sodium
            //carbonDioxide
            case .carbonDioxide:
                self.relativeValue = NeuroLabRelativeImportance.carbonDioxide
        
            default:
                break
            }
            
            
        }
    }
    override init() {
        super.init()
        super.systemName = SystemName.Nuerological
    }
    
}

