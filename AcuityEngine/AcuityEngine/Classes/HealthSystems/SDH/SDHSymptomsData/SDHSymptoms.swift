//
//  SDHSymptoms.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class SDHSymptoms:SymptomsProtocol {
    /*
     Chest pain (5/6
     dizziness
     fatigue
     Rapid or fluttering heartbeat
     Memory lapse
     Shortness of breath
     Headache
     Sleep changes
     */
    var chestPainData:[SDHSymptomsPainData] = []
    var dizzinessData:[SDHSymptomsPainData] = []
    var fatigueData:[SDHSymptomsPainData] = []
    var rapidHeartBeatData:[SDHSymptomsPainData] = []
    var memoryLapseData:[SDHSymptomsPainData] = []
    var shortnessOfBreathData:[SDHSymptomsPainData] = []
    var headacheData:[SDHSymptomsPainData] = []
    var sleepChangesData:[SDHSymptomsPainData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    private var arrSymptoms:[SymptomsModel] = []
    
    func totalSymptomDataScore() -> Double {
        return 0
    }
    
    func getMaxSymptomDataScore() -> Double {
        
        let chestPain = SDHSymptomsRelativeImportance.chestPain.getConvertedValueFromPercentage()
        let dizziness = SDHSymptomsRelativeImportance.dizziness.getConvertedValueFromPercentage()
        let fatigue = SDHSymptomsRelativeImportance.fatigue.getConvertedValueFromPercentage()
        
        let rapidHeartbeat = SDHSymptomsRelativeImportance.rapidHeartbeat.getConvertedValueFromPercentage()
        let memoryLapse = SDHSymptomsRelativeImportance.memoryLapse.getConvertedValueFromPercentage()
        let shortnessOfBreath = SDHSymptomsRelativeImportance.shortnessOfBreath.getConvertedValueFromPercentage()
        
        let headache = SDHSymptomsRelativeImportance.headache.getConvertedValueFromPercentage()
        let sleepChanges = SDHSymptomsRelativeImportance.sleepChanges.getConvertedValueFromPercentage()
        
        let totalLabScore1 = chestPain + dizziness + fatigue
        let totalLabScore2 = rapidHeartbeat + memoryLapse + shortnessOfBreath
        let totalLabScore3 = headache + sleepChanges
        
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
            
            //chestPain
            let scorechestPain = getScoreForSymptomsDataWithGivenDateRange(sampleItem: chestPainData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //dizziness
            let scoreDizziness = getScoreForSymptomsDataWithGivenDateRange(sampleItem: dizzinessData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //fatigue
            let scoreFatigue = getScoreForSymptomsDataWithGivenDateRange(sampleItem: fatigueData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //rapidHeartBeat
            let scoreRapidHeartBeat = getScoreForSymptomsDataWithGivenDateRange(sampleItem: rapidHeartBeatData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //memoryLapse
            let scoreMemoryLapse = getScoreForSymptomsDataWithGivenDateRange(sampleItem: memoryLapseData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //shortnessOfBreathData
            let scoreShortnessOfBreath = getScoreForSymptomsDataWithGivenDateRange(sampleItem: shortnessOfBreathData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //headache
            let scoreHeadache = getScoreForSymptomsDataWithGivenDateRange(sampleItem: headacheData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //sleepChanges
            let scoresleepChanges = getScoreForSymptomsDataWithGivenDateRange(sampleItem: sleepChangesData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore1 = scorechestPain + scoreDizziness + scoreFatigue
            let totalScore2 = scoreRapidHeartBeat + scoreMemoryLapse + scoreShortnessOfBreath
            let totalScore3 =  scoreHeadache  + scoresleepChanges
            
            arrayDayWiseScoreTotal.append(totalScore1 + totalScore2 + totalScore3)
        }
        
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[SymptomsModel]{
        
        arrSymptoms = []
        
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        
        //chestPainData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: chestPainData)
        
        //dizzinessData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: dizzinessData)
        
        //fatigueData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: fatigueData)
        
        //rapidHeartBeatData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: rapidHeartBeatData)
        
        //memoryLapseData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: memoryLapseData)
        
        //shortnessOfBreathData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: shortnessOfBreathData)
        
        //headacheData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: headacheData)
        
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
      
        switch symptomsName {
        //chestPain
        case .chestPain:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: chestPainData)
        //dizziness
        case .dizziness:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: dizzinessData)
            
        //fatigue
        case .fatigue:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: fatigueData)
        //rapidHeartbeat
        case .rapidHeartbeat:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: rapidHeartBeatData)
            
        //memoryLapse
        case .memoryLapse:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: memoryLapseData)
        //shortnessOfBreath
        case .shortnessOfBreath:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: shortnessOfBreathData)
            
        //headache
        case .headache:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: headacheData)
        //sleepChanges
        case .sleepChanges:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: sleepChangesData)
            
        default:
            break
        }
        for item in filterArray{
            let value = item.getSymptomsValue()
            let symptom1 =  SymptomsModel(title: title, value: value)
            symptom1.startTime = item.startTimeStamp
            symptom1.endTime = item.endTimeStamp
            arrSymptoms.append(symptom1)
            
        }
        return arrSymptoms
    }
}

