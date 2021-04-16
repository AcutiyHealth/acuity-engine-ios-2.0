//
//  CardioLabCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter

class LabCalculation:Metrix {
    
    var metricType: LabType = .potassiumLevel // calculate based on symtomps type
    var systemName:SystemName = SystemName.Cardiovascular
    override var value:Double{
        didSet{
            switch metricType {
            
            case .potassiumLevel:
                self.calculatedValue = getPottasiumValue().rawValue
            case .sodium:
                self.calculatedValue = getSodiumValue().rawValue
            case .chloride:
                self.calculatedValue = getChlorideValue().rawValue
            case .albumin:
                self.calculatedValue = getAlbuminValue().rawValue
            case .microalbumin:
                self.calculatedValue = getMicroalbuminValue().rawValue
            case .bPeptide:
                self.calculatedValue = getPeptideValue().rawValue
            case .hemoglobin:
                self.calculatedValue = getHemoglobinValue().rawValue
            case .carbonDioxide:
                self.calculatedValue = getCarbonDioxideValue().rawValue
            case .WBC:
                self.calculatedValue = getWBCValue().rawValue
            case .neutrophil:
                self.calculatedValue = getNeutrophilValue().rawValue
            default:break
            }
        }
    }//H9 // -1 is default value, so we can compare with 0
    
    
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
    
    
    private func getSodiumValue() -> HeartRateValue {
        
        if value > 145 || value < 135  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    
    private func getChlorideValue() -> HeartRateValue {
        
        if value > 109 || value < 94  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    private func getAlbuminValue() -> HeartRateValue {
        
        if value < 3.4 {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    private func getMicroalbuminValue() -> HeartRateValue {
        
        if value > 30  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    private func getMagnasiumValue() -> HeartRateValue {
        
        if value > 2.2 || value < 1.7  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    
    private func getPeptideValue() -> HeartRateValue {
        
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
        
        if value > 17.5 || value < 13.5  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    private func getWBCValue() -> HeartRateValue {
        
        if value >= 10.9 || value < 3.5  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    private func getNeutrophilValue() -> HeartRateValue {
        
        if value > 60  {
            return HeartRateValue.Red
        }
        else if value >= 40 && value <= 60   {
            return HeartRateValue.Green
        }else{
            return HeartRateValue.Green
        }
    }
    private func getCarbonDioxideValue() -> HeartRateValue {
        
        if value > 30 || value < 23  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
}
