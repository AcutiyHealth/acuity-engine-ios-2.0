//
//  CardioSymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

class CardioLabData:CardioLabCalculation {
    override var value:Double{
        didSet{
            super.value = value
        }
    }
    
     init(type:CardioLabsType) {
        super.init()
        super.symptomsType = type
        switch type {
        case .potassiumLevel:
            self.relativeValue = 40
        case .bPeptide:
            self.relativeValue = 30
        case .troponinLevel:
            self.relativeValue = 40
        case .bloodOxygenLevel:
            self.relativeValue = 20
        case .magnesiumLevel:
            self.relativeValue = 80
        case .hemoglobin:
            self.relativeValue = 50
        
        }
       
        
    }
        
}

