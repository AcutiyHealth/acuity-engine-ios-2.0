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
        /*
         Here We get component is Month/Day and noOfTimesLoopExecute to execute.
         We get selection from Segment Control from Pull up
         When there is & days selected, loop will execute 7 times
         When there is 1 Month selected, loop will execute per weeks count
         When there is 3 month selected, loop will execute 3 times
         */
        var now = MyWellScore.sharedManager.todaysDate
        let getComponentAndLoop = getNumberOfTimesLoopToExecute(days: days)
        let component:Calendar.Component = getComponentAndLoop["component"] as! Calendar.Component
        let noOfTimesLoopExecute:Int = getComponentAndLoop["noOfTimesLoopExecute"] as! Int
        
        for _ in 0...noOfTimesLoopExecute-1{
            
            let day = Calendar.current.date(byAdding: component, value: -1, to: now)!
            
            let timeIntervalByLastMonth:Double = day.timeIntervalSince1970
            //print("timeIntervalByLastMonth",getDateMediumFormat(time:timeIntervalByLastMonth))
            let timeIntervalByNow:Double = now.timeIntervalSince1970
            //print("timeIntervalByNow",getDateMediumFormat(time:timeIntervalByNow))
            now = day
            
            
            //hemaglobinData
            let scoreHemaglobin = getScoreForLabDataWithGivenDateRange(sampleItem: hemaglobinData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //plateletsData
            let scorePlatelets = getScoreForLabDataWithGivenDateRange(sampleItem: plateletsData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //WBCData
            let scoreWBC = getScoreForLabDataWithGivenDateRange(sampleItem: WBCData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //neutrophilData
            let scoreNeutrophil = getScoreForLabDataWithGivenDateRange(sampleItem: neutrophilData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //MCVData
            let scoreMCV = getScoreForLabDataWithGivenDateRange(sampleItem: MCVData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //alkalinePhosphataseData
            let scoreAlkalinePhosphatase = getScoreForLabDataWithGivenDateRange(sampleItem: alkalinePhosphataseData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //anionGapData
            let scoreAnionGap = getScoreForLabDataWithGivenDateRange(sampleItem: anionGapData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //b12LevelData
            let scoreB12Level = getScoreForLabDataWithGivenDateRange(sampleItem: b12LevelData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scoreHemaglobin + scorePlatelets + scoreWBC + scoreNeutrophil  + scoreMCV + scoreAlkalinePhosphatase + scoreAnionGap + scoreB12Level
            arrayDayWiseScoreTotal.append(totalScore)
        }
        return arrayDayWiseScoreTotal
    }
    
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[LabModel]{
        
        var arrLab:[LabModel] = []
        
        var filterArray:[LabCalculation] = []
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        
        //hemaglobinData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: hemaglobinData)
        if filterArray.count > 0{
            let hemaglobin = filterArray[0]
            arrLab.append(getLabModel(item: hemaglobin))
        }
        //plateletsData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: plateletsData)
        if filterArray.count > 0{
            let platelets = filterArray[0]
            arrLab.append(getLabModel(item: platelets))
        }
        //WBCData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: WBCData)
        if filterArray.count > 0{
            let WBC = filterArray[0]
            arrLab.append(getLabModel(item: WBC))
        }
        
        //neutrophilData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: neutrophilData)
        if filterArray.count > 0{
            let neutrophil = filterArray[0]
            arrLab.append(getLabModel(item: neutrophil))
        }
        //MCVData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: MCVData)
        if filterArray.count > 0{
            let MCV = filterArray[0]
            arrLab.append(getLabModel(item: MCV))
        }
        //alkalinePhosphataseData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: alkalinePhosphataseData)
        if filterArray.count > 0{
            let alkalinePhosphatase = filterArray[0]
            arrLab.append(getLabModel(item: alkalinePhosphatase))
        }
        //anionGapData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: anionGapData)
        if filterArray.count > 0{
            let anionGap = filterArray[0]
            arrLab.append(getLabModel(item: anionGap))
        }
        //b12LevelData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: b12LevelData)
        if filterArray.count > 0{
            let b12Level = filterArray[0]
            arrLab.append(getLabModel(item: b12Level))
        }
        return arrLab
    }
    
    //Get list of data for specific Lab in detail screen..
    func getArrayDataForLabs(days:SegmentValueForGraph,title:String) -> [LabModel]{
        
        var arrLab:[LabModel] = []
        let labName = LabType(rawValue: title)
        var filterArray:[LabCalculation] = []
        
        switch labName {
        
        //hemoglobin
        case .hemoglobin:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: hemaglobinData)
        //platelets
        case .platelets:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: plateletsData)
        //WBC
        case .WBC:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: WBCData)
        //neutrophil
        case .neutrophil:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: neutrophilData)
        //MCV
        case .MCV:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: MCVData)
        //alkalinePhosphatase
        case .alkalinePhosphatase:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: alkalinePhosphataseData)
        //anionGap
        case .anionGap:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: anionGapData)
        //b12Level
        case .b12Level:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: b12LevelData)
            
            
        default:
            break
        }
        for item in filterArray{
            arrLab.append(saveLabsInArray(item: item))
        }
        return arrLab
    }
}


