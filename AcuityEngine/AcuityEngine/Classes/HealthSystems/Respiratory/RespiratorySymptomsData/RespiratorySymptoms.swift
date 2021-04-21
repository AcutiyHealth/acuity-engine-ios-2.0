//
//  RespiratorySymptoms.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class RespiratorySymptoms:SymptomsProtocol {
    /*Chest pain(2/5)
     Rapid or fluttering heartbeat
     cough
     fainting
     Shortness of breath
     Runny Nose
     Sore Throat
     fever
     chills*/
    var chestPainData:[RespiratorySymptomsPainData] = []
    var rapidHeartBeatData:[RespiratorySymptomsPainData] = []
    var coughingData:[RespiratorySymptomsPainData] = []
    var faintingData:[RespiratorySymptomsPainData] = []
    var shortBreathData:[RespiratorySymptomsPainData] = []
    var runnyNoseData:[RespiratorySymptomsPainData] = []
    var soreThroatData:[RespiratorySymptomsPainData] = []
    var feverData:[RespiratorySymptomsPainData] = []
    var chillsData:[RespiratorySymptomsPainData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalSymptomDataScore() -> Double {
        let chestPain = (Double(chestPainData.average(\.score) ).isNaN ? 0 : Double(chestPainData.average(\.score) ) )
        let rapidHeartBeat = (Double(rapidHeartBeatData.average(\.score) ).isNaN ? 0 : Double(rapidHeartBeatData.average(\.score) ) )
        let fainting = (Double(faintingData.average(\.score)) .isNaN ? 0 : Double(faintingData.average(\.score)))
        let coughing = (Double(coughingData.average(\.score)).isNaN ? 0 : Double(coughingData.average(\.score)))
        let shortBreath = (Double(shortBreathData.average(\.score)) .isNaN ? 0 : Double(shortBreathData.average(\.score)))
        let runnyNose = (Double(runnyNoseData.average(\.score) ).isNaN ? 0 : Double(runnyNoseData.average(\.score) ) )
        let soreThroat = (Double(soreThroatData.average(\.score)) .isNaN ? 0 : Double(soreThroatData.average(\.score)))
        let fever = (Double(feverData.average(\.score)).isNaN ? 0 : Double(feverData.average(\.score)))
        let chills = (Double(chillsData.average(\.score)) .isNaN ? 0 : Double(chillsData.average(\.score)))
        
        
        let totalLabScore1 = chestPain + rapidHeartBeat + fainting + coughing
        let totalLabScore2 =  shortBreath + runnyNose + soreThroat + fever + chills
        
        return Double(totalLabScore1  + totalLabScore2)
    }
    
    func getMaxSymptomDataScore() -> Double {
        let chestPain = RespiratorySymptomsRelativeImportance.chestPain.getConvertedValueFromPercentage()
        let rapidHeartBeat = RespiratorySymptomsRelativeImportance.rapidHeartbeat.getConvertedValueFromPercentage()
        let fainting = RespiratorySymptomsRelativeImportance.fainting.getConvertedValueFromPercentage()
        let coughing = RespiratorySymptomsRelativeImportance.cough.getConvertedValueFromPercentage()
        let shortnessOfBreath = RespiratorySymptomsRelativeImportance.shortnessOfBreath.getConvertedValueFromPercentage()
        let runnyNose = RespiratorySymptomsRelativeImportance.runnyNose.getConvertedValueFromPercentage()
        let soreThroat = RespiratorySymptomsRelativeImportance.soreThroat.getConvertedValueFromPercentage()
        let fever = RespiratorySymptomsRelativeImportance.fever.getConvertedValueFromPercentage()
        let chills = RespiratorySymptomsRelativeImportance.chills.getConvertedValueFromPercentage()
        
        let totalLabScore1 = chestPain + rapidHeartBeat + fainting + coughing
        let totalLabScore2 =  shortnessOfBreath + runnyNose + soreThroat + fever + chills
        
        return Double(totalLabScore1  + totalLabScore2);
    }
    
    func totalSymptomsScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        //print(totalAmount) // 4500.0
        arrayDayWiseScoreTotal = []
        /*var cardioSymptomCalculation:[Metrix] = []
         cardioSymptomCalculation.append(contentsOf: chestPainData)
         cardioSymptomCalculation.append(contentsOf: rapidHeartBeatData)
         cardioSymptomCalculation.append(contentsOf: faintingData)
         cardioSymptomCalculation.append(contentsOf: coughingData)
         cardioSymptomCalculation.append(contentsOf: shortBreathData)
         cardioSymptomCalculation.append(contentsOf: runnyNoseData)
         cardioSymptomCalculation.append(contentsOf: soreThroatData)
         cardioSymptomCalculation.append(contentsOf: feverData)
         cardioSymptomCalculation.append(contentsOf: chillsData)
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
            //rapidHeartBeatData
            let scoreRapidHeartBeatData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: rapidHeartBeatData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //coughingData
            let scoreCoughingData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: coughingData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //faintingData
            let scorefaintingData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: faintingData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //shortBreathData
            let scoreShortBreathData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: shortBreathData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //runnyNoseData
            let scoreRunnyNoseData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: runnyNoseData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //soreThroatData
            let scoreSoreThroatData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: soreThroatData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //feverData
            let scoreFeverData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: feverData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //chillsData
            let scoreChillsData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: chillsData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scoreChestPainData + scoreRapidHeartBeatData + scoreCoughingData + scorefaintingData + scoreShortBreathData + scoreRunnyNoseData + scoreSoreThroatData + scoreFeverData + scoreChillsData
            arrayDayWiseScoreTotal.append(totalScore)
        }
        
        
        return arrayDayWiseScoreTotal
    }
    
    func dictionaryRepresentation()->[SymptomsModel]{
        
        var arrSymptoms:[SymptomsModel] = []
        
        if chestPainData.count > 0{
            let symptom = chestPainData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if rapidHeartBeatData.count > 0{
            let symptom = rapidHeartBeatData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if faintingData.count > 0{
            let symptom = faintingData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if coughingData.count > 0{
            let symptom = coughingData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if shortBreathData.count > 0{
            let symptom = shortBreathData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if runnyNoseData.count > 0{
            let symptom = runnyNoseData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if soreThroatData.count > 0{
            let symptom = soreThroatData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if feverData.count > 0{
            let symptom = feverData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if chillsData.count > 0{
            let symptom = chillsData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        
        return arrSymptoms
    }
    func getSymptomsModel(symptom:RespiratorySymptomsPainData)->SymptomsModel{
        return SymptomsModel(title: symptom.title, value: symptom.getSymptomsValue())
    }
    
    func getArrayDataForSymptoms(days:SegmentValueForGraph,title:String)->[SymptomsModel]{
        var arrSymptoms:[SymptomsModel] = []
        let symptomsName = SymptomsName(rawValue: title)
        var filterArray:[SymptomCalculation] = []
        switch symptomsName {
        case .chestPain:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: chestPainData)
            
        case .rapidHeartbeat:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: rapidHeartBeatData)
            
        case .cough:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: coughingData)
            
        case .fainting:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: faintingData)
            
        case .shortnessOfBreath:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: shortBreathData)
            
        case .runnyNose:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: runnyNoseData)
            
        case .soreThroat:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: soreThroatData)
            
        case .fever:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: feverData)
            
        case .chills:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: chillsData)
            
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

