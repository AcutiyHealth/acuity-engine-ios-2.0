//
//  CardioLab.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class IDiseaseLab {
    /*WBC's
     Neutrophil %
     blood glucose
     Urine nitrites
     Urine Blood
     Anion gap */
    var WBCData:[IDiseaseLabData] = []
    var neutrophilData:[IDiseaseLabData]  = []
    var bloodGlucoseData:[IDiseaseLabData] = []
    var urineNitrites:[IDiseaseLabData] = []
    var urineBlood:[IDiseaseLabData] = []
    var anionGapData:[IDiseaseLabData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalLabDataScore() -> Double {
        
        return 0;
    }
    
    func getMaxLabDataScore() -> Double {
        
        let WBC = IDiseaseLabRelativeImportance.WBC.getConvertedValueFromPercentage()
        let neutrophil = IDiseaseLabRelativeImportance.neutrophil.getConvertedValueFromPercentage()
        let bloodGlucose = IDiseaseLabRelativeImportance.bloodGlucose.getConvertedValueFromPercentage()
        let urineNitrites = IDiseaseLabRelativeImportance.urineNitrites.getConvertedValueFromPercentage()
        let urineBlood = IDiseaseLabRelativeImportance.urineBlood.getConvertedValueFromPercentage()
        let anionGap = IDiseaseLabRelativeImportance.anionGap.getConvertedValueFromPercentage()
        
        let totalLabScore1 = WBC + neutrophil + bloodGlucose + urineNitrites + urineBlood + anionGap
        
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
            
            //WBCData
            let scoreWBC = getScoreForLabDataWithGivenDateRange(sampleItem: WBCData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //neutrophilData
            let scoreNeutrophil = getScoreForLabDataWithGivenDateRange(sampleItem: neutrophilData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //bloodGlucoseData
            let scoreBloodGlucose = getScoreForLabDataWithGivenDateRange(sampleItem: bloodGlucoseData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //urineNitrites
            let scoreUrineNitrites = getScoreForLabDataWithGivenDateRange(sampleItem: urineNitrites, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //urineBlood
            let scoreneUrineBlood = getScoreForLabDataWithGivenDateRange(sampleItem: urineBlood, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //anionGapData
            let scoreAnionGap = getScoreForLabDataWithGivenDateRange(sampleItem: anionGapData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scoreWBC + scoreNeutrophil + scoreBloodGlucose + scoreUrineNitrites  + scoreneUrineBlood + scoreAnionGap
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
        //bloodGlucoseData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: bloodGlucoseData)
        if filterArray.count > 0{
            let bloodGlucose = filterArray[0]
            arrLab.append(getLabModel(item: bloodGlucose))
        }
        //urineNitrites
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: urineNitrites)
        if filterArray.count > 0{
            let urineNitrites = filterArray[0]
            arrLab.append(getLabModel(item: urineNitrites))
        }
        //urineBlood
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: urineBlood)
        if filterArray.count > 0{
            let urineBlood = filterArray[0]
            arrLab.append(getLabModel(item: urineBlood))
        }
        //anionGapData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: anionGapData)
        if filterArray.count > 0{
            let anionGap = filterArray[0]
            arrLab.append(getLabModel(item: anionGap))
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
        //bloodGlucose
        case .bloodGlucose:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: bloodGlucoseData)
        //urineNitrites
        case .urineNitrites:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: urineNitrites)
        //urineBlood
        case .urineBlood:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: urineBlood)
        //anionGap
        case .anionGap:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: anionGapData)
            
        default:
            break
        }
        for item in filterArray{
            arrLab.append(saveLabsInArray(item: item))
        }
        return arrLab
    }
}

