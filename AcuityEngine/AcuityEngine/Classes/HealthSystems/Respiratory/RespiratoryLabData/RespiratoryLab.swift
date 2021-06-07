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
    var sodiumData:[RespiratoryLabData] = []
    var carbonDioxideData:[RespiratoryLabData]  = []
    var chlorideData:[RespiratoryLabData] = []
    var WBCData:[RespiratoryLabData] = []
    var neutrophilData:[RespiratoryLabData] = []
    
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
            
            //sodiumData
            let scoresodiumData = getScoreForLabDataWithGivenDateRange(sampleItem: sodiumData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //carbonDioxideData
            let scorecarbonDioxide = getScoreForLabDataWithGivenDateRange(sampleItem: carbonDioxideData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //chlorideData
            let scoreChloride = getScoreForLabDataWithGivenDateRange(sampleItem: chlorideData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //WBCData
            let scoreWBCData = getScoreForLabDataWithGivenDateRange(sampleItem: WBCData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //neutrophilData
            let scoreneutrophilData = getScoreForLabDataWithGivenDateRange(sampleItem: neutrophilData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scoresodiumData + scorecarbonDioxide + scoreChloride + scoreWBCData  + scoreneutrophilData
            arrayDayWiseScoreTotal.append(totalScore)
        }
        return arrayDayWiseScoreTotal
    }
    
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[LabModel]{
        
        var arrLab:[LabModel] = []
        
        var filterArray:[LabCalculation] = []
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        //sodiumData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: sodiumData)
        if filterArray.count > 0{
            let sodium = filterArray[0]
            arrLab.append(getLabModel(item: sodium))
        }
        //carbonDioxideData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: carbonDioxideData)
        if filterArray.count > 0{
            let carbonDioxide = filterArray[0]
            arrLab.append(getLabModel(item: carbonDioxide))
        }
        //chlorideData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: chlorideData)
        if filterArray.count > 0{
            let chloride = filterArray[0]
            arrLab.append(getLabModel(item: chloride))
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
        
        return arrLab
    }
    
    //Get list of data for specific Lab in detail screen..
    func getArrayDataForLabs(days:SegmentValueForGraph,title:String) -> [LabModel]{
        
        var arrLab:[LabModel] = []
        let labName = LabType(rawValue: title)
        var filterArray:[LabCalculation] = []
        
        switch labName {
        
        case .sodium:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: sodiumData)
            
        case .chloride:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: chlorideData)
            
        case .carbonDioxide:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: carbonDioxideData)
            
        case .WBC:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: WBCData)
            
        case .neutrophil:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: neutrophilData)
            
        default:
            break
        }
        for item in filterArray{
            arrLab.append(saveLabsInArray(item: item))
        }
        return arrLab
    }
}

