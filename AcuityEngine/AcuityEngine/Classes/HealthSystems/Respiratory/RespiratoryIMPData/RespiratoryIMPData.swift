//
//  RespiratorySymptomsCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation
import HealthKitReporter
// Available from 13.6

class RespiratoryIMPData:RespiratoryIMPCalculation {
    override var value:Double{
        didSet{
            super.value = value
        }
    }
    
     init(type:RespiratoryIMPDataType) {
        super.init()
        super.IMPDataType = type
        switch type {
        case .respiratoryRate:
            self.relativeValue = 0
        case .supplementOxygen:
            self.relativeValue = 0
        case .biPAPOrcPAP:
            self.relativeValue = 0
        case .heartRate:
            self.relativeValue = 80
        case .lowHeartRate:
            self.relativeValue = 20
        case .highHeartRate:
            self.relativeValue = 30
        case .irregularRhymesNotification:
            self.relativeValue = 80
        case .vo2Max:
            self.relativeValue = 30
        case .peakFlowRate:
            self.relativeValue = 0
        case .sixMinWalk:
            self.relativeValue = 0
        case .fev1:
            self.relativeValue = 80
        case .inhalerUsage:
            self.relativeValue = 20
        }
       
        
    }
        
}

