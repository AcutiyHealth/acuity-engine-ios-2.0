//
//  GastrointestinalSymptoms.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class GastrointestinalSymptoms:SymptomsProtocol {
    /*
     Abdominal cramps
     Chest pain (4/6
     cough
     diarrhea
     constipation
     fatigue
     bloating
     nausea
     vomiting
     Heartburn
     */
    var abdominalCrampsData:[GastrointestinalSymptomsPainData] = []
    var chestPainData:[GastrointestinalSymptomsPainData] = []
    var coughData:[GastrointestinalSymptomsPainData] = []
    
    var diarrheaData:[GastrointestinalSymptomsPainData] = []
    var constipationData:[GastrointestinalSymptomsPainData] = []
    var fatigueData:[GastrointestinalSymptomsPainData] = []
    
    var bloatingData:[GastrointestinalSymptomsPainData] = []
    var nauseaData:[GastrointestinalSymptomsPainData] = []
    var vomitingData:[GastrointestinalSymptomsPainData] = []
    var heartburnData:[GastrointestinalSymptomsPainData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    var arrSymptoms:[SymptomsModel] = []
    
    func totalSymptomDataScore() -> Double {
        return 0
    }
    
    func getMaxSymptomDataScore() -> Double {
        let abdominalCramps = GastrointestinalSymptomsRelativeImportance.abdominalCramps.getConvertedValueFromPercentage()
        let chestPain = GastrointestinalSymptomsRelativeImportance.chestPain.getConvertedValueFromPercentage()
        let cough = GastrointestinalSymptomsRelativeImportance.cough.getConvertedValueFromPercentage()
        
        let diarrhea = GastrointestinalSymptomsRelativeImportance.diarrhea.getConvertedValueFromPercentage()
        let constipation = GastrointestinalSymptomsRelativeImportance.constipation.getConvertedValueFromPercentage()
        let fatigue = GastrointestinalSymptomsRelativeImportance.fatigue.getConvertedValueFromPercentage()
        
        let bloating = GastrointestinalSymptomsRelativeImportance.bloating.getConvertedValueFromPercentage()
        let nausea = GastrointestinalSymptomsRelativeImportance.nausea.getConvertedValueFromPercentage()
        let vomiting = GastrointestinalSymptomsRelativeImportance.vomiting.getConvertedValueFromPercentage()
        let heartburn = GastrointestinalSymptomsRelativeImportance.heartburn.getConvertedValueFromPercentage()
        
        let totalLabScore1 = abdominalCramps + chestPain + cough
        let totalLabScore2 =  diarrhea + constipation  + fatigue
        let totalLabScore3 =  bloating + nausea  + vomiting + heartburn
        
        return Double(totalLabScore1  + totalLabScore2 + totalLabScore3);
    }
    
    func totalSymptomsScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        //print(totalAmount) // 4500.0
        arrayDayWiseScoreTotal = []
        
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
            
            //abdominalCrampsData
            let scoreAbdominalCramps = getScoreForSymptomsDataWithGivenDateRange(sampleItem: abdominalCrampsData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //chestPain
            let scoreChestPain = getScoreForSymptomsDataWithGivenDateRange(sampleItem: chestPainData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //cough
            let scoreCough = getScoreForSymptomsDataWithGivenDateRange(sampleItem: coughData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //diarrhea
            let scoreDiarrhea = getScoreForSymptomsDataWithGivenDateRange(sampleItem: diarrheaData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //constipation
            let scoreConstipation = getScoreForSymptomsDataWithGivenDateRange(sampleItem: constipationData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //fatigue
            let scoreFatigue = getScoreForSymptomsDataWithGivenDateRange(sampleItem: fatigueData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //bloating
            let scoreBloating = getScoreForSymptomsDataWithGivenDateRange(sampleItem: bloatingData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //nausea
            let scoreNausea = getScoreForSymptomsDataWithGivenDateRange(sampleItem: nauseaData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //vomiting
            let scoreVomiting = getScoreForSymptomsDataWithGivenDateRange(sampleItem: vomitingData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //heartburn
            let scoreHeartburn = getScoreForSymptomsDataWithGivenDateRange(sampleItem: heartburnData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore1 = scoreAbdominalCramps + scoreChestPain + scoreCough
            let totalScore2 = scoreDiarrhea + scoreConstipation + scoreFatigue
            let totalScore3 = scoreBloating + scoreNausea + scoreVomiting + scoreHeartburn
            
            arrayDayWiseScoreTotal.append(totalScore1 + totalScore2 + totalScore3)
        }
        
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[SymptomsModel]{
        
         arrSymptoms = []
       
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        //Abdominal cramps
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: abdominalCrampsData)
       
        //Chest pain
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: chestPainData)
       
        //cough
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: coughData)
       
        //diarrhea
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: diarrheaData)
       
        //constipation
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: constipationData)
       
        //fatigue
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: fatigueData)
       
        //bloating
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: bloatingData)
       
        //nausea
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: nauseaData)
       
        //vomiting
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: vomitingData)
       
        //Heartburn
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: heartburnData)
       
        return arrSymptoms
        
    }
  
    func filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days:SegmentValueForGraph,array:[SymptomCalculation]){
        var filteredArray:[SymptomCalculation] = []
        filteredArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: array)
        saveFilterDataInArraySymptoms(filteredArray: filteredArray)
        //return filteredArray
    }
    
    func saveFilterDataInArraySymptoms(filteredArray:[SymptomCalculation]){
        if filteredArray.count > 0{
            let symptom = filteredArray[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
    }
    //MARK:- For DetailValue  Screen...
    func getArrayDataForSymptoms(days:SegmentValueForGraph,title:String)->[SymptomsModel]{
        var arrSymptoms:[SymptomsModel] = []
        let symptomsName = SymptomsName(rawValue: title)
        var filterArray:[SymptomCalculation] = []
        
        switch symptomsName {
        //abdominal_Cramps
        case .abdominal_Cramps:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: abdominalCrampsData)
        //chestPain
        case .chestPain:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: chestPainData)
        //cough
        case .cough:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: coughData)
            
        //diarrhea
        case .diarrhea:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: diarrheaData)
        //constipation
        case .constipation:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: constipationData)
        //fatigue
        case .fatigue:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: fatigueData)
            
        //bloating
        case .bloating:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: bloatingData)
        //nausea
        case .nausea:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: nauseaData)
        //vomiting
        case .vomiting:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: vomitingData)
        //heartburn
        case .heartburn:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: heartburnData)
            
        default:
            break
        }
        for item in filterArray{
            let hotFlashesValue = item.getSymptomsValue()
            let symptom1 =  SymptomsModel(title: title, value: hotFlashesValue)
            symptom1.startTime = item.startTimeStamp
            symptom1.endTime = item.endTimeStamp
            arrSymptoms.append(symptom1)
            
        }
        return arrSymptoms
    }
}

