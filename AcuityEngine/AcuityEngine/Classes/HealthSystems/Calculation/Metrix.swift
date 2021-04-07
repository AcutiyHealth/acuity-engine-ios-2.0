//
//  MetrixCalculation.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 25/03/21.
//

import Foundation


class Metrix {
    
    var relativeValue:Double = 100 //G26 // It is define in excel sheet given by client
    var startTimeStamp: Double = 0
    var endTimeStamp: Double = 0
    var value:Double = -1
    var calculatedValue:Double = -1 // Calculation will be provided by child class
    var score:Double  {
        // We will calculate score of value
        if calculatedValue == -1 {
            return 0
        } else {
            return (calculatedValue * relativeValue) / 100 // it is percentage value of relative score to 1
        }
        
    }
    
    var maxScore:Double{
        
        // =if(I25="","",1*G25)
        if score == -1 {
            return 0
        } else {
            return (1*relativeValue) / 100 // it is percentage value of relative score to 1
        }
    }
    
}
