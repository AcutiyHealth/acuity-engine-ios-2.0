//
//  HeentSymptoms.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class HeentSymptoms:SymptomsProtocol {
    /*
     fever
     chills
     dizziness
     fatigue
     Loss of Smell
     Runny Nose
     Sore Throat
     Sleep changes
     */
    var feverData:[HeentSymptomsPainData] = []
    var chillsData:[HeentSymptomsPainData] = []
    var dizzinessData:[HeentSymptomsPainData] = []
    var fatigueData:[HeentSymptomsPainData] = []
    var lossOfSmellData:[HeentSymptomsPainData] = []
    var runnyNoseData:[HeentSymptomsPainData] = []
    var soreThroatData:[HeentSymptomsPainData] = []
    var sleepChangesData:[HeentSymptomsPainData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    private var arrSymptoms:[SymptomsModel] = []
    
    func totalSymptomDataScore() -> Double {
        return 0
    }
    
    func getMaxSymptomDataScore() -> Double {
        
        let fever = HeentSymptomsRelativeImportance.fever.getConvertedValueFromPercentage()
        let chills = HeentSymptomsRelativeImportance.chills.getConvertedValueFromPercentage()
        let dizziness = HeentSymptomsRelativeImportance.dizziness.getConvertedValueFromPercentage()
        
        let fatigue = HeentSymptomsRelativeImportance.fatigue.getConvertedValueFromPercentage()
        let lossOfSmell = HeentSymptomsRelativeImportance.lossOfSmell.getConvertedValueFromPercentage()
        let runnyNose = HeentSymptomsRelativeImportance.runnyNose.getConvertedValueFromPercentage()
        let soreThroat = HeentSymptomsRelativeImportance.soreThroat.getConvertedValueFromPercentage()
        let sleepChanges = HeentSymptomsRelativeImportance.sleepChanges.getConvertedValueFromPercentage()
        
        let totalLabScore1 = fever + chills + dizziness + fatigue
        let totalLabScore2 = lossOfSmell + runnyNose + soreThroat + sleepChanges
        
        
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
            
            //feverData
            let scoreFever = getScoreForSymptomsDataWithGivenDateRange(sampleItem: feverData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //chills
            let scorechills = getScoreForSymptomsDataWithGivenDateRange(sampleItem: chillsData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //dizziness
            let scoredizziness = getScoreForSymptomsDataWithGivenDateRange(sampleItem: dizzinessData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //fatigue
            let scorefatigue = getScoreForSymptomsDataWithGivenDateRange(sampleItem: fatigueData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //lossOfSmell
            let scorelossOfSmell = getScoreForSymptomsDataWithGivenDateRange(sampleItem: lossOfSmellData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //runnyNose
            let scorerunnyNose = getScoreForSymptomsDataWithGivenDateRange(sampleItem: runnyNoseData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //soreThroat
            let scoresoreThroat = getScoreForSymptomsDataWithGivenDateRange(sampleItem: soreThroatData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //sleepChanges
            let scoresleepChanges = getScoreForSymptomsDataWithGivenDateRange(sampleItem: sleepChangesData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore1 = scoreFever + scorechills + scoredizziness + scorefatigue
            let totalScore2 = scorelossOfSmell + scorerunnyNose + scoresoreThroat + scoresleepChanges
            
            arrayDayWiseScoreTotal.append(totalScore1 + totalScore2)
        }
        
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[SymptomsModel]{
        
        arrSymptoms = []
        
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        
        //fever
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: feverData)
        
        //chills
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: chillsData)
        
        //dizziness
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: dizzinessData)
        
        //fatigue
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: fatigueData)
        
        //lossOfSmell
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: lossOfSmellData)
        
        //runnyNose
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: runnyNoseData)
        
        //soreThroat
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: soreThroatData)
        
        //sleepChanges
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
        //fever
        case .fever:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: feverData)
        //chills
        case .chills:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: chillsData)
            
        //dizziness
        case .dizziness:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: dizzinessData)
        //fatigue
        case .fatigue:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: fatigueData)
            
        //lossOfSmell
        case .lossOfSmell:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: lossOfSmellData)
        //runnyNose
        case .runnyNose:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: runnyNoseData)
            
        //soreThroat
        case .soreThroat:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: soreThroatData)
        //sleepChanges
        case .sleepChanges:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: sleepChangesData)
        default:
            break
        }
        for item in filterArray{
            let symptomsValue = item.getSymptomsValue()
            let symptom1 =  SymptomsModel(title: title, value: symptomsValue)
            symptom1.startTime = item.startTimeStamp
            symptom1.endTime = item.endTimeStamp
            arrSymptoms.append(symptom1)
            
        }
        return arrSymptoms
    }
}

