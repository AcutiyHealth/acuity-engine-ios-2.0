//
//  CardioCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter

class SymptomCalculation:Metrix {
    
    var symptomsType: CategoryType = .chestTightnessOrPain // calculate based on symtomps type
    override var value:Double{
        didSet{
            if symptomsType == CategoryType.sleepChanges{
                self.calculatedValue = getSymptomSleepChangeValue().rawValue
            }else{
                self.calculatedValue = getSymptomsValue().rawValue
            }
        }
    }//H9 // -1 is default value, so we can compare with 0


    func getSymptomsValue() -> SymptomsValue {
        
        
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
    
    func getSymptomSleepChangeValue() -> SymptomsSleepChangeValue {
        
        
        //=if(H21="Severe",B21*G21,if(H21="Moderate",C21*G21,if(H21="Mild",D21*G21,if(H21="Present",E21*G21,if(H21="Not Present",F21*G21)))))
        
        switch value {
        case 0:
            return SymptomsSleepChangeValue.Present
        case 1:
            return SymptomsSleepChangeValue.Not_Present
        default:
            return SymptomsSleepChangeValue.Not_Present
        }
        
    }
    
    
}
