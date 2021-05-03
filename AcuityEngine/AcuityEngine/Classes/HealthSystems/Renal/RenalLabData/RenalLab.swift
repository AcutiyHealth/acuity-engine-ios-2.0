//
//  CardioLab.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani  on 05/02/21.
//

import UIKit

class RenalLab {
    
    var bunData:[RenalLabData] = []
    var creatinineData:[RenalLabData]  = []
    var bloodGlucoseData:[RenalLabData] = []
    var carbonDioxideData:[RenalLabData] = []
    var potassiumLevelData:[RenalLabData] = []
    var calciumData:[RenalLabData] = []
    var chlorideData:[RenalLabData] = []
    var albuminData:[RenalLabData] = []
    var anionGapData:[RenalLabData] = []
    var hemaglobinData:[RenalLabData] = []
    var microalbuminData:[RenalLabData] = []
    var eGFRData:[RenalLabData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalLabDataScore() -> Double {
        let bun = (Double(bunData.average(\.score) ).isNaN ? 0 : Double(bunData.average(\.score) ) )
        let creatinine = (Double(creatinineData.average(\.score) ).isNaN ? 0 : Double(creatinineData.average(\.score) ) )
        let bloodGlucose = (Double(bloodGlucoseData.average(\.score) ).isNaN ? 0 : Double(bloodGlucoseData.average(\.score) ) )
        let carbonDioxide = (Double(carbonDioxideData.average(\.score) ).isNaN ? 0 : Double(carbonDioxideData.average(\.score) ) )
        let potassiumLevel = (Double(potassiumLevelData.average(\.score) ).isNaN ? 0 : Double(potassiumLevelData.average(\.score) ) )
        let calcium = (Double(calciumData.average(\.score) ).isNaN ? 0 : Double(calciumData.average(\.score) ) )
        let chloride = (Double(chlorideData.average(\.score) ).isNaN ? 0 : Double(chlorideData.average(\.score) ) )
        let albumin = (Double(albuminData.average(\.score) ).isNaN ? 0 : Double(albuminData.average(\.score) ) )
        let anionGap = (Double(anionGapData.average(\.score) ).isNaN ? 0 : Double(anionGapData.average(\.score) ) )
        let hemaglobin = (Double(hemaglobinData.average(\.score) ).isNaN ? 0 : Double(hemaglobinData.average(\.score) ) )
        let microalbumin = (Double(microalbuminData.average(\.score) ).isNaN ? 0 : Double(microalbuminData.average(\.score) ) )
        let eGFR = (Double(eGFRData.average(\.score) ).isNaN ? 0 : Double(eGFRData.average(\.score) ) )

        let totalLabScore1 = bun + creatinine + bloodGlucose + carbonDioxide + potassiumLevel
        let totalLabScore2 = calcium + chloride + albumin + anionGap + hemaglobin + microalbumin + eGFR
        
        return Double(totalLabScore1  + totalLabScore2);
    }
    
    func getMaxLabDataScore() -> Double {
   
        let bun = RenalLabRelativeImportance.BUN.getConvertedValueFromPercentage()
        let creatinine = RenalLabRelativeImportance.creatinine.getConvertedValueFromPercentage()
        let bloodGlucose = RenalLabRelativeImportance.bloodGlucose.getConvertedValueFromPercentage()
        let carbonDioxide = RenalLabRelativeImportance.carbonDioxide.getConvertedValueFromPercentage()
        let potassiumLevel = RenalLabRelativeImportance.potassiumLevel.getConvertedValueFromPercentage()
        let calcium = RenalLabRelativeImportance.calcium.getConvertedValueFromPercentage()
        let chloride = RenalLabRelativeImportance.chloride.getConvertedValueFromPercentage()
        let albumin = RenalLabRelativeImportance.albumin.getConvertedValueFromPercentage()
        let anionGap = RenalLabRelativeImportance.anionGap.getConvertedValueFromPercentage()
        let hemaglobin = RenalLabRelativeImportance.hemoglobin.getConvertedValueFromPercentage()
        let microalbumin = RenalLabRelativeImportance.microalbumin.getConvertedValueFromPercentage()
        let eGFR = RenalLabRelativeImportance.eGFR.getConvertedValueFromPercentage()

        let totalLabScore1 = bun + creatinine + bloodGlucose + carbonDioxide + potassiumLevel
        let totalLabScore2 = calcium + chloride + albumin + anionGap + hemaglobin + microalbumin + eGFR
        
        return Double(totalLabScore1  + totalLabScore2);
    }
    
    func totalLabScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        arrayDayWiseScoreTotal = []
        
        var cardioLab:[Metrix] = []
        
        cardioLab.append(contentsOf: bunData)
        cardioLab.append(contentsOf: creatinineData)
        cardioLab.append(contentsOf: bloodGlucoseData)
        cardioLab.append(contentsOf: carbonDioxideData)
        cardioLab.append(contentsOf: potassiumLevelData)
        cardioLab.append(contentsOf: calciumData)
        cardioLab.append(contentsOf: chlorideData)
        cardioLab.append(contentsOf: albuminData)
        cardioLab.append(contentsOf: anionGapData)
        cardioLab.append(contentsOf: hemaglobinData)
        cardioLab.append(contentsOf: microalbuminData)
        cardioLab.append(contentsOf: eGFRData)
        
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
