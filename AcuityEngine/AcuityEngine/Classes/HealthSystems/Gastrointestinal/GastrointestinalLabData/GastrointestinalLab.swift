//
//  CardioLab.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class GastrointestinalLab {
    /*blood glucose
     Sodium
     Potassium level
     chloride
     BUN
     Creatinine
     Albumin
     AST
     ALT */
    var bloodGlucoseData:[GastrointestinalLabData] = []
    var sodiumData:[GastrointestinalLabData] = []
    var potassiumLevelData:[GastrointestinalLabData] = []
    
    var chlorideData:[GastrointestinalLabData]  = []
    var BUNData:[GastrointestinalLabData] = []
    var creatinineData:[GastrointestinalLabData] = []
    
    var albuminData:[GastrointestinalLabData]  = []
    var ASTData:[GastrointestinalLabData] = []
    var ALTData:[GastrointestinalLabData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalLabDataScore() -> Double {
        
        return 0;
    }
    
    func getMaxLabDataScore() -> Double {
        
        let bloodGlucose = GastrointestinalLabRelativeImportance.bloodGlucose.getConvertedValueFromPercentage()
        let sodium = GastrointestinalLabRelativeImportance.sodium.getConvertedValueFromPercentage()
        let potassiumLevel = GastrointestinalLabRelativeImportance.potassiumLevel.getConvertedValueFromPercentage()
        
        let chloride = GastrointestinalLabRelativeImportance.chloride.getConvertedValueFromPercentage()
        let BUN = GastrointestinalLabRelativeImportance.BUN.getConvertedValueFromPercentage()
        let creatinine = GastrointestinalLabRelativeImportance.creatinine.getConvertedValueFromPercentage()
        
        let albumin = GastrointestinalLabRelativeImportance.albumin.getConvertedValueFromPercentage()
        let AST = GastrointestinalLabRelativeImportance.AST.getConvertedValueFromPercentage()
        let ALT = GastrointestinalLabRelativeImportance.ALT
            .getConvertedValueFromPercentage()
        
        let totalLabScore1 = bloodGlucose + sodium + potassiumLevel
        let totalLabScore2 = chloride + BUN + creatinine
        let totalLabScore3 = albumin + AST + ALT
        
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
            
            //bloodGlucoseData
            let scoreBloodGlucose = getScoreForLabDataWithGivenDateRange(sampleItem: bloodGlucoseData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //sodiumData
            let scoreSodium = getScoreForLabDataWithGivenDateRange(sampleItem: sodiumData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //potassiumLevel
            let scorePotassiumLevel = getScoreForLabDataWithGivenDateRange(sampleItem: potassiumLevelData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //chlorideData
            let scoreChloride = getScoreForLabDataWithGivenDateRange(sampleItem: chlorideData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //BUNData
            let scoreBUN = getScoreForLabDataWithGivenDateRange(sampleItem: BUNData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //creatinineData
            let scoreCreatinine = getScoreForLabDataWithGivenDateRange(sampleItem: creatinineData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //albuminData
            let scoreAlbumin = getScoreForLabDataWithGivenDateRange(sampleItem: albuminData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //ASTData
            let scoreAST = getScoreForLabDataWithGivenDateRange(sampleItem: ASTData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //ALTData
            let scoreALT = getScoreForLabDataWithGivenDateRange(sampleItem: ALTData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scoreBloodGlucose + scoreSodium + scorePotassiumLevel + scoreChloride  + scoreBUN
            let totalScore2 = scoreCreatinine + scoreAlbumin + scoreAST + scoreALT
            arrayDayWiseScoreTotal.append(totalScore + totalScore2)
        }
        return arrayDayWiseScoreTotal
    }
    
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[LabModel]{
        
        var arrLab:[LabModel] = []
        
        var filterArray:[LabCalculation] = []
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore

        //bloodGlucoseData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: bloodGlucoseData)
        if filterArray.count > 0{
            let bloodGlucose = filterArray[0]
            arrLab.append(getLabModel(item: bloodGlucose))
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
        //chlorideData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: chlorideData)
        if filterArray.count > 0{
            let chloride = filterArray[0]
            arrLab.append(getLabModel(item: chloride))
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
        //albuminData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: albuminData)
        if filterArray.count > 0{
            let albumin = filterArray[0]
            arrLab.append(getLabModel(item: albumin))
        }
        //AST
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: ASTData)
        if filterArray.count > 0{
            let AST = filterArray[0]
            arrLab.append(getLabModel(item: AST))
        }
        //ALTData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: ALTData)
        if filterArray.count > 0{
            let ALT = filterArray[0]
            arrLab.append(getLabModel(item: ALT))
        }
        return arrLab
    }
    
    //Get list of data for specific Lab in detail screen..
    func getArrayDataForLabs(days:SegmentValueForGraph,title:String) -> [LabModel]{
        
        var arrLab:[LabModel] = []
        let labName = LabType(rawValue: title)
        var filterArray:[LabCalculation] = []
        /*blood glucose
         Sodium
         Potassium level
         chloride
         BUN
         Creatinine
         Albumin
         AST
         ALT */
        switch labName {
        //bloodGlucose
        case .bloodGlucose:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: bloodGlucoseData)
        //sodium
        case .sodium:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: sodiumData)
        //potassiumLevel
        case .potassiumLevel:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: potassiumLevelData)
        //chloride
        case .chloride:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: chlorideData)
        //BUN
        case .BUN:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: BUNData)
        //creatinine
        case .creatinine:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: creatinineData)
        //albumin
        case .albumin:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: albuminData)
        //AST
        case .AST:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: ASTData)
        //ALT
        case .ALT:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: ALTData)
            
        default:
            break
        }
        for item in filterArray{
            arrLab.append(saveLabsInArray(item: item))
        }
        return arrLab
    }
}

