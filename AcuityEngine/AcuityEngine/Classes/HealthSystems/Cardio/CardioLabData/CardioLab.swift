//
//  CardioLab.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class CardioLab {
    /*
     Potassium level
     Sodium
     chloride
     Albumin (
     microalbumin/creat ratio
     B-peptide
     Hemoglobin
     */
    var potassiumLevelData:[CardioLabData] = []
    var bPeptideData:[CardioLabData]  = []
    var sodiumData:[CardioLabData] = []
    var chlorideData:[CardioLabData] = []
    var albuminData:[CardioLabData] = []
    var microalbuminData:[CardioLabData] = []
    var hemoglobinData:[CardioLabData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalLabDataScore() -> Double {
        let potassiumLevel = (Double(potassiumLevelData.average(\.score) ).isNaN ? 0 : Double(potassiumLevelData.average(\.score) ) )
        let bPeptide = (Double(bPeptideData.average(\.score)) .isNaN ? 0 : Double(bPeptideData.average(\.score)))
        let sodium = (Double(sodiumData.average(\.score)).isNaN ? 0 : Double(sodiumData.average(\.score)))
        let chloride = (Double(chlorideData.average(\.score)).isNaN ? 0 :  Double(chlorideData.average(\.score)))
        let albumin = (Double(albuminData.average(\.score)).isNaN ? 0 : Double(albuminData.average(\.score)))
        let microalbumin = (Double(microalbuminData.average(\.score)).isNaN ? 0 : Double(microalbuminData.average(\.score)))
        let hemoglobin = (Double(hemoglobinData.average(\.score)).isNaN ? 0 : Double(hemoglobinData.average(\.score)))
        
        
        let totalLabScore1 = potassiumLevel + bPeptide
        let totalLabScore2 =  albumin + microalbumin
        let totalLabScore3 = sodium + chloride + hemoglobin
        
        return Double(totalLabScore1  + totalLabScore3 + totalLabScore2);
    }
    
    func getMaxLabDataScore() -> Double {
        let potassiumLevel = CardioLabRelativeImportance.potassiumLevel.getConvertedValueFromPercentage()
        let bPeptide = CardioLabRelativeImportance.bPeptide.getConvertedValueFromPercentage()
        let sodium = CardioLabRelativeImportance.sodium.getConvertedValueFromPercentage()
        let chloride = CardioLabRelativeImportance.chloride.getConvertedValueFromPercentage()
        let albumin = CardioLabRelativeImportance.albumin.getConvertedValueFromPercentage()
        let microalbumin = CardioLabRelativeImportance.microalbumin.getConvertedValueFromPercentage()
        let hemoglobin = CardioLabRelativeImportance.hemoglobin.getConvertedValueFromPercentage()
        
        
        let totalLabScore1 = potassiumLevel + bPeptide
        let totalLabScore2 =  albumin + microalbumin
        let totalLabScore3 = sodium + chloride + hemoglobin
        
        return Double(totalLabScore1  + totalLabScore3 + totalLabScore2);
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
            
            //potassiumLevelData
            let scorepotassiumLevel = getScoreForLabDataWithGivenDateRange(sampleItem: potassiumLevelData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //sodiumData
            let scoreSodium = getScoreForLabDataWithGivenDateRange(sampleItem: sodiumData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //chlorideData
            let scoreChloride = getScoreForLabDataWithGivenDateRange(sampleItem: chlorideData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //albuminData
            let scoreAlbumin = getScoreForLabDataWithGivenDateRange(sampleItem: albuminData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //microalbuminData
            let scoreMicroalbumin = getScoreForLabDataWithGivenDateRange(sampleItem: microalbuminData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //bPeptideData
            let scorebPeptide = getScoreForLabDataWithGivenDateRange(sampleItem: bPeptideData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //hemoglobinData
            let scorhemoglobin = getScoreForLabDataWithGivenDateRange(sampleItem: hemoglobinData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scorepotassiumLevel + scoreSodium + scoreChloride + scoreAlbumin  + scoreMicroalbumin + scorebPeptide  + scorhemoglobin
            arrayDayWiseScoreTotal.append(totalScore)
        }
        print("cardio lab score",arrayDayWiseScoreTotal)
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[LabModel]{
        
        var arrLab:[LabModel] = []
        /*
         Potassium level
         Sodium
         chloride
         Albumin (
         microalbumin/creat ratio
         B-peptide
         Hemoglobin
         */
        //potassiumLevelData
        var filterArray:[LabCalculation] = []
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: potassiumLevelData)
        if filterArray.count > 0{
            let potassiumLevel = filterArray[0]
            arrLab.append(getLabModel(item: potassiumLevel))
        }
        //sodiumData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: sodiumData)
        if filterArray.count > 0{
            let sodium = filterArray[0]
            arrLab.append(getLabModel(item: sodium))
        }
        //chlorideData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: chlorideData)
        if filterArray.count > 0{
            let chloride = filterArray[0]
            arrLab.append(getLabModel(item: chloride))
        }
        //albuminData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: albuminData)
        if filterArray.count > 0{
            let albumin = filterArray[0]
            arrLab.append(getLabModel(item: albumin))
        }
        //microalbuminData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: microalbuminData)
        if filterArray.count > 0{
            let microalbumin = filterArray[0]
            arrLab.append(getLabModel(item: microalbumin))
        }
        //bPeptideData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: bPeptideData)
        if filterArray.count > 0{
            let bPeptide = filterArray[0]
            arrLab.append(getLabModel(item: bPeptide))
        }
        //hemoglobinData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: hemoglobinData)
        if filterArray.count > 0{
            let hemoglobin = filterArray[0]
            arrLab.append(getLabModel(item: hemoglobin))
        }
        
        return arrLab
    }
    
    //Get list of data for specific Lab in detail screen..
    func getArrayDataForLabs(days:SegmentValueForGraph,title:String) -> [LabModel]{
        /*
         Potassium level
         Sodium
         chloride
         Albumin (
         microalbumin/creat ratio
         B-peptide
         Hemoglobin
         */
        var arrLab:[LabModel] = []
        let labName = LabType(rawValue: title)
        var filterArray:[LabCalculation] = []
        
        switch labName {
        case .potassiumLevel:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: potassiumLevelData)
            
        case .sodium:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: sodiumData)
            
        case .chloride:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: chlorideData)
            
        case .albumin:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: albuminData)
            
        case .microalbuminCreatinineRatio:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: microalbuminData)
            
        case .bPeptide:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: bPeptideData)
            
        case .hemoglobin:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: hemoglobinData)
            
        default:
            break
        }
        for item in filterArray{
            arrLab.append(saveLabsInArray(item: item))
        }
        return arrLab
    }
}
