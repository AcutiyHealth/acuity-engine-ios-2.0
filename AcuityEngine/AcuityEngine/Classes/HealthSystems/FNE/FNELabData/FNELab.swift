//
//  CardioLab.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class FNELab {
    /*blood glucose
     Sodium
     potassium
     BUN
     Creatinine
     eGFR
     Albumin
     microalbumin/creat ratio
     carbon dioxide
     Anion gap
     Calcium
     chloride
     Urine ketone
     MCV
     AST
     ALT */
    var bloddGlucoseData:[FNELabData] = []
    var sodiumData:[FNELabData]  = []
    var potassiumData:[FNELabData] = []
    
    var BUNData:[FNELabData] = []
    var creatinieData:[FNELabData] = []
    var eGFRData:[FNELabData] = []
    
    var albuminData:[FNELabData] = []
    var microAlbuminData:[FNELabData]  = []
    var carbonDioxideData:[FNELabData] = []
    
    var anionGapData:[FNELabData] = []
    var calciumData:[FNELabData] = []
    var chlorideData:[FNELabData] = []
    
    var urineKenoteData:[FNELabData] = []
    var MCVData:[FNELabData] = []
    var ASTData:[FNELabData] = []
    var ALTData:[FNELabData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalLabDataScore() -> Double {
        
        return 0;
    }
    
    func getMaxLabDataScore() -> Double {
        
        let bloodGlucose = FNELabRelativeImportance.bloodGlucose.getConvertedValueFromPercentage()
        let sodium = FNELabRelativeImportance.sodium.getConvertedValueFromPercentage()
        let potassiumLevel = FNELabRelativeImportance.potassiumLevel.getConvertedValueFromPercentage()
        
        let BUN = FNELabRelativeImportance.BUN.getConvertedValueFromPercentage()
        let creatinine = FNELabRelativeImportance.creatinine.getConvertedValueFromPercentage()
        let eGFR = FNELabRelativeImportance.eGFR.getConvertedValueFromPercentage()
        
        let albumin = FNELabRelativeImportance.albumin.getConvertedValueFromPercentage()
        let microalbumin = FNELabRelativeImportance.microalbumin.getConvertedValueFromPercentage()
        let carbonDioxide = FNELabRelativeImportance.carbonDioxide.getConvertedValueFromPercentage()
        
        let anionGap = FNELabRelativeImportance.anionGap.getConvertedValueFromPercentage()
        let calcium = FNELabRelativeImportance.calcium.getConvertedValueFromPercentage()
        let chloride = FNELabRelativeImportance.chloride.getConvertedValueFromPercentage()
        
        let urineKetone = FNELabRelativeImportance.urineKetone.getConvertedValueFromPercentage()
        let MCV = FNELabRelativeImportance.MCV.getConvertedValueFromPercentage()
        let AST = FNELabRelativeImportance.AST.getConvertedValueFromPercentage()
        let ALT = FNELabRelativeImportance.ALT.getConvertedValueFromPercentage()
        
        let totalLabScore1 = bloodGlucose + sodium + potassiumLevel
        let totalLabScore2 = BUN + creatinine + eGFR
        let totalLabScore3 = albumin + microalbumin + carbonDioxide
        let totalLabScore4 = anionGap + calcium + chloride
        let totalLabScore5 = urineKetone + MCV + AST + ALT
        
        return Double(totalLabScore1 + totalLabScore2 + totalLabScore3 + totalLabScore4 + totalLabScore5);
    }
    
    func totalLabScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        arrayDayWiseScoreTotal = []
        
        var iDiseaseLab:[Metrix] = []
        
        /*iDiseaseLab.append(contentsOf: bunData)
         iDiseaseLab.append(contentsOf: creatinineData)
         iDiseaseLab.append(contentsOf: bloodGlucoseData)
         iDiseaseLab.append(contentsOf: carbonDioxideData)
         iDiseaseLab.append(contentsOf: potassiumLevelData)
         iDiseaseLab.append(contentsOf: calciumData)
         iDiseaseLab.append(contentsOf: chlorideData)
         iDiseaseLab.append(contentsOf: albuminData)
         iDiseaseLab.append(contentsOf: anionGapData)
         iDiseaseLab.append(contentsOf: hemaglobinData)
         iDiseaseLab.append(contentsOf: microalbuminData)
         iDiseaseLab.append(contentsOf: eGFRData)*/
        
        arrayDayWiseScoreTotal = daywiseFilterMetrixsData(days: days, array: iDiseaseLab, metriXType: MetricsType.LabData)
        iDiseaseLab = []
        
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[LabModel]{
        
        let objModel = AcuityMetricsDetailViewModel()
        return objModel.getLabData()
        
    }
}
