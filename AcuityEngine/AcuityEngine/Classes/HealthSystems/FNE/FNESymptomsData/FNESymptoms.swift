//
//  FNESymptoms.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class FNESymptoms:SymptomsProtocol {
    /*
     fatigue
     Body and Muscle Ache
     diarrhea
     nausea
     vomiting
     headache
     dizziness
     fainting
     hair loss
     */
    
    var fatigueData:[FNESymptomsPainData] = []
    var bodyAcheData:[FNESymptomsPainData] = []
    var diarrheaData:[FNESymptomsPainData] = []
    
    var nauseaData:[FNESymptomsPainData] = []
    var vomitingData:[FNESymptomsPainData] = []
    var headacheData:[FNESymptomsPainData] = []
    
    var dizzinessData:[FNESymptomsPainData] = []
    var faintingData:[FNESymptomsPainData] = []
    var hairLossData:[FNESymptomsPainData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    //For Dictionary Representation
    var arrSymptoms:[SymptomsModel] = []
    
    
    func totalSymptomDataScore() -> Double {
        return 0
    }
    
    func getMaxSymptomDataScore() -> Double {
        let fatigue = FNESymptomsRelativeImportance.fatigue.getConvertedValueFromPercentage()
        let bodyAche = FNESymptomsRelativeImportance.generalizedBodyAche.getConvertedValueFromPercentage()
        let diarrhea = FNESymptomsRelativeImportance.diarrhea.getConvertedValueFromPercentage()
        
        let nausea = FNESymptomsRelativeImportance.nausea.getConvertedValueFromPercentage()
        let vomiting = FNESymptomsRelativeImportance.vomiting.getConvertedValueFromPercentage()
        let headache = FNESymptomsRelativeImportance.headache.getConvertedValueFromPercentage()
        
        let dizziness = FNESymptomsRelativeImportance.dizziness.getConvertedValueFromPercentage()
        let fainting = FNESymptomsRelativeImportance.fainting.getConvertedValueFromPercentage()
        let hairLoss = FNESymptomsRelativeImportance.hairLoss.getConvertedValueFromPercentage()
        
        let totalLabScore1 = fatigue + bodyAche + diarrhea + nausea + vomiting + headache
        let totalLabScore2 =  dizziness + fainting  + hairLoss
        
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
            
            //fatigue
            let scoreFatigue = getScoreForSymptomsDataWithGivenDateRange(sampleItem: fatigueData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //bodyAche
            let scoreBodyAche = getScoreForSymptomsDataWithGivenDateRange(sampleItem: bodyAcheData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //diarrhea
            let scoreDiarrhea = getScoreForSymptomsDataWithGivenDateRange(sampleItem: diarrheaData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //nauseaData
            let scorenausea = getScoreForSymptomsDataWithGivenDateRange(sampleItem: nauseaData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //vomiting
            let scorevomiting = getScoreForSymptomsDataWithGivenDateRange(sampleItem: vomitingData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //headache
            let scoreheadache = getScoreForSymptomsDataWithGivenDateRange(sampleItem: headacheData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            
            //dizziness
            let scoredizziness = getScoreForSymptomsDataWithGivenDateRange(sampleItem: dizzinessData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //fainting
            let scorefainting = getScoreForSymptomsDataWithGivenDateRange(sampleItem: faintingData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //hairLoss
            let scorehairLoss = getScoreForSymptomsDataWithGivenDateRange(sampleItem: hairLossData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            
            let totalScore1 = scoreFatigue + scoreBodyAche + scoreDiarrhea
            let totalScore2 = scorenausea + scorevomiting + scoreheadache
            let totalScore3 = scorehairLoss + scorefainting + scoredizziness
            
            arrayDayWiseScoreTotal.append(totalScore1 + totalScore2 + totalScore3)
        }
        
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[SymptomsModel]{
     
             arrSymptoms = []
           
            let days = MyWellScore.sharedManager.daysToCalculateSystemScore
            //fatigue
            filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: fatigueData)
           
            //Body and Muscle Ache
            filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: bodyAcheData)
          
            //diarrhea
            filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: diarrheaData)
           
            //nausea
            filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: nauseaData)
           
            //vomiting
            filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: vomitingData)
          
            //headache
            filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: headacheData)
          
            //dizziness
            filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: dizzinessData)
           
            //fainting
            filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: faintingData)
           
            //hair loss
            filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: hairLossData)
           
          
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
        //fatigue
        case .fatigue:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: fatigueData)
        //body_Ache
        case .body_Ache:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: bodyAcheData)
        //diarrhea
        case .diarrhea:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: diarrheaData)
            
        //nausea
        case .nausea:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: nauseaData)
        //vomiting
        case .vomiting:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: vomitingData)
        //headache
        case .headache:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: headacheData)
            
        //dizziness
        case .dizziness:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: dizzinessData)
        //fainting
        case .fainting:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: faintingData)
        //hairLoss
        case .hairLoss:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: hairLossData)
            
            
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

