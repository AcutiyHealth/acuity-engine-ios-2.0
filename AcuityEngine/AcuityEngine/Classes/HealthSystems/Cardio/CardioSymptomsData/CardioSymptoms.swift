//
//  CardioSymptoms.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class CardioSymptoms:SymptomsProtocol {
    
    var chestPainData:[CardioSymptomsPainData] = []
    var skippedHeartBeatData:[CardioSymptomsPainData] = []
    var dizzinessData:[CardioSymptomsPainData] = []
    var fatigueData:[CardioSymptomsPainData] = []
    var rapidHeartBeatData:[CardioSymptomsPainData] = []
    var faintingData:[CardioSymptomsPainData] = []
    var nauseaData:[CardioSymptomsPainData] = []
    var vomitingData:[CardioSymptomsPainData] = []
    var memoryLapseData:[CardioSymptomsPainData] = []
    var shortBreathData:[CardioSymptomsPainData] = []
    var headacheData:[CardioSymptomsPainData] = []
    var heartBurnData:[CardioSymptomsPainData] = []
    var sleepChangesData:[CardioSymptomsPainData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    var arrSymptoms:[SymptomsModel] = []
    
    func totalSymptomDataScore() -> Double {
        let chestPain = (Double(chestPainData.average(\.score) ).isNaN ? 0 : Double(chestPainData.average(\.score) ) )
        let skippedHeartBeat = (Double(skippedHeartBeatData.average(\.score)) .isNaN ? 0 : Double(skippedHeartBeatData.average(\.score)))
        let dizziness = (Double(dizzinessData.average(\.score)).isNaN ? 0 : Double(dizzinessData.average(\.score)))
        let fatigue = (Double(fatigueData.average(\.score)).isNaN ? 0 :  Double(fatigueData.average(\.score)))
        
        let rapidHeartBeat = (Double(rapidHeartBeatData.average(\.score) ).isNaN ? 0 : Double(rapidHeartBeatData.average(\.score) ) )
        let fainting = (Double(faintingData.average(\.score)) .isNaN ? 0 : Double(faintingData.average(\.score)))
        let nausea = (Double(nauseaData.average(\.score)).isNaN ? 0 : Double(nauseaData.average(\.score)))
        let vomiting = (Double(vomitingData.average(\.score)).isNaN ? 0 :  Double(vomitingData.average(\.score)))
        
        let memoryLapse = (Double(memoryLapseData.average(\.score) ).isNaN ? 0 : Double(memoryLapseData.average(\.score) ) )
        let shortBreath = (Double(shortBreathData.average(\.score)) .isNaN ? 0 : Double(shortBreathData.average(\.score)))
        let headache = (Double(headacheData.average(\.score)).isNaN ? 0 : Double(headacheData.average(\.score)))
        let heartBurn = (Double(heartBurnData.average(\.score)).isNaN ? 0 :  Double(heartBurnData.average(\.score)))
        let sleepChanges = (Double(sleepChangesData.average(\.score)).isNaN ? 0 :  Double(sleepChangesData.average(\.score)))
        
        let totalLabScore1 = chestPain + skippedHeartBeat + dizziness + fatigue
        let totalLabScore2 =  rapidHeartBeat + fainting + nausea + vomiting
        let totalLabScore3 =  memoryLapse + shortBreath + headache + heartBurn + sleepChanges
        
        return Double(totalLabScore1  + totalLabScore2 + totalLabScore3);
        
    }
    
    func getMaxSymptomDataScore() -> Double {
        let chestPain = CardioSymptomsRelativeImportance.chestPain.getConvertedValueFromPercentage()
        let skippedHeartBeat = CardioSymptomsRelativeImportance.skippedHeartBeat.getConvertedValueFromPercentage()
        let dizziness = CardioSymptomsRelativeImportance.dizziness.getConvertedValueFromPercentage()
        let fatigue = CardioSymptomsRelativeImportance.fatigue.getConvertedValueFromPercentage()
        
        let rapidHeartBeat = CardioSymptomsRelativeImportance.rapidHeartbeat.getConvertedValueFromPercentage()
        let fainting = CardioSymptomsRelativeImportance.fainting.getConvertedValueFromPercentage()
        let nausea = CardioSymptomsRelativeImportance.nausea.getConvertedValueFromPercentage()
        let vomiting = CardioSymptomsRelativeImportance.vomiting.getConvertedValueFromPercentage()
        
        let memoryLapse = CardioSymptomsRelativeImportance.memoryLapse.getConvertedValueFromPercentage()
        let shortBreath = CardioSymptomsRelativeImportance.shortnessOfBreath.getConvertedValueFromPercentage()
        let headache = CardioSymptomsRelativeImportance.headache.getConvertedValueFromPercentage()
        let heartBurn = CardioSymptomsRelativeImportance.heartburn.getConvertedValueFromPercentage()
        let sleepChanges = CardioSymptomsRelativeImportance.sleepChanges.getConvertedValueFromPercentage()
        
        let totalLabScore1 = chestPain + skippedHeartBeat + dizziness + fatigue
        let totalLabScore2 =  rapidHeartBeat + fainting + nausea + vomiting
        let totalLabScore3 =  memoryLapse + shortBreath + headache + heartBurn + sleepChanges
        
        return Double(totalLabScore1  + totalLabScore2 + totalLabScore3);
    }
    
    func totalSymptomsScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        //print(totalAmount) // 4500.0
        arrayDayWiseScoreTotal = []
        /*var cardioSymptomCalculation:[Metrix] = []
         cardioSymptomCalculation.append(contentsOf: chestPainData)
         cardioSymptomCalculation.append(contentsOf: skippedHeartBeatData)
         cardioSymptomCalculation.append(contentsOf: dizzinessData)
         cardioSymptomCalculation.append(contentsOf: fatigueData)
         cardioSymptomCalculation.append(contentsOf: rapidHeartBeatData)
         cardioSymptomCalculation.append(contentsOf: faintingData)
         cardioSymptomCalculation.append(contentsOf: nauseaData)
         cardioSymptomCalculation.append(contentsOf: vomitingData)
         cardioSymptomCalculation.append(contentsOf: memoryLapseData)
         cardioSymptomCalculation.append(contentsOf: shortBreathData)
         cardioSymptomCalculation.append(contentsOf: headacheData)
         cardioSymptomCalculation.append(contentsOf: heartBurnData)
         cardioSymptomCalculation.append(contentsOf: sleepChangesData)
         arrayDayWiseScoreTotal = daywiseFilterMetrixsData(days: days, array: cardioSymptomCalculation, metriXType: MetricsType.Sympotms)
         
         cardioSymptomCalculation = []*/
        
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
            //chestPainData
            let scoreChestPainData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: chestPainData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //skippedHeartBeatData
            let scoreSkippedHeartBeatData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: skippedHeartBeatData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //dizzinessData
            let scoredizzinessData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: dizzinessData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //fatigueData
            let scoreFatigueData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: fatigueData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //rapidHeartBeatData
            let scoreRapidHeartBeatData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: rapidHeartBeatData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //faintingData
            let scoreFaintingData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: faintingData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //nauseaData
            let scoreNauseaData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: nauseaData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //vomitingData
            let scoreVomitingData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: vomitingData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //memoryLapseData
            let scoreMemoryLapseData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: memoryLapseData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //shortBreathData
            let scoreShortBreathData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: shortBreathData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //headacheData
            let scoreHeadacheData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: headacheData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //heartBurnData
            let scoreHeartBurnData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: heartBurnData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //sleepChangesData
            let scoreSleepChangesData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: sleepChangesData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scoreChestPainData + scoreSkippedHeartBeatData + scoredizzinessData + scoreFatigueData + scoreRapidHeartBeatData + scoreFaintingData + scoreNauseaData + scoreVomitingData + scoreMemoryLapseData + scoreShortBreathData + scoreHeadacheData + scoreHeartBurnData + scoreSleepChangesData
            arrayDayWiseScoreTotal.append(totalScore)
        }
        
        
        
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[SymptomsModel]{
        
        arrSymptoms = []
        var filterArray:[SymptomCalculation] = []
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        //chestPainData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: chestPainData)
        //skippedHeartBeatData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: skippedHeartBeatData)
        //dizzinessData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: dizzinessData)
        //fatigueData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: fatigueData)
        //rapidHeartBeatData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: rapidHeartBeatData)
        //faintingData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: faintingData)
        //nauseaData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: nauseaData)
        //vomiting
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: vomitingData)
        //memoryLapseData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: memoryLapseData)
        //shortBreathData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: shortBreathData)
        //headacheData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: headacheData)
        
        //heartBurnData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: heartBurnData)
        
        //sleepChangesData
        filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: sleepChangesData)
        if filterArray.count > 0{
            let symptom = filterArray[0]
            arrSymptoms.append(SymptomsModel(title: symptom.title, value: SymptomsValue(rawValue: symptom.getSymptomSleepChangeValue().rawValue)!))
        }
        
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
        case .chestPain:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: chestPainData)
            
        case .skippedHeartBeat:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: skippedHeartBeatData)
            
        case .dizziness:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: dizzinessData)
            
        case .fatigue:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: fatigueData)
            
        case .rapidHeartbeat:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: rapidHeartBeatData)
            
        case .fainting:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: faintingData)
            
        case .nausea:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: nauseaData)
            
        case .vomiting:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: vomitingData)
            
        case .memoryLapse:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: memoryLapseData)
            
        case .shortnessOfBreath:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: shortBreathData)
            
        case .headache:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: headacheData)
            
        case .heartburn:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: heartBurnData)
            
        case .sleepChanges:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: sleepChangesData)
            
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

