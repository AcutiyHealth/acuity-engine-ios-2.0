//
//  CardioLab.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class HematoLab {
    /*Hemaglobin
     Platelets
     WBCs
     Neutrophil %
     MCV
     Alkaline Phosphatase
     Anion gap
     B12 level */
    var hemaglobinData:[HematoLabData] = []
    var plateletsData:[HematoLabData]  = []
    var WBCData:[HematoLabData] = []
    
    var neutrophilData:[HematoLabData] = []
    var MCVData:[HematoLabData] = []
    var alkalinePhosphataseData:[HematoLabData] = []
    
    var anionGapData:[HematoLabData] = []
    var b12LevelData:[HematoLabData]  = []
   
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalLabDataScore() -> Double {
        
        return 0;
    }
    
    func getMaxLabDataScore() -> Double {
        
        let hemoglobin = HematoLabRelativeImportance.hemoglobin.getConvertedValueFromPercentage()
        let platelets = HematoLabRelativeImportance.platelets.getConvertedValueFromPercentage()
        let WBC = HematoLabRelativeImportance.WBC.getConvertedValueFromPercentage()
        
        let neutrophil = HematoLabRelativeImportance.neutrophil.getConvertedValueFromPercentage()
        let MCV = HematoLabRelativeImportance.MCV.getConvertedValueFromPercentage()
        let alkalinePhosphatase = HematoLabRelativeImportance.alkalinePhosphatase.getConvertedValueFromPercentage()
        
        let anion = HematoLabRelativeImportance.anionGap.getConvertedValueFromPercentage()
        let b12Level = HematoLabRelativeImportance.b12Level.getConvertedValueFromPercentage()
        
        let totalLabScore1 = hemoglobin + platelets + WBC
        let totalLabScore2 = neutrophil + MCV + alkalinePhosphatase
        let totalLabScore3 = anion + b12Level
     
        return Double(totalLabScore1 + totalLabScore2 + totalLabScore3);
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
         hematoLab.append(contentsOf: anionGapData)
         hematoLab.append(contentsOf: hemaglobinData)
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
