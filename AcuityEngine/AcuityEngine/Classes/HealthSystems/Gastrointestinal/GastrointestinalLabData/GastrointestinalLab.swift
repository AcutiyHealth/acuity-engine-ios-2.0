//
//  CardioLab.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class GastrointestinalLab {
    /*blood glucose
     Sodium
     Potassium level
     chloride
     BUN
     Creatinine
     Albumin
     AST
     ALT */
    var bloodGlucoseData:[GastrointestinalLabData] = []
    var sodiumData:[GastrointestinalLabData] = []
    var potassiumLevelData:[GastrointestinalLabData] = []
    
    var chlorideData:[GastrointestinalLabData]  = []
    var BUNData:[GastrointestinalLabData] = []
    var creatinineData:[GastrointestinalLabData] = []
    
    var albuminData:[GastrointestinalLabData]  = []
    var ASTData:[GastrointestinalLabData] = []
    var ALTData:[GastrointestinalLabData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalLabDataScore() -> Double {
        
        return 0;
    }
    
    func getMaxLabDataScore() -> Double {
        
        let bloodGlucose = GastrointestinalLabRelativeImportance.bloodGlucose.getConvertedValueFromPercentage()
        let sodium = GastrointestinalLabRelativeImportance.sodium.getConvertedValueFromPercentage()
        let potassiumLevel = GastrointestinalLabRelativeImportance.potassiumLevel.getConvertedValueFromPercentage()
        
        let chloride = GastrointestinalLabRelativeImportance.chloride.getConvertedValueFromPercentage()
        let BUN = GastrointestinalLabRelativeImportance.BUN.getConvertedValueFromPercentage()
        let creatinine = GastrointestinalLabRelativeImportance.creatinine.getConvertedValueFromPercentage()
        
        let albumin = GastrointestinalLabRelativeImportance.albumin.getConvertedValueFromPercentage()
        let AST = GastrointestinalLabRelativeImportance.AST.getConvertedValueFromPercentage()
        let ALT = GastrointestinalLabRelativeImportance.ALT
            .getConvertedValueFromPercentage()
        
        let totalLabScore1 = bloodGlucose + sodium + potassiumLevel
        let totalLabScore2 = chloride + BUN + creatinine
        let totalLabScore3 = albumin + AST + ALT
        
        return Double(totalLabScore1 + totalLabScore2 + totalLabScore3);
    }
    
    func totalLabScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        arrayDayWiseScoreTotal = []
        
        var hematoLab:[Metrix] = []
       
        hematoLab.append(contentsOf: bloodGlucoseData)
        hematoLab.append(contentsOf: sodiumData)
        hematoLab.append(contentsOf: potassiumLevelData)
        hematoLab.append(contentsOf: chlorideData)
        hematoLab.append(contentsOf: BUNData)
        hematoLab.append(contentsOf: creatinineData)
        hematoLab.append(contentsOf: albuminData)
        hematoLab.append(contentsOf: ASTData)
        hematoLab.append(contentsOf: ALTData)
        
        arrayDayWiseScoreTotal = daywiseFilterMetrixsData(days: days, array: hematoLab, metriXType: MetricsType.LabData)
        hematoLab = []
        
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[LabModel]{
        
        let objModel = AcuityMetricsDetailViewModel()
        return objModel.getLabData()
        
    }
}
