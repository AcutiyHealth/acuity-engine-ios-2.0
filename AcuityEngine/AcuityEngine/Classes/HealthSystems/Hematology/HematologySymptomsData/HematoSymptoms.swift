//
//  HematoSymptoms.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class HematoSymptoms:SymptomsProtocol {
    /*
     dizziness
     fatigue
     Rapid or fluttering heartbeat
     fainting
     chest pain (3
     Shortness of breath
     */
    var dizzinessData:[HematoSymptomsPainData] = []
    var fatigueData:[HematoSymptomsPainData] = []
    var rapidHeartBeatData:[HematoSymptomsPainData] = []
    
    var faintingData:[HematoSymptomsPainData] = []
    var chestPainData:[HematoSymptomsPainData] = []
    var shortnessOfBreathData:[HematoSymptomsPainData] = []
    
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalSymptomDataScore() -> Double {
        return 0
    }
    
    func getMaxSymptomDataScore() -> Double {
        let dizziness = HematoSymptomsRelativeImportance.dizziness.getConvertedValueFromPercentage()
        let fatigue = HematoSymptomsRelativeImportance.fatigue.getConvertedValueFromPercentage()
        let rapidPoundingOrFlutteringHeartbeat = HematoSymptomsRelativeImportance.rapidPoundingOrFlutteringHeartbeat.getConvertedValueFromPercentage()
        
        let fainting = HematoSymptomsRelativeImportance.fainting.getConvertedValueFromPercentage()
        let chestPain = HematoSymptomsRelativeImportance.chestPain.getConvertedValueFromPercentage()
        let shortnessOfBreath = HematoSymptomsRelativeImportance.shortnessOfBreath.getConvertedValueFromPercentage()
        
        let totalLabScore1 = fatigue + dizziness + rapidPoundingOrFlutteringHeartbeat
        let totalLabScore2 =  chestPain + fainting  + shortnessOfBreath
        
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
            
            //dizziness
            let scoredizziness = getScoreForSymptomsDataWithGivenDateRange(sampleItem: dizzinessData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //fatigue
            let scoreFatigue = getScoreForSymptomsDataWithGivenDateRange(sampleItem: fatigueData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //rapidHeartBeat
            let scoreRapidHeartBeat = getScoreForSymptomsDataWithGivenDateRange(sampleItem: rapidHeartBeatData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //fainting
            let scorefainting = getScoreForSymptomsDataWithGivenDateRange(sampleItem: faintingData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //chestPain
            let scoreChestPain = getScoreForSymptomsDataWithGivenDateRange(sampleItem: chestPainData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //shortnessOfBreathData
            let scoreShortnessOfBreath = getScoreForSymptomsDataWithGivenDateRange(sampleItem: shortnessOfBreathData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            
            
            let totalScore1 = scoredizziness + scoreFatigue + scoreRapidHeartBeat
            let totalScore2 = scorefainting + scoreChestPain + scoreShortnessOfBreath
            
            arrayDayWiseScoreTotal.append(totalScore1 + totalScore2)
        }
        
        return arrayDayWiseScoreTotal
    }
    
    func dictionaryRepresentation()->[SymptomsModel]{
        
        var arrSymptoms:[SymptomsModel] = []
        
        //dizziness
        if dizzinessData.count > 0{
            let symptom = dizzinessData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        //fatigue
        if fatigueData.count > 0{
            let symptom = fatigueData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        //rapidHeartBeat
        if rapidHeartBeatData.count > 0{
            let symptom = rapidHeartBeatData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        //fainting
        if faintingData.count > 0{
            let symptom = faintingData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        //chestPain
        if chestPainData.count > 0{
            let symptom = chestPainData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        
        //shortnessOfBreath
        if shortnessOfBreathData.count > 0{
            let symptom = shortnessOfBreathData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        
        
        return arrSymptoms
    }
    func getSymptomsModel(symptom:HematoSymptomsPainData)->SymptomsModel{
        return SymptomsModel(title: symptom.title, value: symptom.getSymptomsValue())
    }
    
    func getArrayDataForSymptoms(days:SegmentValueForGraph,title:String)->[SymptomsModel]{
        var arrSymptoms:[SymptomsModel] = []
        let symptomsName = SymptomsName(rawValue: title)
        var filterArray:[SymptomCalculation] = []
        
        switch symptomsName {
        
        //dizziness
        case .dizziness:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: dizzinessData)
        //fatigue
        case .fatigue:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: fatigueData)
            
        //rapidHeartbeat
        case .rapidHeartbeat:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: rapidHeartBeatData)
        //fainting
        case .fainting:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: faintingData)
            
        //chestPain
        case .chestPain:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: chestPainData)
            
        //shortnessOfBreath
        case .shortnessOfBreath:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: shortnessOfBreathData)
            
            
            
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

