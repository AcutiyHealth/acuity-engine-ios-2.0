//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

class CardioProblemData:CardioProblemCalculation {
    override var value:Double{
        didSet{
            super.value = value
        }
    }
    
     init(type:CardioProblemType) {
        super.init()
        
        switch type {
        case .hypertension:
            self.relativeValue = 100
        case .arrhythmia:
            self.relativeValue = 100
        case .heartFailure:
            self.relativeValue = 100
        case .arteryDisease:
            self.relativeValue = 100
        }
       
        
    }
        
}

