//
//  MuscSymptoms.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class MuscSymptoms:SymptomsProtocol {
    /*
     Chest pain (6/6
     Body and Muscle Ache
     fatigue
     lower back pain
     Mood Changes
     Sleep changes
     */
    var chestPainData:[MuscSymptomsPainData] = []
    var bodyAcheData:[MuscSymptomsPainData] = []
    var fatigueData:[MuscSymptomsPainData] = []
    var lowerBackPainData:[MuscSymptomsPainData] = []
    var moodChangeData:[MuscSymptomsPainData] = []
    var sleepChangesData:[MuscSymptomsPainData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    private var arrSymptoms:[SymptomsModel] = []
    
    func totalSymptomDataScore() -> Double {
        return 0
    }
    
    func getMaxSymptomDataScore() -> Double {
        
        let chestPain = MuscSymptomsRelativeImportance.chestPain.getConvertedValueFromPercentage()
        let bodyMuscleAche = MuscSymptomsRelativeImportance.bodyMuscleAche.getConvertedValueFromPercentage()
        let fatigue = MuscSymptomsRelativeImportance.fatigue.getConvertedValueFromPercentage()
        
        let lowerBackPain = MuscSymptomsRelativeImportance.lowerBackPain.getConvertedValueFromPercentage()
        let moodChanges = MuscSymptomsRelativeImportance.moodChanges.getConvertedValueFromPercentage()
        
        let sleepChanges = MuscSymptomsRelativeImportance.sleepChanges.getConvertedValueFromPercentage()
        
        let totalLabScore1 = chestPain + bodyMuscleAche + fatigue
        let totalLabScore2 = lowerBackPain + moodChanges + sleepChanges
        
        
        return Double(totalLabScore1  + totalLabScore2);
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
            
            //chestPain
            let scorechestPain = getScoreForSymptomsDataWithGivenDateRange(sampleItem: chestPainData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //bodyAche
            let scorebodyAche = getScoreForSymptomsDataWithGivenDateRange(sampleItem: bodyAcheData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //fatigue
            let scoreFatigue = getScoreForSymptomsDataWithGivenDateRange(sampleItem: fatigueData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //lowerBackPain
            let scorelowerBackPain = getScoreForSymptomsDataWithGivenDateRange(sampleItem: lowerBackPainData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //moodChange
            let scoremoodChange = getScoreForSymptomsDataWithGivenDateRange(sampleItem: moodChangeData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //sleepChanges
            let scoresleepChanges = getScoreForSymptomsDataWithGivenDateRange(sampleItem: sleepChangesData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore1 = scorechestPain + scorebodyAche + scoreFatigue
            let totalScore2 = scorelowerBackPain + scoremoodChange + scoresleepChanges
            
            arrayDayWiseScoreTotal.append(totalScore1 + totalScore2)
        }
        
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[SymptomsModel]{
        
        arrSymptoms = []
        
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        
        //chestPainData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: chestPainData)
        
        //bodyAcheData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: bodyAcheData)
        
        //fatigueData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: fatigueData)
        
        //lowerBackPainData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: lowerBackPainData)
        
        //moodChangeData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: moodChangeData)
        
        //sleepChangesData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: sleepChangesData)
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
    
    func getArrayDataForSymptoms(days:SegmentValueForGraph,title:String)->[SymptomsModel]{
        var arrSymptoms:[SymptomsModel] = []
        let symptomsName = SymptomsName(rawValue: title)
        var filterArray:[SymptomCalculation] = []
        /*
         Chest pain (6/6
         Body and Muscle Ache
         fatigue
         lower back pain
         Mood Changes
         Sleep changes
         */
        switch symptomsName {
        //chestPain
        case .chestPain:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: chestPainData)
        //body_Ache
        case .body_Ache:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: bodyAcheData)
            
        //fatigue
        case .fatigue:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: fatigueData)
        //lowerBackPain
        case .lowerBackPain:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: lowerBackPainData)
            
        //moodChanges
        case .moodChanges:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: moodChangeData)
        //sleepChanges
        case .sleepChanges:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: sleepChangesData)
            
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

