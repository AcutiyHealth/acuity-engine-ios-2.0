//
//  MuscLab.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class MuscLab {
    /*Alkaline Phosphatase
     Potassium level
     chloride
     Calcium
     ESR*/
    
    var alkalinePhosphataseData:[MuscLabData] = []
    var potassiumLevelData:[MuscLabData] = []
    var chlorideData:[MuscLabData] = []
    var calciumData:[MuscLabData] = []
    var ESRData:[MuscLabData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    var arrLab:[LabModel] = []
    
    func totalLabDataScore() -> Double {
        
        return 0;
    }
    
    func getMaxLabDataScore() -> Double {
        
        let alkalinePhosphatase = MuscLabRelativeImportance.alkalinePhosphatase.getConvertedValueFromPercentage()
        let potassiumLevel = MuscLabRelativeImportance.potassiumLevel.getConvertedValueFromPercentage()
        let chloride = MuscLabRelativeImportance.chloride.getConvertedValueFromPercentage()
        let calcium = MuscLabRelativeImportance.calcium.getConvertedValueFromPercentage()
        let ESR = MuscLabRelativeImportance.ESR.getConvertedValueFromPercentage()
        
        let totalLabScore1 = alkalinePhosphatase + potassiumLevel + chloride + calcium + ESR
        
        return Double(totalLabScore1);
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
            
            //alkalinePhosphatase
            let scorealkalinePhosphatase = getScoreForLabDataWithGivenDateRange(sampleItem: alkalinePhosphataseData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //potassiumLevel
            let scorepotassiumLevel = getScoreForLabDataWithGivenDateRange(sampleItem: potassiumLevelData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //chloride
            let scorechloride = getScoreForLabDataWithGivenDateRange(sampleItem: chlorideData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //calcium
            let scorecalcium = getScoreForLabDataWithGivenDateRange(sampleItem: calciumData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //ESR
            let scoreESR = getScoreForLabDataWithGivenDateRange(sampleItem: ESRData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scorealkalinePhosphatase + scorepotassiumLevel + scorechloride + scorecalcium + scoreESR
            
            arrayDayWiseScoreTotal.append(totalScore)
        }
        return arrayDayWiseScoreTotal
    }
    
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[LabModel]{
        
        arrLab = []
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        //alkalinePhosphatase
        filterLabArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: alkalinePhosphataseData)
        
        //potassiumLevel
        filterLabArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: potassiumLevelData)
        
        //chloride
        filterLabArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: chlorideData)
        
        //calcium
        filterLabArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: calciumData)
        
        //ESR
        filterLabArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: ESRData)
        return arrLab
    }
    func filterLabArrayToGetSingleDataWithSelectedSegmentInGraph(days:SegmentValueForGraph,array:[LabCalculation]){
        var filteredArray:[LabCalculation] = []
        filteredArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: array)
        saveFilterDataInArrayVitals(filteredArray: filteredArray)
        //return filteredArray
    }
    
    func saveFilterDataInArrayVitals(filteredArray:[LabCalculation]){
        if filteredArray.count > 0{
            let lab = filteredArray[0]
            arrLab.append(getLabModel(item: lab))
        }
    }
    
    //Get list of data for specific Lab in detail screen..
    func getArrayDataForLabs(days:SegmentValueForGraph,title:String) -> [LabModel]{
        
        var arrLab:[LabModel] = []
        let labName = LabType(rawValue: title)
        var filterArray:[LabCalculation] = []
        
        switch labName {
        //alkalinePhosphatase
        case .alkalinePhosphatase:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: alkalinePhosphataseData)
        //potassiumLevel
        case .potassiumLevel:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: potassiumLevelData)
        //chloride
        case .chloride:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: chlorideData)
        //calcium
        case .calcium:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: calciumData)
        //ESR
        case .ESR:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: ESRData)
        default:
            break
        }
        for item in filterArray{
            arrLab.append(saveLabsInArray(item: item))
        }
        return arrLab
    }
}

