//
//  CardioLabCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter

class CardioLabCalculation {
    
    var relativeValue:Double = 40 //G26 // It is define in excel sheet given by client
    var symptomsType: CardioLabsType = .bloodOxygenLevel // calculate based on symtomps type
    var value:Double = -1{
        didSet{
            switch symptomsType {
            case .bloodOxygenLevel:
                self.calculatedValue = getOxygenLevelValue().rawValue
            case .potassiumLevel:
                self.calculatedValue = getPottasiumValue().rawValue
            case .magnesiumLevel:
                self.calculatedValue = getMagnasiumValue().rawValue
            case .bPeptide:
                self.calculatedValue = getPeptideValue().rawValue
            case .troponinLevel:
                self.calculatedValue = getTroponinValue().rawValue
                
            default:
                self.calculatedValue = getOxygenLevelValue().rawValue
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
        
        
        //==if(H33="","",if(H33<0.9,1*G33,if(AND(H33>=0.9,H33<=0.95),0.5*G33,0)))

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
    
    private func getPottasiumValue() -> HeartRateValue {
        
        
        //==if(H33="","",if(H33<0.9,1*G33,if(AND(H33>=0.9,H33<=0.95),0.5*G33,0)))

        if value > 5.1 || value < 3.5  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    
    private func getMagnasiumValue() -> HeartRateValue {
        
        
        //==if(H33="","",if(H33<0.9,1*G33,if(AND(H33>=0.9,H33<=0.95),0.5*G33,0)))

        if value > 2.2 || value < 1.7  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    
    private func getPeptideValue() -> HeartRateValue {
        
        
        //==if(H33="","",if(H33<0.9,1*G33,if(AND(H33>=0.9,H33<=0.95),0.5*G33,0)))

        if value > 99  {
            return HeartRateValue.Red
        }
        else if value >= 1 && value <= 99  {
            return HeartRateValue.Yellow
        }
        else if value == 0   {
            return HeartRateValue.Green
        }
        else {
            return HeartRateValue.Green
        }
    }
    
    private func getTroponinValue() -> HeartRateValue {
        
        
        //==if(H33="","",if(H33<0.9,1*G33,if(AND(H33>=0.9,H33<=0.95),0.5*G33,0)))

        if value > 1  {
            return HeartRateValue.Red
        }
        else if value < 0.04 && value == 1  {
            return HeartRateValue.Yellow
        }
        else if value < 0.04   {
            return HeartRateValue.Green
        }
        else {
            return HeartRateValue.Green
        }
    }
    
    private func getHemoglobinValue() -> HeartRateValue {
        
        
        //==if(H33="","",if(H33<0.9,1*G33,if(AND(H33>=0.9,H33<=0.95),0.5*G33,0)))

        if value > 17.5 || value < 13.5  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    
}
