//
//  RespiratoryCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter

class RespiratorySymptomCalculation {
    
    var relativeValue:Double = 40 //G26 // It is define in excel sheet given by client
    var symptomsType: CategoryType = .chestTightnessOrPain // calculate based on symtomps type
    var value:Double = -1{
        didSet{
            
                self.calculatedValue = getSymptomsValue().rawValue
            
        }
    }//H9 // -1 is default value, so we can compare with 0
    var startTime:Double = Date().timeIntervalSinceNow
    var endTime:Double = Date().timeIntervalSinceNow
    var calculatedValue:Double = -1 // Calculation will be provided by child class
    var score:Double  {
        // We will calculate score of value
        if calculatedValue == -1 {
            return 0
        } else {
            return (calculatedValue * relativeValue) / 100 // it is percentage value of relative score to 1
        }
        
    }
    
    var maxScore:Double? {
        
        //=if(I9="","",1*G9)
        if score == -1 {
            return 0
        } else {
            return (1*relativeValue) / 100 // it is percentage value of relative score to 1
        }
    }
    
    private func getSymptomsValue() -> SymptomsValue {
        
        
        //=if(H9="Severe",B9*G9,if(H9="Moderate",C9*G9,if(H9="Mild",D9*G9,if(H9="Present",E9*G9,if(H9="Not Present",F9*G9)))))
        
        switch value {
        case 0:
            return SymptomsValue.Present
        case 1:
            return SymptomsValue.Not_Present
        case 2:
            return SymptomsValue.Mild
        case 3:
            return SymptomsValue.Moderate
        case 4:
            return SymptomsValue.Severe
        default:
            return SymptomsValue.Not_Present
        }
        
    }
    
    
    
    
}
