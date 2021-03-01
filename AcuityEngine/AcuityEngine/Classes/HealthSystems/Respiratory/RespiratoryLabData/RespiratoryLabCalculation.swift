//
//  RespiratoryLabCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter

class RespiratoryLabCalculation {
    
    var relativeValue:Double = 40 //G26 // It is define in excel sheet given by client
    var symptomsType: RespiratoryLabsType = .bloodOxygenLevel // calculate based on symtomps type
    var value:Double = -1{
        didSet{
            switch symptomsType {
            case .bloodOxygenLevel:
                self.calculatedValue = getOxygenLevelValue().rawValue
            case .HCO3:
                self.calculatedValue = getHCO3Value().rawValue
            case .O2:
                self.calculatedValue = getO2SatValue().rawValue
            case .PaCO2:
                self.calculatedValue = getPaCO2Value().rawValue
            case .PaO2:
                self.calculatedValue = getPaO2Value().rawValue
            case .bicarbonate:
                self.calculatedValue = getBicarbonateValue().rawValue
        }
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
    
    private func getOxygenLevelValue() -> HeartRateValue {
        
        
        //=if(H38="","",if(H38>99,1,if(AND(H38<=99,H38>=1),0.5,0)))
        
        if value < 90  {
            return HeartRateValue.Red
        } else if value >= 90 && value < 95 {
            return HeartRateValue.Yellow
        } else if value > 95  {
            return HeartRateValue.Green
        } else {
            return HeartRateValue.Green
        }
        
    }
    
    private func getBicarbonateValue() -> HeartRateValue {
        
        
        ////=if(H38="","",if(H38>99,1,if(AND(H38<=99,H38>=1),0.5,0)))
        
        if value > 30 || value < 23  {
            return HeartRateValue.Red
        } else if value >= 23 && value <= 30 {
            return HeartRateValue.Green
        }  else {
            return HeartRateValue.Green
        }
    }
    
    private func getPaO2Value() -> HeartRateValue {
        
        
        ////=if(H38="","",if(H38>99,1,if(AND(H38<=99,H38>=1),0.5,0)))
        
        if value > 100 || value < 75  {
            return HeartRateValue.Red
        }else if value >= 75 && value <= 100 {
            return HeartRateValue.Green
        }
        else {
            return HeartRateValue.Green
        }
    }
    
    private func getPaCO2Value() -> HeartRateValue {
        
        
        //=if(H38="","",if(H38>99,1,if(AND(H38<=99,H38>=1),0.5,0)))
        
        
        if value > 42 || value < 38  {
            return HeartRateValue.Red
        }else if value >= 38 && value <= 42 {
            return HeartRateValue.Green
        }
        else {
            return HeartRateValue.Green
        }
    }
    
    private func getHCO3Value() -> HeartRateValue {
        
        //=if(H38="","",if(H38>99,1,if(AND(H38<=99,H38>=1),0.5,0)))
        
        
        if value > 28 || value < 22  {
            return HeartRateValue.Red
        }else if value >= 22 && value <= 28 {
            return HeartRateValue.Green
        }
        else {
            return HeartRateValue.Green
        }
    }
    
    private func getO2SatValue() -> HeartRateValue {
        
        //=if(H38="","",if(H38>99,1,if(AND(H38<=99,H38>=1),0.5,0)))
        
        
        if value < 92  {
            return HeartRateValue.Red
        }else if value >= 92 && value <= 100 {
            return HeartRateValue.Green
        }
        else {
            return HeartRateValue.Green
        }
    }
    
}
