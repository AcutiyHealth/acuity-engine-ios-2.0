//
//  CardioLab.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class CardioLab {
    /*
     Potassium level
     Sodium
     chloride
     Albumin (
     microalbumin/creat ratio
     B-peptide
     Hemoglobin
     */
    var potassiumLevelData:[CardioLabData] = []
    var bPeptideData:[CardioLabData]  = []
    var sodiumData:[CardioLabData] = []
    var chlorideData:[CardioLabData] = []
    var albuminData:[CardioLabData] = []
    var microalbuminData:[CardioLabData] = []
    var hemoglobinData:[CardioLabData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalLabDataScore() -> Double {
        let potassiumLevel = (Double(potassiumLevelData.average(\.score) ).isNaN ? 0 : Double(potassiumLevelData.average(\.score) ) )
        let bPeptide = (Double(bPeptideData.average(\.score)) .isNaN ? 0 : Double(bPeptideData.average(\.score)))
        let sodium = (Double(sodiumData.average(\.score)).isNaN ? 0 : Double(sodiumData.average(\.score)))
        let chloride = (Double(chlorideData.average(\.score)).isNaN ? 0 :  Double(chlorideData.average(\.score)))
        let albumin = (Double(albuminData.average(\.score)).isNaN ? 0 : Double(albuminData.average(\.score)))
        let microalbumin = (Double(microalbuminData.average(\.score)).isNaN ? 0 : Double(microalbuminData.average(\.score)))
        let hemoglobin = (Double(hemoglobinData.average(\.score)).isNaN ? 0 : Double(hemoglobinData.average(\.score)))
        
        
        let totalLabScore1 = potassiumLevel + bPeptide
        let totalLabScore2 =  albumin + microalbumin
        let totalLabScore3 = sodium + chloride + hemoglobin
        
        return Double(totalLabScore1  + totalLabScore3 + totalLabScore2);
    }
    
    func getMaxLabDataScore() -> Double {
        let potassiumLevel = CardioLabRelativeImportance.potassiumLevel.getConvertedValueFromPercentage()
        let bPeptide = CardioLabRelativeImportance.bPeptide.getConvertedValueFromPercentage()
        let sodium = CardioLabRelativeImportance.sodium.getConvertedValueFromPercentage()
        let chloride = CardioLabRelativeImportance.chloride.getConvertedValueFromPercentage()
        let albumin = CardioLabRelativeImportance.albumin.getConvertedValueFromPercentage()
        let microalbumin = CardioLabRelativeImportance.microalbumin.getConvertedValueFromPercentage()
        let hemoglobin = CardioLabRelativeImportance.hemoglobin.getConvertedValueFromPercentage()
        
        
        let totalLabScore1 = potassiumLevel + bPeptide
        let totalLabScore2 =  albumin + microalbumin
        let totalLabScore3 = sodium + chloride + hemoglobin
        
        return Double(totalLabScore1  + totalLabScore3 + totalLabScore2);
    }
    
    func totalLabScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        //print(totalAmount) // 4500.0
        
        arrayDayWiseScoreTotal = []
        
        var cardioLab:[Metrix] = []
        
        cardioLab.append(contentsOf: potassiumLevelData)
        cardioLab.append(contentsOf: bPeptideData)
        cardioLab.append(contentsOf: albuminData)
        cardioLab.append(contentsOf: microalbuminData)
        cardioLab.append(contentsOf: sodiumData)
        cardioLab.append(contentsOf: chlorideData)
        cardioLab.append(contentsOf: hemoglobinData)
        
        arrayDayWiseScoreTotal = daywiseFilterMetrixsData(days: days, array: cardioLab, metriXType: MetricsType.LabData)
        cardioLab = []
        
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[LabModel]{
        
        let objModel = AcuityMetricsDetailViewModel()
        return objModel.getLabData()
        
    }
}
