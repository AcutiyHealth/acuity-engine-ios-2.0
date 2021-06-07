//
//  CardioCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter

class SymptomCalculation:Metrix {
    
    var title:String = ""
    var symptomsType: CategoryType = .chestTightnessOrPain // calculate based on symtomps type
    var systemName:SystemName = SystemName.Cardiovascular
    override var value:Double{
        didSet{
            if symptomsType == CategoryType.sleepChanges{
                self.calculatedValue = getSymptomSleepChangeValue().rawValue
            }
            else if systemName == SystemName.InfectiousDisease && symptomsType == CategoryType.dizziness{
                self.calculatedValue = getSymptomSleepChangeValue().rawValue
            }
            else{
                self.calculatedValue = getSymptomsValue().rawValue
            }
        }
    }//H9 // -1 is default value, so we can compare with 0


    func getSymptomsValue() -> SymptomsValue {
        
        
        //=if(H9="Severe",B9*G9,if(H9="Moderate",C9*G9,if(H9="Mild",D9*G9,if(H9="Present",E9*G9,if(H9="Not Present",F9*G9)))))
        //We get value 4->Severe 3-> Moderate 2->Mild 0->Present and 1 -> Not Presetnt from healthkit for symptoms
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
