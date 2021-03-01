//
//  RespiratorySymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

class RespiratoryLabData:RespiratoryLabCalculation {
    override var value:Double{
        didSet{
            super.value = value
        }
    }
    
     init(type:RespiratoryLabsType) {
        super.init()
        super.symptomsType = type
        switch type {
        case .bicarbonate:
            self.relativeValue = 40
        case .PaO2:
            self.relativeValue = 80
        case .PaCO2:
            self.relativeValue = 30
        case .bloodOxygenLevel:
            self.relativeValue = 20
        case .HCO3:
            self.relativeValue = 40
        case .O2:
            self.relativeValue = 50
        
        }
       
        
    }
        
}

