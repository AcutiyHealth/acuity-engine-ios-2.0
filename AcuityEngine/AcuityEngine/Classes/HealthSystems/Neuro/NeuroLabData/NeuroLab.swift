//
//  NeuroLab.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class NeuroLab {
    /*Vitamin B12
     Sodium
     carbon dioxide*/
    var vitaminB12Data:[NeuroLabData] = []
    var sodiumData:[NeuroLabData] = []
    var carbonDioxideData:[NeuroLabData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    var arrLab:[LabModel] = []
    func totalLabDataScore() -> Double {
        
        return 0;
    }
    
    func getMaxLabDataScore() -> Double {
        
        let vitaminB12 = NeuroLabRelativeImportance.vitaminB12.getConvertedValueFromPercentage()
        let sodium = NeuroLabRelativeImportance.sodium.getConvertedValueFromPercentage()
        let carbonDioxide = NeuroLabRelativeImportance.carbonDioxide.getConvertedValueFromPercentage()
        
        let totalLabScore1 = vitaminB12 + sodium + carbonDioxide
        
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
            
            //vitaminB12Data
            let scorevitaminB12 = getScoreForLabDataWithGivenDateRange(sampleItem: vitaminB12Data, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //sodiumData
            let scoresodium = getScoreForLabDataWithGivenDateRange(sampleItem: sodiumData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //carbonDioxide
            let scorecarbonDioxide = getScoreForLabDataWithGivenDateRange(sampleItem: carbonDioxideData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scorevitaminB12 + scoresodium + scorecarbonDioxide
            
            arrayDayWiseScoreTotal.append(totalScore)
        }
        return arrayDayWiseScoreTotal
    }
    
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[LabModel]{
        
        arrLab = []
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        
        //vitaminB12
        filterLabArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: vitaminB12Data)
        
        //sodiumData
        filterLabArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: sodiumData)
        
        //carbonDioxideData
        filterLabArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: carbonDioxideData)
        
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
        //vitaminB12
        case .vitaminB12:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: vitaminB12Data)
        //sodium
        case .sodium:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: sodiumData)
        //carbonDioxide
        case .carbonDioxide:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: carbonDioxideData)
            
        default:
            break
        }
        for item in filterArray{
            arrLab.append(saveLabsInArray(item: item))
        }
        return arrLab
    }
}

