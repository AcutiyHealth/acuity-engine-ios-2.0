//
//  SkinLab.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//
import Foundation
import HealthKitReporter

// Available from 13.6
/*WBC's
 Neutrophil %
 ESR*/

struct SkinLabRelativeImportance {
    static let WBC:Double = 40
    static let neutrophil:Double = 40
    static let ESR:Double = 50
}
class SkinLabData:LabCalculation {
    var type:LabType = .sodium{
        didSet{
            
            super.metricType = type
            switch type {
            //WBC
            case .WBC:
                self.relativeValue = SkinLabRelativeImportance.WBC
            //neutrophil
            case .neutrophil:
                self.relativeValue = SkinLabRelativeImportance.neutrophil
            //ESR
            case .ESR:
                self.relativeValue = SkinLabRelativeImportance.ESR
         
            default:
                break
            }
            
            
        }
    }
    override init() {
        super.init()
        super.systemName = SystemName.Integumentary
    }
    
}

