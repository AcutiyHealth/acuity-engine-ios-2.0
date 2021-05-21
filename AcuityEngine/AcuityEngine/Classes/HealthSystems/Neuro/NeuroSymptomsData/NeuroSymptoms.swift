//
//  NeuroSymptoms.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class NeuroSymptoms:SymptomsProtocol {
    
    var moodChangesData:[NeuroSymptomsPainData] = []
    var dizzinessData:[NeuroSymptomsPainData] = []
    var bodyAndMuscleAche:[NeuroSymptomsPainData] = []
    var fatigueData:[NeuroSymptomsPainData] = []
    var faintingData:[NeuroSymptomsPainData] = []
    var nauseaData:[NeuroSymptomsPainData] = []
    var vomitingData:[NeuroSymptomsPainData] = []
    var memoryLapseData:[NeuroSymptomsPainData] = []
    var headacheData:[NeuroSymptomsPainData] = []
    var sleepChangesData:[NeuroSymptomsPainData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    private var arrSymptoms:[SymptomsModel] = []
    
    func totalSymptomDataScore() -> Double {
        return 0
    }
    
    func getMaxSymptomDataScore() -> Double {
        let moodChanges = NeuroSymptomsRelativeImportance.moodChanges.getConvertedValueFromPercentage()
        let dizziness = NeuroSymptomsRelativeImportance.dizziness.getConvertedValueFromPercentage()
        let bodyAndMuscleAche = NeuroSymptomsRelativeImportance.bodyAndMuscleAche.getConvertedValueFromPercentage()
        
        let fatigue = NeuroSymptomsRelativeImportance.fatigue.getConvertedValueFromPercentage()
        let fainting = NeuroSymptomsRelativeImportance.fainting.getConvertedValueFromPercentage()
        let nausea = NeuroSymptomsRelativeImportance.nausea.getConvertedValueFromPercentage()
        
        let vomiting = NeuroSymptomsRelativeImportance.vomiting.getConvertedValueFromPercentage()
        let memoryLapse = NeuroSymptomsRelativeImportance.memoryLapse.getConvertedValueFromPercentage()
        let headache = NeuroSymptomsRelativeImportance.headache.getConvertedValueFromPercentage()
        let sleepChanges = NeuroSymptomsRelativeImportance.sleepChanges.getConvertedValueFromPercentage()
        
        let totalLabScore1 = moodChanges + dizziness + bodyAndMuscleAche
        let totalLabScore2 = fatigue + fainting + nausea
        let totalLabScore3 =  vomiting + memoryLapse  + headache + sleepChanges
        
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
            
            //moodChanges
            let scoreMoodChanges = getScoreForSymptomsDataWithGivenDateRange(sampleItem: moodChangesData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //dizziness
            let scoreDizziness = getScoreForSymptomsDataWithGivenDateRange(sampleItem: dizzinessData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //bodyAndMuscleAche
            let scorebodyAndMuscleAche = getScoreForSymptomsDataWithGivenDateRange(sampleItem: bodyAndMuscleAche, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //fatigue
            let scoreFatigue = getScoreForSymptomsDataWithGivenDateRange(sampleItem: fatigueData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //fainting
            let scoreFainting = getScoreForSymptomsDataWithGivenDateRange(sampleItem: faintingData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //nausea
            let scoreNausea = getScoreForSymptomsDataWithGivenDateRange(sampleItem: nauseaData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //vomiting
            let scoreVomiting = getScoreForSymptomsDataWithGivenDateRange(sampleItem: vomitingData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //memoryLapse
            let scorememoryLapse = getScoreForSymptomsDataWithGivenDateRange(sampleItem: memoryLapseData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //headache
            let scoreHeadache = getScoreForSymptomsDataWithGivenDateRange(sampleItem: headacheData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //sleepChanges
            let scoresleepChanges = getScoreForSymptomsDataWithGivenDateRange(sampleItem: sleepChangesData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore1 = scoreMoodChanges + scoreDizziness + scorebodyAndMuscleAche
            let totalScore2 = scoreFainting + scoreFatigue + scoreNausea
            let totalScore3 =  scoreVomiting  + scorememoryLapse + scoreHeadache + scoresleepChanges
            
            arrayDayWiseScoreTotal.append(totalScore1 + totalScore2 + totalScore3)
        }
        
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[SymptomsModel]{
        
        arrSymptoms = []
        
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        //moodChangesData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: moodChangesData)
        
        //dizzinessData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: dizzinessData)
        
        //bodyAndMuscleAche
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: bodyAndMuscleAche)
        
        //fatigueData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: fatigueData)
        
        //faintingData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: faintingData)
        
        //nauseaData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: nauseaData)
        
        //vomitingData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: vomitingData)
        
        //memoryLapseData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: memoryLapseData)
        
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
        /*
         Mood Changes
         dizziness
         Body and Muscle Ache
         fatigue
         fainting
         nausea
         vomiting
         Memory lapse
         Headache
         Sleep changes
         */
        switch symptomsName {
        //moodChanges
        case .moodChanges:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: moodChangesData)
        //dizziness
        case .dizziness:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: dizzinessData)
        //body_Ache
        case .body_Ache:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: bodyAndMuscleAche)
        //fatigue
        case .fatigue:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: fatigueData)
        //fainting
        case .fainting:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: faintingData)
            
        //nausea
        case .nausea:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: nauseaData)
        //vomiting
        case .vomiting:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: vomitingData)
        //memoryLapse
        case .memoryLapse:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: memoryLapseData)
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
            let hotFlashesValue = item.getSymptomsValue()
            let symptom1 =  SymptomsModel(title: title, value: hotFlashesValue)
            symptom1.startTime = item.startTimeStamp
            symptom1.endTime = item.endTimeStamp
            arrSymptoms.append(symptom1)
            
        }
        return arrSymptoms
    }
}

