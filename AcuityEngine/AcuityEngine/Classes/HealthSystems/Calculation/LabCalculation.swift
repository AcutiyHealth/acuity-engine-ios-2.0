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
            //AST
            case .AST:
                self.calculatedValue = getASTValue().rawValue
            //ALT
            case .ALT:
                self.calculatedValue = geALTValue().rawValue
            //potassiumLevel
            case .potassiumLevel:
                if systemName == SystemName.Fluids{
                    self.calculatedValue = getPottasiumforFluidsValue().rawValue
                }else{
                    self.calculatedValue = getPottasiumValue().rawValue
                }
            //sodium
            case .sodium:
                self.calculatedValue = getSodiumValue().rawValue
            //chloride
            case .chloride:
                self.calculatedValue = getChlorideValue().rawValue
            //albumin
            case .albumin:
                self.calculatedValue = getAlbuminValue().rawValue
            //microalbumin
            case .microalbumin:
                self.calculatedValue = getMicroalbuminValue().rawValue
            //bPeptide
            case .bPeptide:
                self.calculatedValue = getPeptideValue().rawValue
            //hemoglobin
            case .hemoglobin:
                self.calculatedValue = getHemoglobinValue().rawValue
            //carbonDioxide
            case .carbonDioxide:
                self.calculatedValue = getCarbonDioxideValue().rawValue
            //WBC
            case .WBC:
                self.calculatedValue = getWBCValue().rawValue
            //neutrophil
            case .neutrophil:
                self.calculatedValue = getNeutrophilValue().rawValue
            //BUN
            case .BUN:
                if systemName == SystemName.Fluids{
                    self.calculatedValue = getBUNForFluidsValue().rawValue
                }else{
                    self.calculatedValue = getBUNValue().rawValue
                }
            //creatinine
            case .creatinine:
                self.calculatedValue = getCreatinineValue().rawValue
            //bloodGlucose
            case .bloodGlucose:
                self.calculatedValue = getBloodGlucoseValue().rawValue
            //calcium
            case .calcium:
                self.calculatedValue = getCalciumValue().rawValue
            //anionGap
            case .anionGap:
                if systemName == SystemName.InfectiousDisease{
                    self.calculatedValue = getAnionGapValueForIDisease().rawValue
                }else{
                    self.calculatedValue = getAnionGapValue().rawValue
                }
            //MCV
            case .MCV:
                self.calculatedValue = getMCV().rawValue
            //urineBlood
            case .urineBlood:
                self.calculatedValue = getUrineBlood().rawValue
            //urineNitrites
            case .urineNitrites:
                self.calculatedValue = getUrineNitrites().rawValue
            //urineKetone
            case .urineKetone:
                self.calculatedValue = getUrineKenote().rawValue
            //eGFR
            case .eGFR:
                self.calculatedValue = geteGFRValue().rawValue
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
    //AST
    private func getASTValue() -> HeartRateValue {
        if value > 46 || value < 15  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //ALT
    private func geALTValue() -> HeartRateValue {
        if value > 69 || value < 13  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    
    private func getPottasiumValue() -> HeartRateValue {
        
        if value > 5.1 || value < 3.5  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //For FNE system..
    private func getPottasiumforFluidsValue() -> HeartRateValue {
        
        if value > 2.2 || value < 1.7  {
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
        
        if value < 3.4 && value > 5.4{
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
    private func getBUNValue() -> HeartRateValue {
        
        if value > 20 || value < 7  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //For FNE
    private func getBUNForFluidsValue() -> HeartRateValue {
        
        if value > 20 || value < 10  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    private func getCreatinineValue() -> HeartRateValue {
        
        if value > 1.21 || value < 0.84  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    private func getBloodGlucoseValue() -> HeartRateValue {
        
        if value > 200 || value < 70  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    private func getCalciumValue() -> HeartRateValue {
        
        if value > 10.2 || value < 8.4  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    private func getAnionGapValue() -> HeartRateValue {
        
        if value > 11 || value < 3  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    private func getAnionGapValueForIDisease() -> HeartRateValue {
        
        if value >= 16 || value < 7  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    private func getUrineNitrites() -> HeartRateValue {
        
        if value == LabResult.positive.rawValue  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    private func getUrineKenote() -> HeartRateValue{
        
        if value == LabResult.positive.rawValue  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    private func getUrineBlood() -> HeartRateValue {
        
        if value == LabResult.positive.rawValue  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    private func getMCV() -> HeartRateValue {
        if value < 80 || value > 96  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    private func getMicroAlbuminValue() -> HeartRateValue {
        
        if value > 30  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    private func geteGFRValue() -> HeartRateValue {
        
        if value < 90  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
}
