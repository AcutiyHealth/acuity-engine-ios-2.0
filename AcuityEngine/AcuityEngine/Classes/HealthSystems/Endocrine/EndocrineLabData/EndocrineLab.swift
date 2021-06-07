//
//  CardioLab.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class EndocrineLab {
    /*hemoglobin A1c
     TSH
     microalbumin/creatinine ratio
     Sodium
     Potassium level
     BUN
     creatinine
     chloride
     Calcium
     Albumin
     Anion gap
     blood glucose */
    var hemaglobinA1cData:[EndocrineLabData] = []
    var TSHData:[EndocrineLabData]  = []
    var microalbuminCreatinineRatioData:[EndocrineLabData] = []
    
    var sodiumData:[EndocrineLabData] = []
    var potassiumLevelData:[EndocrineLabData] = []
    var BUNData:[EndocrineLabData] = []
    
    var creatinineData:[EndocrineLabData] = []
    var chlorideData:[EndocrineLabData]  = []
    var calciumData:[EndocrineLabData] = []
    
    var albuminData:[EndocrineLabData]  = []
    var anionGapData:[EndocrineLabData]  = []
    var bloodGlucoseData:[EndocrineLabData]  = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalLabDataScore() -> Double {
        
        return 0;
    }
    
    func getMaxLabDataScore() -> Double {
        
        let hemoglobinA1C = EndocrineLabRelativeImportance.hemoglobinA1C.getConvertedValueFromPercentage()
        let TSH = EndocrineLabRelativeImportance.TSH.getConvertedValueFromPercentage()
        let microalbuminCreatinineRatio = EndocrineLabRelativeImportance.microalbuminCreatinineRatio.getConvertedValueFromPercentage()
        
        let sodium = EndocrineLabRelativeImportance.sodium.getConvertedValueFromPercentage()
        let potassiumLevel = EndocrineLabRelativeImportance.potassiumLevel.getConvertedValueFromPercentage()
        let BUN = EndocrineLabRelativeImportance.BUN.getConvertedValueFromPercentage()
        
        let creatinine = EndocrineLabRelativeImportance.creatinine.getConvertedValueFromPercentage()
        let chloride = EndocrineLabRelativeImportance.chloride.getConvertedValueFromPercentage()
        let calcium = EndocrineLabRelativeImportance.calcium.getConvertedValueFromPercentage()
        
        let albumin = EndocrineLabRelativeImportance.albumin.getConvertedValueFromPercentage()
        let anionGap = EndocrineLabRelativeImportance.anionGap.getConvertedValueFromPercentage()
        let bloodGlucose = EndocrineLabRelativeImportance.bloodGlucose.getConvertedValueFromPercentage()
        
        let totalLabScore1 = hemoglobinA1C + TSH + microalbuminCreatinineRatio
        let totalLabScore2 = sodium + potassiumLevel + BUN
        let totalLabScore3 = creatinine + chloride + calcium
        let totalLabScore4 = albumin + anionGap + bloodGlucose
        
        return Double(totalLabScore1 + totalLabScore2 + totalLabScore3 + totalLabScore4);
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
            
            //hemaglobinA1cData
            let scoreHemaglobinA1c = getScoreForLabDataWithGivenDateRange(sampleItem: hemaglobinA1cData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //TSHData
            let scoreTSH = getScoreForLabDataWithGivenDateRange(sampleItem: TSHData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //microalbuminCreatinineRatioData
            let scoreMicroalbumin = getScoreForLabDataWithGivenDateRange(sampleItem: microalbuminCreatinineRatioData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //sodiumData
            let scoreSodium = getScoreForLabDataWithGivenDateRange(sampleItem: sodiumData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //potassiumLevelData
            let scorePotassiumLevel = getScoreForLabDataWithGivenDateRange(sampleItem: potassiumLevelData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //BUNData
            let scoreBUN = getScoreForLabDataWithGivenDateRange(sampleItem: BUNData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //creatinineData
            let scoreCreatinine = getScoreForLabDataWithGivenDateRange(sampleItem: creatinineData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //chlorideData
            let scoreChloride = getScoreForLabDataWithGivenDateRange(sampleItem: chlorideData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //calciumData
            let scoreCalcium = getScoreForLabDataWithGivenDateRange(sampleItem: calciumData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //albuminData
            let scoreAlbumin = getScoreForLabDataWithGivenDateRange(sampleItem: albuminData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //anionGapData
            let scoreAnionGap = getScoreForLabDataWithGivenDateRange(sampleItem: anionGapData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //bloodGlucoseData
            let scoreBloodGlucose = getScoreForLabDataWithGivenDateRange(sampleItem: bloodGlucoseData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scoreHemaglobinA1c + scoreTSH + scoreMicroalbumin + scoreSodium  + scorePotassiumLevel
            let totalScore2 = scoreBUN + scoreCreatinine + scoreChloride + scoreCalcium + scoreAlbumin + scoreAnionGap + scoreBloodGlucose
            arrayDayWiseScoreTotal.append(totalScore + totalScore2)
        }
        return arrayDayWiseScoreTotal
    }
    
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[LabModel]{
        
        var arrLab:[LabModel] = []
        
        var filterArray:[LabCalculation] = []
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        
        //hemaglobinA1cData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: hemaglobinA1cData)
        if filterArray.count > 0{
            let hemaglobinA1c = filterArray[0]
            arrLab.append(getLabModel(item: hemaglobinA1c))
        }
        //TSHData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: TSHData)
        if filterArray.count > 0{
            let TSH = filterArray[0]
            arrLab.append(getLabModel(item: TSH))
        }
        //microalbuminCreatinineRatioData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array:  microalbuminCreatinineRatioData)
        if filterArray.count > 0{
            let microalbuminCreatinineRatio = filterArray[0]
            arrLab.append(getLabModel(item: microalbuminCreatinineRatio))
        }
        //sodiumData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: sodiumData)
        if filterArray.count > 0{
            let sodium = filterArray[0]
            arrLab.append(getLabModel(item: sodium))
        }
        //potassiumLevelData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: potassiumLevelData)
        if filterArray.count > 0{
            let potassiumLevel = filterArray[0]
            arrLab.append(getLabModel(item: potassiumLevel))
        }
        //BUNData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: BUNData)
        if filterArray.count > 0{
            let BUN = filterArray[0]
            arrLab.append(getLabModel(item: BUN))
        }
        //creatinineData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: creatinineData)
        if filterArray.count > 0{
            let creatinine = filterArray[0]
            arrLab.append(getLabModel(item: creatinine))
        }
        //chlorideData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: chlorideData)
        if filterArray.count > 0{
            let chloride = filterArray[0]
            arrLab.append(getLabModel(item: chloride))
        }
        //calciumData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: calciumData)
        if filterArray.count > 0{
            let calcium = filterArray[0]
            arrLab.append(getLabModel(item: calcium))
        }
        //albuminData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: albuminData)
        if filterArray.count > 0{
            let albumin = filterArray[0]
            arrLab.append(getLabModel(item: albumin))
        }
        //anionGapData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: anionGapData)
        if filterArray.count > 0{
            let anionGap = filterArray[0]
            arrLab.append(getLabModel(item: anionGap))
        }
        //bloodGlucoseData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: bloodGlucoseData)
        if filterArray.count > 0{
            let bloodGlucose = filterArray[0]
            arrLab.append(getLabModel(item: bloodGlucose))
        }
        return arrLab
    }
    
    //Get list of data for specific Lab in detail screen..
    func getArrayDataForLabs(days:SegmentValueForGraph,title:String) -> [LabModel]{
        
        var arrLab:[LabModel] = []
        let labName = LabType(rawValue: title)
        var filterArray:[LabCalculation] = []
     
        switch labName {
        //hemoglobinA1C
        case .hemoglobinA1C:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: hemaglobinA1cData)
        //TSH
        case .TSH:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: TSHData)
        //microalbuminCreatinineRatio
        case .microalbuminCreatinineRatio:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: microalbuminCreatinineRatioData)
        //sodium
        case .sodium:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: sodiumData)
        //potassiumLevel
        case .potassiumLevel:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: potassiumLevelData)
        //BUN
        case .BUN:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: BUNData)
        //creatinine
        case .creatinine:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: creatinineData)
        //chloride
        case .chloride:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: chlorideData)
        //calcium
        case .calcium:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: calciumData)
        //albumin
        case .albumin:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: albuminData)
        //anionGap
        case .anionGap:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: anionGapData)
        //bloodGlucose
        case .bloodGlucose:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: bloodGlucoseData)
            
        default:
            break
        }
        for item in filterArray{
            arrLab.append(saveLabsInArray(item: item))
        }
        return arrLab
    }
}

