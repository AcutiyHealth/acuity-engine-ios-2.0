//
//  CardioLabCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter

class LabCalculation:Metrix {
    override init() {
        super.init()
  
    }
    var metricType: LabType = .potassiumLevel // calculate based on symtomps type
    var systemName:SystemName = SystemName.Cardiovascular
    override var value:Double{
        didSet{
            if value < 0  {
                self.calculatedValue = HeartRateValue.Green.rawValue
            }else{
                switch metricType {
                //anionGap
                case .anionGap:
                    self.calculatedValue = getAnionGapValue().rawValue
                //AST
                case .AST:
                    self.calculatedValue = getASTValue().rawValue
                //ALT
                case .ALT:
                    self.calculatedValue = getALTValue().rawValue
                //albumin
                case .albumin:
                    self.calculatedValue = getAlbuminValue().rawValue
                //alkalinePhosphatase
                case .alkalinePhosphatase:
                    self.calculatedValue = getAlkalinePhosphataseValue().rawValue
                //b12Level
                case .b12Level:
                    self.calculatedValue = getb12LevelValue().rawValue
                //BUN
                case .BUN:
                    self.calculatedValue = getBUNValue().rawValue
                //bloodGlucose
                case .bloodGlucose:
                    self.calculatedValue = getBloodGlucoseValue().rawValue
                //bPeptide
                case .bPeptide:
                    self.calculatedValue = getPeptideValue().rawValue
                //creatinine
                case .creatinine:
                    self.calculatedValue = getCreatinineValue().rawValue
                //calcium
                case .calcium:
                    self.calculatedValue = getCalciumValue().rawValue
                //carbonDioxide
                case .carbonDioxide:
                    self.calculatedValue = getCarbonDioxideValue().rawValue
                //chloride
                case .chloride:
                    self.calculatedValue = getChlorideValue().rawValue
                //eGFR
                case .eGFR:
                    self.calculatedValue = geteGFRValue().rawValue
                //hemoglobin
                case .hemoglobin:
                    self.calculatedValue = getHemoglobinValue().rawValue
                //hemoglobin a1c
                case .hemoglobinA1C:
                    self.calculatedValue = getHemoglobinA1CValue().rawValue
                //microalbumin
                case .microalbuminCreatinineRatio:
                    self.calculatedValue = getMicroalbuminCreatinineRatioValue().rawValue
                //neutrophil
                case .neutrophil:
                    self.calculatedValue = getNeutrophilValue().rawValue
                //MCV
                case .MCV:
                    self.calculatedValue = getMCV().rawValue
                //platelets
                case .platelets:
                    self.calculatedValue = getPlateletsValue().rawValue
                //potassiumLevel
                case .potassiumLevel:
                    self.calculatedValue = getPottasiumValue().rawValue
                //sodium
                case .sodium:
                    self.calculatedValue = getSodiumValue().rawValue
                //TSH
                case .TSH:
                    self.calculatedValue = getTSHValue().rawValue
                //urineBlood
                case .urineBlood:
                    self.calculatedValue = getUrineBlood().rawValue
                //urineNitrites
                case .urineNitrites:
                    self.calculatedValue = getUrineNitrites().rawValue
                //urineKetone
                case .urineKetone:
                    self.calculatedValue = getUrineKenote().rawValue
                //vitaminB12
                case .vitaminB12:
                    self.calculatedValue = getVitaminB12().rawValue
                //WBC
                case .WBC:
                    self.calculatedValue = getWBCValue().rawValue
                    
                default:break
                }
            }
        }
    }//H9
    
