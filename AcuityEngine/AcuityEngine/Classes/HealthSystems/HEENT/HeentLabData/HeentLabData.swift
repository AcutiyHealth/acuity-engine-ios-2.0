//
//  HeentLab.swift
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

struct HeentLabRelativeImportance {
    static let WBC:Double = 40
    static let neutrophil:Double = 40
    static let platelets:Double = 15
}
class HeentLabData:LabCalculation {
    var type:LabType = .sodium{
        didSet{
            
            super.metricType = type
            switch type {
            //WBC
            case .WBC:
                self.relativeValue = HeentLabRelativeImportance.WBC
            //neutrophil
            case .neutrophil:
                self.relativeValue = HeentLabRelativeImportance.neutrophil
            //platelets
            case .platelets:
                self.relativeValue = HeentLabRelativeImportance.platelets
         
            default:
                break
            }
            
            
        }
    }
    override init() {
        super.init()
        super.systemName = SystemName.Heent
    }
    
}

