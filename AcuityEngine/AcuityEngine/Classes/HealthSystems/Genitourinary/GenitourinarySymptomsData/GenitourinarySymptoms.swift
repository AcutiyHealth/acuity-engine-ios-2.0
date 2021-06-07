//
//  GenitourinarySymptoms.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class GenitourinarySymptoms:SymptomsProtocol {
    /*
     fever
     bladder incontinence
     Abdominal cramps
     dizziness
     fatigue
     nausea
     vomiting
     chills
     bloating
     */
    var feverData:[GenitourinarySymptomsPainData] = []
    var bladderIncontinenceData:[GenitourinarySymptomsPainData] = []
    var abdominalCrampsData:[GenitourinarySymptomsPainData] = []
    var dizzinessData:[GenitourinarySymptomsPainData] = []
    var fatigueData:[GenitourinarySymptomsPainData] = []
    
    var nauseaData:[GenitourinarySymptomsPainData] = []
    var vomitingData:[GenitourinarySymptomsPainData] = []
    var chillsData:[GenitourinarySymptomsPainData] = []
    var bloatingData:[GenitourinarySymptomsPainData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    private var arrSymptoms:[SymptomsModel] = []
    
    func totalSymptomDataScore() -> Double {
        return 0
    }
    
    func getMaxSymptomDataScore() -> Double {
        let fever = GenitourinarySymptomsRelativeImportance.fever.getConvertedValueFromPercentage()
        let bladderIncontinence = GenitourinarySymptomsRelativeImportance.bladderIncontinence.getConvertedValueFromPercentage()
        let abdominalCramps = GenitourinarySymptomsRelativeImportance.abdominalCramps.getConvertedValueFromPercentage()
        
        let dizziness = GenitourinarySymptomsRelativeImportance.dizziness.getConvertedValueFromPercentage()
        let fatigue = GenitourinarySymptomsRelativeImportance.fatigue.getConvertedValueFromPercentage()
        let nausea = GenitourinarySymptomsRelativeImportance.nausea.getConvertedValueFromPercentage()
        
        let vomiting = GenitourinarySymptomsRelativeImportance.vomiting.getConvertedValueFromPercentage()
        let chills = GenitourinarySymptomsRelativeImportance.chills.getConvertedValueFromPercentage()
        let bloating = GenitourinarySymptomsRelativeImportance.bloating.getConvertedValueFromPercentage()
        
        let totalLabScore1 = fever + bladderIncontinence + abdominalCramps
        let totalLabScore2 =  dizziness + nausea  + fatigue
        let totalLabScore3 =  vomiting + chills  + bloating
        
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
            
            //fever
            let scoreFever = getScoreForSymptomsDataWithGivenDateRange(sampleItem: feverData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //bladderIncontinence
            let scoreBladderIncontinenceData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: bladderIncontinenceData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //abdominalCramps
            let scoreAbdominalCramps = getScoreForSymptomsDataWithGivenDateRange(sampleItem: abdominalCrampsData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //dizziness
            let scoreDizziness = getScoreForSymptomsDataWithGivenDateRange(sampleItem: dizzinessData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //fatigue
            let scoreFatigue = getScoreForSymptomsDataWithGivenDateRange(sampleItem: fatigueData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //nausea
            let scoreNausea = getScoreForSymptomsDataWithGivenDateRange(sampleItem: nauseaData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //chills
            let scoreChills = getScoreForSymptomsDataWithGivenDateRange(sampleItem: chillsData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //vomiting
            let scoreVomiting = getScoreForSymptomsDataWithGivenDateRange(sampleItem: vomitingData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //bloating
            let scoreBloating = getScoreForSymptomsDataWithGivenDateRange(sampleItem: bloatingData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            
            let totalScore1 = scoreFever + scoreBladderIncontinenceData + scoreAbdominalCramps
            let totalScore2 = scoreDizziness + scoreFatigue + scoreNausea
            let totalScore3 = scoreChills + scoreVomiting  + scoreBloating
            
            arrayDayWiseScoreTotal.append(totalScore1 + totalScore2 + totalScore3)
        }
        
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[SymptomsModel]{
        
        arrSymptoms = []
        
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        //feverData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: feverData)
        
        //bladderIncontinenceData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: bladderIncontinenceData)
        
        //abdominalCrampsData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: abdominalCrampsData)
        
        //dizzinessData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: dizzinessData)
        
        //fatigueData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: fatigueData)
        
        //nauseaData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: nauseaData)
        
        //vomitingData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: vomitingData)
        
        //chillsData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: chillsData)
        
        //bloatingData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: bloatingData)
        
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
        //fever
        case .fever:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: feverData)
        //bladder_Incontinence
        case .bladder_Incontinence:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: bladderIncontinenceData)
        //abdominal_Cramps
        case .abdominal_Cramps:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: abdominalCrampsData)
            
        //dizziness
        case .dizziness:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: dizzinessData)
            
        //fatigue
        case .fatigue:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: fatigueData)
        //nausea
        case .nausea:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: nauseaData)
        //vomiting
        case .vomiting:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: vomitingData)
        //chills
        case .chills:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: chillsData)
        //bloating
        case .bloating:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: bloatingData)
            
            
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