    //MARK:OxygenLevel
    
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
    //MARK:AST
    private func getASTValue() -> HeartRateValue {
        if value > 46 || value < 15  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK:ALT
    private func getALTValue() -> HeartRateValue {
        if value > 69 || value < 13  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK:AlkalinePhosphatase
    private func getAlkalinePhosphataseValue() -> HeartRateValue {
        if value > 147  {
            return HeartRateValue.Red
        }else if value >= 44 && value <= 147 {
            return HeartRateValue.Green
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK:b12Level
    private func getb12LevelValue() -> HeartRateValue {
        if value > 900 || value < 200  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK:Pottasium
    private func getPottasiumValue() -> HeartRateValue {
        if systemName == SystemName.Fluids{
            
            if value > 2.2 || value < 1.7  {
                return HeartRateValue.Red
            }
            else {
                return HeartRateValue.Green
            }
        }else{
            if value > 5.1 || value < 3.5  {
                return HeartRateValue.Red
            }
            else {
                return HeartRateValue.Green
            }
        }
    }
    
    //MARK:Sodium
    private func getSodiumValue() -> HeartRateValue {
        
        if value > 145 || value < 135  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK:TSH
    private func getTSHValue() -> HeartRateValue {
        
        if value > 3 || value < 0.3  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK: Chloride
    private func getChlorideValue() -> HeartRateValue {
        
        if value > 109 || value < 94  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK:Albumin
    private func getAlbuminValue() -> HeartRateValue {
        
        if value < 3.4{
            return HeartRateValue.Red
        }
        else if value >= 3.4 && value <= 5.4{
            return HeartRateValue.Green
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK:MicroalbuminCreatinineRatio
    private func getMicroalbuminCreatinineRatioValue() -> HeartRateValue {
        
        if value > 30  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK:Magnasium
    private func getMagnasiumValue() -> HeartRateValue {
        
        if value > 2.2 || value < 1.7  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK:Peptide
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
    
    //MARK:Hemoglobin
    private func getHemoglobinValue() -> HeartRateValue {
        
        if value > 17.5 || value < 13.5  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK:HemoglobinA1C
    private func getHemoglobinA1CValue() -> HeartRateValue {
        
        if value >= 6.4  {
            return HeartRateValue.Red
        }else if value >= 6 && value <= 6.4  {
            return HeartRateValue.Yellow
        }
        else if value >= 4 && value < 6  {
            return HeartRateValue.Green
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK:WBC
    private func getWBCValue() -> HeartRateValue {
        
        if value >= 10.9 || value < 3.5  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK:Neutrophil
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
    //MARK:CarbonDioxide
    private func getCarbonDioxideValue() -> HeartRateValue {
        //As per Respiratory system....
        if value > 30 || value < 23  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK:BUN
    private func getBUNValue() -> HeartRateValue {
        if systemName == SystemName.Fluids || systemName == SystemName.Gastrointestinal{
            
            if value > 20  {
                return HeartRateValue.Red
            }else if value >= 10 && value <= 20 {
                return HeartRateValue.Green
            }
            else {
                return HeartRateValue.Green
            }
        }else  if systemName == SystemName.Endocrine{
            
            if value > 20  {
                return HeartRateValue.Red
            }else if value >= 9 && value <= 20 {
                return HeartRateValue.Green
            }
            else {
                return HeartRateValue.Green
            }
        }else{
            if value > 20 {
                return HeartRateValue.Red
            }
            else if value >= 7 && value <= 20 {
                return HeartRateValue.Green
            }
            else {
                return HeartRateValue.Green
            }
        }
    }
    //MARK:Creatinine
    private func getCreatinineValue() -> HeartRateValue {
        //Endocrine
        if systemName == SystemName.Endocrine{
            if value > 1.25  {
                return HeartRateValue.Red
            } else if value >= 0.66 && value <= 1.25{
                return HeartRateValue.Green
            }
            else {
                return HeartRateValue.Green
            }
        }else{
            if value > 1.21  {
                return HeartRateValue.Red
            } else if value >= 0.84 && value <= 1.21{
                return HeartRateValue.Green
            }
            else {
                return HeartRateValue.Green
            }
        }
        
    }
    //MARK:BloodGlucose
    private func getBloodGlucoseValue() -> HeartRateValue {
        
        if value > 200 {
            return HeartRateValue.Red
        }else if value >= 70 && value <= 110  {
            return HeartRateValue.Green
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK:Calcium
    private func getCalciumValue() -> HeartRateValue {
        
        if value > 10.2 || value < 8.4  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK: AnionGap
    private func getAnionGapValue() -> HeartRateValue {
        
        if systemName == SystemName.InfectiousDisease{
            
            if value >= 16 || value < 7  {
                return HeartRateValue.Red
            }
            else {
                return HeartRateValue.Green
            }
        }else{
            if value > 11 {
                return HeartRateValue.Red
            }
            else if  value >= 3 &&  value <= 11{
                return HeartRateValue.Green
            }
            else {
                return HeartRateValue.Green
            }
        }
    }
    
    //MARK: UrineNitrites
    private func getUrineNitrites() -> HeartRateValue {
        
        if value == LabResult.positive.rawValue  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK: UrineKenote
    private func getUrineKenote() -> HeartRateValue{
        
        if value == LabResult.positive.rawValue  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK:UrineBlood
    private func getUrineBlood() -> HeartRateValue {
        
        if value == LabResult.positive.rawValue  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK: VitaminB12
    private func getVitaminB12() -> HeartRateValue {
        
        if value > 190 || value < 950 {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    
    //MARK:MCV
    private func getMCV() -> HeartRateValue {
        if value < 80 || value > 96  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK:Platelets
    private func getPlateletsValue() -> HeartRateValue {
        if value > 400 || value < 135  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK:MicroAlbumin
    private func getMicroAlbuminValue() -> HeartRateValue {
        
        if value > 30  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    //MARK:eGFR
    private func geteGFRValue() -> HeartRateValue {
        
        if value < 90  {
            return HeartRateValue.Red
        }
        else {
            return HeartRateValue.Green
        }
    }
    
    //MARK:--------------------------------------------------
    //MARK: getUIColorFromCalculatedValue
    //Get UIColor from Calculated Value
    func getUIColorFromCalculatedValue() -> UIColor {
        
        // if(H30="","",if(H30<30,1*G30,if(and(H30>=30,H30<=40),0.5*G30,0)))
        switch calculatedValue {
        case HeartRateValue.Green.rawValue:
            return ChartColor.GREENCOLOR
        case HeartRateValue.Red.rawValue:
            return ChartColor.REDCOLOR
        case HeartRateValue.Yellow.rawValue:
            return ChartColor.YELLOWCOLOR
        default:
            break
        }
        return ChartColor.GREENCOLOR
    }
}
