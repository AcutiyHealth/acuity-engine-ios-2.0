//
//  HeentLab.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class HeentLab {
    /*WBC's
     Neutrophil %
     platelets*/
    
    var WBCData:[HeentLabData] = []
    var neutrophilData:[HeentLabData] = []
    var plateletsData:[HeentLabData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    var arrLab:[LabModel] = []
    
    func totalLabDataScore() -> Double {
        
        return 0;
    }
    
    func getMaxLabDataScore() -> Double {
        
        let WBC = HeentLabRelativeImportance.WBC.getConvertedValueFromPercentage()
        let neutrophil = HeentLabRelativeImportance.neutrophil.getConvertedValueFromPercentage()
        let platelets = HeentLabRelativeImportance.platelets.getConvertedValueFromPercentage()
        
        let totalLabScore1 = WBC + neutrophil + platelets
        
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
            
            //WBC
            let scoreWBC = getScoreForLabDataWithGivenDateRange(sampleItem: WBCData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //neutrophilData
            let scoreneutrophil = getScoreForLabDataWithGivenDateRange(sampleItem: neutrophilData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //platelets
            let scoreplatelets = getScoreForLabDataWithGivenDateRange(sampleItem: plateletsData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scoreWBC + scoreneutrophil + scoreplatelets
            
            arrayDayWiseScoreTotal.append(totalScore)
        }
        return arrayDayWiseScoreTotal
    }
    
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[LabModel]{
        
        arrLab = []
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        //WBC
        filterLabArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: WBCData)
        
        //neutrophil
        filterLabArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: neutrophilData)
        
        //platelets
        filterLabArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: plateletsData)
        
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
        //WBC
        case .WBC:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: WBCData)
        //neutrophil
        case .neutrophil:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: neutrophilData)
        //platelets
        case .platelets:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: plateletsData)
        default:
            break
        }
        for item in filterArray{
            arrLab.append(saveLabsInArray(item: item))
        }
        return arrLab
    }
}

