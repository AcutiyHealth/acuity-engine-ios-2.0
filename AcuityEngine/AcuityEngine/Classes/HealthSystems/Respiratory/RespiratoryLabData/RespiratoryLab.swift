//
//  CardioLab.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class RespiratoryLab {
    /*Sodium
     carbon dioxide (CMP) mEq/L
     chloride
     WBC's
     Neutrophil %*/
    var sodiumData:[CardioLabData] = []
    var carbonDioxideData:[CardioLabData]  = []
    var chlorideData:[CardioLabData] = []
    var WBCData:[CardioLabData] = []
    var neutrophilData:[CardioLabData] = []

    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalLabDataScore() -> Double {
        let carbonDioxide = (Double(carbonDioxideData.average(\.score) ).isNaN ? 0 : Double(carbonDioxideData.average(\.score) ) )
        let WBC = (Double(WBCData.average(\.score)) .isNaN ? 0 : Double(WBCData.average(\.score)))
        let sodium = (Double(sodiumData.average(\.score)).isNaN ? 0 : Double(sodiumData.average(\.score)))
        let chloride = (Double(chlorideData.average(\.score)).isNaN ? 0 :  Double(chlorideData.average(\.score)))
        let neutrophil = (Double(neutrophilData.average(\.score)).isNaN ? 0 : Double(neutrophilData.average(\.score)))
        
        let totalLabScore1 = carbonDioxide + WBC
        let totalLabScore2 = sodium + chloride + neutrophil
        
        return Double(totalLabScore1  + totalLabScore2);
    }
    
    func getMaxLabDataScore() -> Double {
        let carbonDioxide = RespiratoryLabRelativeImportance.carbonDioxide.getConvertedValueFromPercentage()
        let WBC =  RespiratoryLabRelativeImportance.WBC.getConvertedValueFromPercentage()
        let sodium =  RespiratoryLabRelativeImportance.sodium.getConvertedValueFromPercentage()
        let chloride =  RespiratoryLabRelativeImportance.chloride.getConvertedValueFromPercentage()
        let neutrophil =  RespiratoryLabRelativeImportance.neutrophil.getConvertedValueFromPercentage()
        
        let totalLabScore1 = carbonDioxide + WBC
        let totalLabScore2 = sodium + chloride + neutrophil
        
        return Double(totalLabScore1  + totalLabScore2);
    }
    
    func totalLabScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        //print(totalAmount) // 4500.0
        
        arrayDayWiseScoreTotal = []
        
        var cardioLab:[Metrix] = []
        
        cardioLab.append(contentsOf: carbonDioxideData)
        cardioLab.append(contentsOf: WBCData)
        cardioLab.append(contentsOf: neutrophilData)
        cardioLab.append(contentsOf: sodiumData)
        cardioLab.append(contentsOf: chlorideData)
        
        arrayDayWiseScoreTotal = daywiseFilterMetrixsData(days: days, array: cardioLab, metriXType: MetricsType.LabData)
        cardioLab = []
        
        return arrayDayWiseScoreTotal
    }
    
    func dictionaryRepresentation()->[LabModel]{
        
        let objModel = AcuityDetailConditionViewModel()
        return objModel.getLabData()
        
    }
}
