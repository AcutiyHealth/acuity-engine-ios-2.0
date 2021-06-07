//
//  GenitourinaryLab.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//
import Foundation
import HealthKitReporter
// Available from 13.6

/*
 WBC's
 Neutrophil %
 Urine Nitrites
 Urine ketone
 Urine Blood
 */
struct GenitourinaryLabRelativeImportance {
    static let WBC:Double = 95
    static let neutrophil:Double = 95
    static let urineNitrites:Double = 100
    static let urineKetone:Double = 100
    static let urineBlood:Double = 100
}
class GenitourinaryLabData:LabCalculation {
    var type:LabType = .sodium{
        didSet{
            
            super.metricType = type
            switch type {
            //WBC
            case .WBC:
                self.relativeValue = GenitourinaryLabRelativeImportance.WBC
            //neutrophil
            case .neutrophil:
                self.relativeValue = GenitourinaryLabRelativeImportance.neutrophil
            //urineNitrites
            case .urineNitrites:
                self.relativeValue = GenitourinaryLabRelativeImportance.urineNitrites
            //urineBlood
            case .urineBlood:
                self.relativeValue = GenitourinaryLabRelativeImportance.urineBlood
            //urineKetone
            case .urineKetone:
                self.relativeValue = GenitourinaryLabRelativeImportance.urineKetone
                
            default:
                break
            }
            
            
        }
    }
    override init() {
        super.init()
        super.systemName = SystemName.Genitourinary
    }
    
}

