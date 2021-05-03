//
//  CardioCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter

class ConditionCalculation:Metrix {
    var type: ConditionType = .hypertension // calculate based on symtomps type
    override var value:Double{
        didSet{
            
            self.calculatedValue = value//getConditionValue().rawValue
            
        }
    }//H9 // -1 is default value, so we can compare with 0
 
  
    private func getConditionValue() -> ConditionValue {
        
        
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
