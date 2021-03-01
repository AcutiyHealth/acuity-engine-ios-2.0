//
//  RespiratorySymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter

class RespiratoryProblemData:RespiratoryProblemCalculation {
    override var value:Double{
        didSet{
            super.value = value
        }
    }
    
     init(type:RespiratoryProblemType) {
        super.init()
        
        switch type {
        case .COPD:
            self.relativeValue = 100
        case .asthma:
            self.relativeValue = 100
        case .pneumonia:
            self.relativeValue = 100
        case .pulmonaryEmbolism:
            self.relativeValue = 100
        case .allergicRhiniitis:
            self.relativeValue = 100
        case .smoking:
            self.relativeValue = 100
        
        }
       
        
    }
        
}

