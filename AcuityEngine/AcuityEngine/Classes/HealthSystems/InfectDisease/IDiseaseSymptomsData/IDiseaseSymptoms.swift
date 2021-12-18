//
//  IDiseaseSymptoms.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class IDiseaseSymptoms:SymptomsProtocol {
    /*
     fever
     diarrhea
     fatigue
     cough
     nausea
     vomiting
     chills
     bladder incontinence
     headache
     Abdominal cramps
     Shortness of breath
     dizziness
     */
    var feverData:[IDiseaseSymptomsPainData] = []
    var diarrheaData:[IDiseaseSymptomsPainData] = []
    var fatigueData:[IDiseaseSymptomsPainData] = []
    var coughData:[IDiseaseSymptomsPainData] = []
    var nauseaData:[IDiseaseSymptomsPainData] = []
    var vomitingData:[IDiseaseSymptomsPainData] = []
    var chillsData:[IDiseaseSymptomsPainData] = []
    var bladderIncontinenceData:[IDiseaseSymptomsPainData] = []
    var headacheData:[IDiseaseSymptomsPainData] = []
    var abdominalCrampsData:[IDiseaseSymptomsPainData] = []
    var shortOfBreathData:[IDiseaseSymptomsPainData] = []
    var dizzinessData:[IDiseaseSymptomsPainData] = []
    
    //For Dictionary Representation
    var arrSymptoms:[SymptomsModel] = []
    
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalSymptomDataScore() -> Double {
        return 0
    }
    
    func getMaxSymptomDataScore() -> Double {
        let fever = IDiseaseSymptomsRelativeImportance.fever.getConvertedValueFromPercentage()
        let diarrhea = IDiseaseSymptomsRelativeImportance.diarrhea.getConvertedValueFromPercentage()
        let fatigue = IDiseaseSymptomsRelativeImportance.fatigue.getConvertedValueFromPercentage()
        let cough = IDiseaseSymptomsRelativeImportance.cough.getConvertedValueFromPercentage()
        let nausea = IDiseaseSymptomsRelativeImportance.nausea.getConvertedValueFromPercentage()
        let vomiting = IDiseaseSymptomsRelativeImportance.vomiting.getConvertedValueFromPercentage()
        let chills = IDiseaseSymptomsRelativeImportance.chills.getConvertedValueFromPercentage()
        let bladderIncontinence = IDiseaseSymptomsRelativeImportance.bladderIncontinence.getConvertedValueFromPercentage()
        let headache = IDiseaseSymptomsRelativeImportance.headache.getConvertedValueFromPercentage()
        let abdominalCramps = IDiseaseSymptomsRelativeImportance.abdominalCramps.getConvertedValueFromPercentage()
        let shortnessofBreath = IDiseaseSymptomsRelativeImportance.shortnessofBreath.getConvertedValueFromPercentage()
        let dizziness = IDiseaseSymptomsRelativeImportance.dizziness.getConvertedValueFromPercentage()
        
        let totalLabScore1 = fever + diarrhea + fatigue + cough + nausea + vomiting
        let totalLabScore2 =  chills + bladderIncontinence  + headache + abdominalCramps + shortnessofBreath + dizziness
        
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
            
            //fever
            let scoreFever = getScoreForSymptomsDataWithGivenDateRange(sampleItem: feverData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //diarrhea
            let scoreDiarrhea = getScoreForSymptomsDataWithGivenDateRange(sampleItem: diarrheaData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //fatigue
            let scoreFatigue = getScoreForSymptomsDataWithGivenDateRange(sampleItem: fatigueData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //cough
            let scoreCough = getScoreForSymptomsDataWithGivenDateRange(sampleItem: coughData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //nauseaData
            let scorenausea = getScoreForSymptomsDataWithGivenDateRange(sampleItem: nauseaData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //vomiting
            let scorevomiting = getScoreForSymptomsDataWithGivenDateRange(sampleItem: vomitingData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //chills
            let scorechills = getScoreForSymptomsDataWithGivenDateRange(sampleItem: chillsData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //bladderIncontinence
            let scorebladderIncontinence = getScoreForSymptomsDataWithGivenDateRange(sampleItem: bladderIncontinenceData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //headache
            let scoreheadache = getScoreForSymptomsDataWithGivenDateRange(sampleItem: headacheData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //abdominalCramps
            let scoreabdominalCramps = getScoreForSymptomsDataWithGivenDateRange(sampleItem: abdominalCrampsData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //shortOfBreath
            let scoreshortOfBreath = getScoreForSymptomsDataWithGivenDateRange(sampleItem: shortOfBreathData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //dizziness
            let scoredizziness = getScoreForSymptomsDataWithGivenDateRange(sampleItem: dizzinessData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            
            let totalScore = scoreFever + scoreDiarrhea + scoreFatigue + scoreCough + scorenausea + scorevomiting + scorechills + scorebladderIncontinence + scoreheadache + scoreabdominalCramps + scoreshortOfBreath + scoredizziness
            arrayDayWiseScoreTotal.append(totalScore)
        }
        
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[SymptomsModel]{
        
        //var filterArray:[SymptomCalculation] = []
        arrSymptoms = []
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        //fever
        self.filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: feverData)
       
        //diarrhea
         filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: diarrheaData)
     
        //fatigue
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: fatigueData)
        
        //cough
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: coughData)
        
        //nausea
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: nauseaData)
       
        //vomiting
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: vomitingData)
        
        //chills
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: chillsData)
       
        //bladderIncontinence
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: bladderIncontinenceData)
       
        //headache
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: headacheData)
       
        //abdominalCramps
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: abdominalCrampsData)
       
        //shortOfBreath
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: shortOfBreathData)
        
        //dizziness
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: dizzinessData)
     
        
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
        /*
         fever
         diarrhea
         fatigue
         cough
         nausea
         vomiting
         chills
         bladder incontinence
         headache
         Abdominal cramps
         Shortness of breath
         dizziness
         */
        switch symptomsName {
        
        case .fever:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: feverData)
            
        case .diarrhea:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: diarrheaData)
            
        case .fatigue:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: fatigueData)
            
        case .cough:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: coughData)
            
        case .nausea:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: nauseaData)
            
        case .vomiting:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: vomitingData)
            
        case .chills:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: chillsData)
            
        case .bladder_Incontinence:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: bladderIncontinenceData)
            
        case .headache:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: headacheData)
            
        case .abdominal_Cramps:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: abdominalCrampsData)
            
        case .shortnessOfBreath:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: shortOfBreathData)
            
        case .dizziness:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: dizzinessData)
            
        default:
            break
        }
        for item in filterArray{
            let chestPainValue = item.getSymptomsValue()
            let symptom1 =  SymptomsModel(title: title, value: chestPainValue)
            symptom1.startTime = item.startTimeStamp
            symptom1.endTime = item.endTimeStamp
            arrSymptoms.append(symptom1)
            
        }
        return arrSymptoms
    }
}

