//
//  CardioLab.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani  on 05/02/21.
//

import UIKit

class RenalLab {
    /*
     BUN (mg/dL)
     Creatinine
     blood glucose
     carbon dioxide
     Potassium level
     Calcium
     chloride
     Albumin
     Anion gap
     Hemaglobin
     microalbumin/creat ratio
     eGFR
     */
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
            
            //bunData
            let scoreBun = getScoreForLabDataWithGivenDateRange(sampleItem: bunData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //creatinineData
            let scoreCreatinine = getScoreForLabDataWithGivenDateRange(sampleItem: creatinineData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //bloodGlucoseData
            let scoreBloodGlucose = getScoreForLabDataWithGivenDateRange(sampleItem: bloodGlucoseData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //carbonDioxideData
            let scoreCarbonDioxide = getScoreForLabDataWithGivenDateRange(sampleItem: carbonDioxideData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //potassiumLevelData
            let scorePotassiumLevel = getScoreForLabDataWithGivenDateRange(sampleItem: potassiumLevelData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //calciumData
            let scoreCalcium = getScoreForLabDataWithGivenDateRange(sampleItem: calciumData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //chlorideData
            let scoreChloride = getScoreForLabDataWithGivenDateRange(sampleItem: chlorideData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //albuminData
            let scoreAlbumin = getScoreForLabDataWithGivenDateRange(sampleItem: albuminData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //anionGapData
            let scoreAnionGap = getScoreForLabDataWithGivenDateRange(sampleItem: anionGapData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //hemaglobinData
            let scoreHemaglobin = getScoreForLabDataWithGivenDateRange(sampleItem: hemaglobinData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //microalbuminData
            let scoreMicroalbumin = getScoreForLabDataWithGivenDateRange(sampleItem: microalbuminData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //eGFRData
            let scoreeGFR = getScoreForLabDataWithGivenDateRange(sampleItem: eGFRData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scoreBun + scoreCreatinine + scoreBloodGlucose + scoreCarbonDioxide  + scorePotassiumLevel
            let totalScore1 = scoreCalcium + scoreChloride + scoreAlbumin + scoreAnionGap + scoreHemaglobin + scoreMicroalbumin + scoreeGFR
            arrayDayWiseScoreTotal.append(totalScore + totalScore1)
        }
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[LabModel]{
        
        var arrLab:[LabModel] = []
        
        var filterArray:[LabCalculation] = []
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        
        //bunData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: bunData)
        if filterArray.count > 0{
            let bun = filterArray[0]
            arrLab.append(getLabModel(item: bun))
        }
        //creatinineData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: creatinineData)
        if filterArray.count > 0{
            let creatinine = filterArray[0]
            arrLab.append(getLabModel(item: creatinine))
        }
        //bloodGlucoseData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: bloodGlucoseData)
        if filterArray.count > 0{
            let bloodGlucose = filterArray[0]
            arrLab.append(getLabModel(item: bloodGlucose))
        }
        //carbonDioxideData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: carbonDioxideData)
        if filterArray.count > 0{
            let carbonDioxide = filterArray[0]
            arrLab.append(getLabModel(item: carbonDioxide))
        }
        //potassiumLevelData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: potassiumLevelData)
        if filterArray.count > 0{
            let potassiumLevel = filterArray[0]
            arrLab.append(getLabModel(item: potassiumLevel))
        }
        //calciumData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: calciumData)
        if filterArray.count > 0{
            let calcium = filterArray[0]
            arrLab.append(getLabModel(item: calcium))
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
        //anionGapData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: anionGapData)
        if filterArray.count > 0{
            let anionGap = filterArray[0]
            arrLab.append(getLabModel(item: anionGap))
        }
        //hemaglobinData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: hemaglobinData)
        if filterArray.count > 0{
            let hemaglobin = filterArray[0]
            arrLab.append(getLabModel(item: hemaglobin))
        }
        //microalbuminData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: microalbuminData)
        if filterArray.count > 0{
            let microalbumin = filterArray[0]
            arrLab.append(getLabModel(item: microalbumin))
        }
        //eGFRData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: eGFRData)
        if filterArray.count > 0{
            let eGFR = filterArray[0]
            arrLab.append(getLabModel(item: eGFR))
        }
        
        return arrLab
    }
    
    //Get list of data for specific Lab in detail screen..
    func getArrayDataForLabs(days:SegmentValueForGraph,title:String) -> [LabModel]{
        
        var arrLab:[LabModel] = []
        let labName = LabType(rawValue: title)
        var filterArray:[LabCalculation] = []
        
        switch labName {
        //BUN
        case .BUN:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: bunData)
        //creatinine
        case .creatinine:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: creatinineData)
        //bloodGlucose
        case .bloodGlucose:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: bloodGlucoseData)
        //carbonDioxide
        case .carbonDioxide:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: carbonDioxideData)
        //potassiumLevel
        case .potassiumLevel:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: potassiumLevelData)
        //calcium
        case .calcium:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: calciumData)
        //chloride
        case .chloride:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: chlorideData)
        //albumin
        case .albumin:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: albuminData)
        //anionGap
        case .anionGap:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: anionGapData)
        //hemoglobin
        case .hemoglobin:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: hemaglobinData)
        //microalbuminData
        case .microalbuminCreatinineRatio:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: microalbuminData)
        //eGFR
        case .eGFR:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: eGFRData)
        default:
            break
        }
        for item in filterArray{
            arrLab.append(saveLabsInArray(item: item))
        }
        return arrLab
    }
}


