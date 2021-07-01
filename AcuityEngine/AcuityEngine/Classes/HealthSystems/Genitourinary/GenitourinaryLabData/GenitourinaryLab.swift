//
//  GenitourinaryLab.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class GenitourinaryLab {
    /*WBC's
     Neutrophil %
     Urine Nitrites
     Urine ketone
     Urine Blood */
    var WBCData:[GenitourinaryLabData] = []
    var neutrophilData:[GenitourinaryLabData] = []
    var urineNitritesData:[GenitourinaryLabData] = []
    var urineBloodData:[GenitourinaryLabData]  = []
    var urineKetoneData:[GenitourinaryLabData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalLabDataScore() -> Double {
        
        return 0;
    }
    
    func getMaxLabDataScore() -> Double {
        
        let WBC = GenitourinaryLabRelativeImportance.WBC.getConvertedValueFromPercentage()
        let neutrophil = GenitourinaryLabRelativeImportance.neutrophil.getConvertedValueFromPercentage()
        let urineBlood = GenitourinaryLabRelativeImportance.urineBlood.getConvertedValueFromPercentage()
        
        let urineKetone = GenitourinaryLabRelativeImportance.urineKetone.getConvertedValueFromPercentage()
        let urineNitrites = GenitourinaryLabRelativeImportance.urineNitrites.getConvertedValueFromPercentage()
        
        let totalLabScore1 = WBC + neutrophil + urineBlood
        let totalLabScore2 = urineKetone + urineNitrites
        
        return Double(totalLabScore1 + totalLabScore2);
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
            
            //WBCData
            let scoreWBC = getScoreForLabDataWithGivenDateRange(sampleItem: WBCData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //neutrophilData
            let scoreNeutrophil = getScoreForLabDataWithGivenDateRange(sampleItem: neutrophilData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //urineBloodData
            let scoreUrineBlood = getScoreForLabDataWithGivenDateRange(sampleItem: urineBloodData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //urineKetoneData
            let scoreUrineKetone = getScoreForLabDataWithGivenDateRange(sampleItem: urineKetoneData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //urineNitritesData
            let scoreUrineNitrites = getScoreForLabDataWithGivenDateRange(sampleItem: urineNitritesData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scoreWBC + scoreNeutrophil + scoreUrineBlood + scoreUrineKetone  + scoreUrineNitrites
            
            arrayDayWiseScoreTotal.append(totalScore)
        }
        return arrayDayWiseScoreTotal
    }
    
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[LabModel]{
        
        var arrLab:[LabModel] = []
        
        var filterArray:[LabCalculation] = []
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        
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
        //urineNitritesData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: urineNitritesData)
        if filterArray.count > 0{
            let urineNitrites = filterArray[0]
            arrLab.append(getLabModel(item: urineNitrites))
        }
        //urineKetoneData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: urineKetoneData)
        if filterArray.count > 0{
            let urineKetone = filterArray[0]
            arrLab.append(getLabModel(item: urineKetone))
        }
        //urineBloodData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: urineBloodData)
        if filterArray.count > 0{
            let urineBlood = filterArray[0]
            arrLab.append(getLabModel(item: urineBlood))
        }
        
        return arrLab
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
        //urineNitrites
        case .urineNitrites:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: urineNitritesData)
        //urineKetone
        case .urineKetone:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: urineKetoneData)
        //urineBlood
        case .urineBlood:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: urineBloodData)
            
        default:
            break
        }
        for item in filterArray{
            arrLab.append(saveLabsInArray(item: item))
        }
        return arrLab
    }
}

