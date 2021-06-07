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
    var systemName:SystemName = SystemName.Cardiovascular  //Will set dynamically from every system...
    override var value:Double{
        didSet{
            if value < 0  {
                self.calculatedValue = RYGValue.Green.rawValue
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
                //ESR
                case .ESR:
                    self.calculatedValue = getESRValue().rawValue
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
    
    private func getOxygenLevelValue() -> RYGValue{
        
        
        //==if(H33="","",if(H33<0.9,1*G33,if(AND(H33>=0.9,H33<=0.95),0.5*G33,0)))
        
        if value < 90  {
            return RYGValue.Red
        } else if value >= 90 && value < 95 {
            return RYGValue.Yellow
        } else if value > 95  {
            return RYGValue.Green
        } else {
            return RYGValue.Green
        }
        
    }
    //MARK:AST
    private func getASTValue() -> RYGValue{
        if value > 46 || value < 15  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK:ALT
    private func getALTValue() -> RYGValue{
        if value > 69 || value < 13  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK:AlkalinePhosphatase
    private func getAlkalinePhosphataseValue() -> RYGValue{
        if systemName == SystemName.Musculatory{
            
            if value > 126 || value < 38  {
                return RYGValue.Red
            }
            else {
                return RYGValue.Green
            }
        }else{
            
            if value > 147 ||  value < 44{
                return RYGValue.Red
            }
            else {
                return RYGValue.Green
            }
        }
    }
    //MARK:b12Level
    private func getb12LevelValue() -> RYGValue{
        if value > 900 || value < 200  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK:Pottasium
    private func getPottasiumValue() -> RYGValue{
        if systemName == SystemName.Fluids{
            
            if value > 2.2 || value < 1.7  {
                return RYGValue.Red
            }
            else {
                return RYGValue.Green
            }
        }else{
            if value > 5.1 || value < 3.5  {
                return RYGValue.Red
            }
            else {
                return RYGValue.Green
            }
        }
    }
    
    //MARK:Sodium
    private func getSodiumValue() -> RYGValue{
        
        if value > 145 || value < 135  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK:TSH
    private func getTSHValue() -> RYGValue{
        
        if value > 3 || value < 0.3  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK: Chloride
    private func getChlorideValue() -> RYGValue{
        
        if value > 109 || value < 94  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK:Albumin
    private func getAlbuminValue() -> RYGValue{
        if systemName == SystemName.SocialDeterminantsofHealth{
            if value > 5.1 || value < 3.5{
                return RYGValue.Red
            }
            else {
                return RYGValue.Green
            }
        }
        else{
            if value < 3.4{
                return RYGValue.Red
            }
            else if value >= 3.4 && value <= 5.4{
                return RYGValue.Green
            }
            else {
                return RYGValue.Red
            }
        }
    }
    //MARK:MicroalbuminCreatinineRatio
    private func getMicroalbuminCreatinineRatioValue() -> RYGValue{
        
        if value > 30  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK:Magnasium
    private func getMagnasiumValue() -> RYGValue{
        
        if value > 2.2 || value < 1.7  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK:Peptide
    private func getPeptideValue() -> RYGValue{
        
        if value > 99  {
            return RYGValue.Red
        }
        else if value >= 1 && value <= 99  {
            return RYGValue.Yellow
        }
        else if value == 0   {
            return RYGValue.Green
        }
        else {
            return RYGValue.Green
        }
    }
    
    //MARK:Hemoglobin
    private func getHemoglobinValue() -> RYGValue{
        
        if value > 17.5 || value < 13.5  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK:HemoglobinA1C
    private func getHemoglobinA1CValue() -> RYGValue{
        
        if value >= 6.4  {
            return RYGValue.Red
        }else if value >= 6 && value <= 6.4  {
            return RYGValue.Yellow
        }
        else if value >= 4 && value < 6  {
            return RYGValue.Green
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK:WBC
    private func getWBCValue() -> RYGValue{
        /*
         If value is like 11000-3500, convert it to range 11-3.5 else keep range 10.9-3.5¯
         */
        if value>100{
            value = value / 1000;
        }
        if value >= 10.9 || value < 3.5  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK:Neutrophil
    private func getNeutrophilValue() -> RYGValue{
        
        if value > 60  {
            return RYGValue.Red
        }
        else if value >= 40 && value <= 60   {
            return RYGValue.Green
        }else{
            return RYGValue.Red
        }
    }
    //MARK:CarbonDioxide
    private func getCarbonDioxideValue() -> RYGValue{
        //As per Respiratory system....
        if value > 30 || value < 23  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK:BUN
    private func getBUNValue() -> RYGValue{
        if systemName == SystemName.Fluids || systemName == SystemName.Gastrointestinal{
            
            if value > 20  {
                return RYGValue.Red
            }else if value >= 10 && value <= 20 {
                return RYGValue.Green
            }
            else {
                return RYGValue.Red
            }
        }else  if systemName == SystemName.Endocrine{
            
            if value > 20  {
                return RYGValue.Red
            }else if value >= 9 && value <= 20 {
                return RYGValue.Green
            }
            else {
                return RYGValue.Red
            }
        }
        else if systemName == SystemName.SocialDeterminantsofHealth{
            if value > 99 {
                return RYGValue.Red
            }
            else if value >= 1 && value <= 99 {
                return RYGValue.Yellow
            }
            else {
                return RYGValue.Green
            }
        }
        else{
            if value > 20 {
                return RYGValue.Red
            }
            else if value >= 7 && value <= 20 {
                return RYGValue.Green
            }
            else {
                return RYGValue.Red
            }
        }
    }
    //MARK:Creatinine
    private func getCreatinineValue() -> RYGValue{
        //Endocrine
        if systemName == SystemName.Endocrine{
            if value > 1.25  {
                return RYGValue.Red
            } else if value >= 0.66 && value <= 1.25{
                return RYGValue.Green
            }
            else {
                return RYGValue.Red
            }
        }//SocialDeterminantsofHealth
        else if systemName == SystemName.SocialDeterminantsofHealth{
            if value > 1.7 ||  value < 0.84 {
                return RYGValue.Red
            }else if value >= 1.2 && value <= 1.7{
                return RYGValue.Yellow
            }
            else {
                return RYGValue.Green
            }
        }
        else{
            if value > 1.21  {
                return RYGValue.Red
            } else if value >= 0.84 && value <= 1.21{
                return RYGValue.Green
            }
            else {
                return RYGValue.Red
            }
        }
        
    }
    //MARK:BloodGlucose
    private func getBloodGlucoseValue() -> RYGValue{
        
        if value > 200 || value < 70{
            return RYGValue.Red
        }else if value >= 110 && value <= 200{
            return RYGValue.Yellow
        }
        else if value >= 70 && value <= 110  {
            return RYGValue.Green
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK:Calcium
    private func getCalciumValue() -> RYGValue{
        
        if value > 10.2 || value < 8.4  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK: AnionGap
    private func getAnionGapValue() -> RYGValue{
        
        if systemName == SystemName.InfectiousDisease{
            
            if value >= 16 || value < 7  {
                return RYGValue.Red
            }
            else {
                return RYGValue.Green
            }
        }else{
            if value > 11 || value < 3{
                return RYGValue.Red
            }
            else if  value >= 3 &&  value <= 11{
                return RYGValue.Green
            }
            else {
                return RYGValue.Green
            }
        }
    }
    
    //MARK: UrineNitrites
    private func getUrineNitrites() -> RYGValue{
        
        if value == LabResult.positive.rawValue  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK: UrineKenote
    private func getUrineKenote() -> RYGValue{
        
        if value == LabResult.positive.rawValue  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK:UrineBlood
    private func getUrineBlood() -> RYGValue{
        
        if value == LabResult.positive.rawValue  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK: VitaminB12
    private func getVitaminB12() -> RYGValue{
        
        if value > 190 || value < 950 {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    
    //MARK:MCV
    private func getMCV() -> RYGValue{
        if value < 80 || value > 96  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK:Platelets
    private func getPlateletsValue() -> RYGValue{
        if value > 400 || value < 135  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK:MicroAlbumin
    private func getMicroAlbuminValue() -> RYGValue{
        
        if value > 30  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK:eGFR
    private func geteGFRValue() -> RYGValue{
        
        if value < 90  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK:
    private func getESRValue() -> RYGValue{
        
        if value > 29  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //MARK:--------------------------------------------------
    //MARK: getUIColorFromCalculatedValue
    //Get UIColor from Calculated Value
    func getUIColorFromCalculatedValue() -> UIColor {
        
        // if(H30="","",if(H30<30,1*G30,if(and(H30>=30,H30<=40),0.5*G30,0)))
        switch calculatedValue {
        case RYGValue.Green.rawValue:
            return ChartColor.GREENCOLOR
        case RYGValue.Red.rawValue:
            return ChartColor.REDCOLOR
        case RYGValue.Yellow.rawValue:
            return ChartColor.YELLOWCOLOR
        default:
            break
        }
        return ChartColor.GREENCOLOR
    }
}
