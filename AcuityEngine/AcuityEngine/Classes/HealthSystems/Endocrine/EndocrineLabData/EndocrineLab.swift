//
//  CardioLab.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class EndocrineLab {
    /*hemoglobin A1c
    TSH
    microalbumin/creatinine ratio
    Sodium
    Potassium level
    BUN
    creatinine
    chloride
    Calcium
    Albumin
    Anion gap
    blood glucose */
    var hemaglobinA1cData:[EndocrineLabData] = []
    var TSHData:[EndocrineLabData]  = []
    var microalbuminCreatinineRatioData:[EndocrineLabData] = []
    
    var sodiumData:[EndocrineLabData] = []
    var potassiumLevelData:[EndocrineLabData] = []
    var BUNData:[EndocrineLabData] = []
    
    var creatinineData:[EndocrineLabData] = []
    var chlorideData:[EndocrineLabData]  = []
    var calciumData:[EndocrineLabData] = []
    
    var albuminData:[EndocrineLabData]  = []
    var anionGapData:[EndocrineLabData]  = []
    var bloodGlucoseData:[EndocrineLabData]  = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalLabDataScore() -> Double {
        
        return 0;
    }
    
    func getMaxLabDataScore() -> Double {
        
        let hemoglobinA1C = EndocrineLabRelativeImportance.hemoglobinA1C.getConvertedValueFromPercentage()
        let TSH = EndocrineLabRelativeImportance.TSH.getConvertedValueFromPercentage()
        let microalbuminCreatinineRatio = EndocrineLabRelativeImportance.microalbuminCreatinineRatio.getConvertedValueFromPercentage()
        
        let sodium = EndocrineLabRelativeImportance.sodium.getConvertedValueFromPercentage()
        let potassiumLevel = EndocrineLabRelativeImportance.potassiumLevel.getConvertedValueFromPercentage()
        let BUN = EndocrineLabRelativeImportance.BUN.getConvertedValueFromPercentage()
        
        let creatinine = EndocrineLabRelativeImportance.creatinine.getConvertedValueFromPercentage()
        let chloride = EndocrineLabRelativeImportance.chloride.getConvertedValueFromPercentage()
        let calcium = EndocrineLabRelativeImportance.calcium.getConvertedValueFromPercentage()
        
        let albumin = EndocrineLabRelativeImportance.albumin.getConvertedValueFromPercentage()
        let anionGap = EndocrineLabRelativeImportance.anionGap.getConvertedValueFromPercentage()
        let bloodGlucose = EndocrineLabRelativeImportance.bloodGlucose.getConvertedValueFromPercentage()
        
        let totalLabScore1 = hemoglobinA1C + TSH + microalbuminCreatinineRatio
        let totalLabScore2 = sodium + potassiumLevel + BUN
        let totalLabScore3 = creatinine + chloride + calcium
        let totalLabScore4 = albumin + anionGap + bloodGlucose
        
        return Double(totalLabScore1 + totalLabScore2 + totalLabScore3 + totalLabScore4);
    }
    
    func totalLabScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        arrayDayWiseScoreTotal = []
        
        var hematoLab:[Metrix] = []
        
        /*hematoLab.append(contentsOf: bunData)
         hematoLab.append(contentsOf: creatinineData)
         hematoLab.append(contentsOf: bloodGlucoseData)
         hematoLab.append(contentsOf: carbonDioxideData)
         hematoLab.append(contentsOf: potassiumLevelData)
         hematoLab.append(contentsOf: calciumData)
         hematoLab.append(contentsOf: chlorideData)
         hematoLab.append(contentsOf: albuminData)
         hematoLab.append(contentsOf: creatinineData)
         hematoLab.append(contentsOf: hemaglobinA1cData)
         hematoLab.append(contentsOf: microalbuminData)
         hematoLab.append(contentsOf: eGFRData)*/
        
        arrayDayWiseScoreTotal = daywiseFilterMetrixsData(days: days, array: hematoLab, metriXType: MetricsType.LabData)
        hematoLab = []
        
        return arrayDayWiseScoreTotal
    }
    
    func dictionaryRepresentation()->[LabModel]{
        
        let objModel = AcuityDetailConditionViewModel()
        return objModel.getLabData()
        
    }
}
