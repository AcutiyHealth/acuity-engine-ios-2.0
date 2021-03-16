//
//  CardioCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter

class CardioConditionCalculation {
    
    var relativeValue:Double = 100 //G26 // It is define in excel sheet given by client
    
    var value:Double = -1{
        didSet{
            
            self.calculatedValue = getSymptomsValue().rawValue
            
        }
    }//H9 // -1 is default value, so we can compare with 0
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
    
    private func getSymptomsValue() -> ConditionValue {
        
        
        //=IF(H3="Yes",B3*G3,C3*G3)
        
        switch value {
        case 0:
            return ConditionValue.No
        case 1:
            return ConditionValue.Yes
        
        default:
            return ConditionValue.No
        }
        
    }

    
}
