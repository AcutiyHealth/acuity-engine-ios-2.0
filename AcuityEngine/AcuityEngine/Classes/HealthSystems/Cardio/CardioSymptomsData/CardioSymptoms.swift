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
        var cardioSymptomCalculation:[Metrix] = []
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
        
        cardioSymptomCalculation = []
        
        
        return arrayDayWiseScoreTotal
    }
    
    func dictionaryRepresentation()->[SymptomsModel]{
        
        var arrSymptoms:[SymptomsModel] = []
        
        if chestPainData.count > 0{
            let symptom = chestPainData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if skippedHeartBeatData.count > 0{
            let symptom = skippedHeartBeatData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if dizzinessData.count > 0{
            let symptom = dizzinessData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if fatigueData.count > 0{
            let symptom = fatigueData[0]
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
        if nauseaData.count > 0{
            let symptom = nauseaData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if vomitingData.count > 0{
            let symptom = vomitingData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if memoryLapseData.count > 0{
            let symptom = memoryLapseData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if shortBreathData.count > 0{
            let symptom = shortBreathData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if headacheData.count > 0{
            let symptom = headacheData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if heartBurnData.count > 0{
            let symptom = heartBurnData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if sleepChangesData.count > 0{
            let symptom = sleepChangesData[0]
            arrSymptoms.append(SymptomsModel(title: symptom.title, value: SymptomsValue(rawValue: symptom.getSymptomSleepChangeValue().rawValue)!))
        }
      
        return arrSymptoms
    }
    func getSymptomsModel(symptom:CardioSymptomsPainData)->SymptomsModel{
        return SymptomsModel(title: symptom.title, value: symptom.getSymptomsValue())
    }
    
    func getArrayDataForSymptoms(days:SegmentValueForGraph,title:String)->[SymptomsModel]{
        var arrSymptoms:[SymptomsModel] = []
        let symptomsName = SymptomsName(rawValue: title)
        var filterArray:[SymptomCalculation] = []
        switch symptomsName {
        case .chestPain:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: chestPainData)
            
        case .skippedHeartBeat:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: skippedHeartBeatData)
            
        case .dizziness:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: dizzinessData)
            
        case .fatigue:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: fatigueData)
            
        case .rapidHeartbeat:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: rapidHeartBeatData)
            
        case .fainting:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: faintingData)
            
        case .nausea:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: nauseaData)
            
        case .vomiting:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: vomitingData)
            
        case .memoryLapse:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: memoryLapseData)
            
        case .shortnessOfBreath:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: shortBreathData)
            
        case .headache:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: headacheData)
            
        case .heartburn:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: heartBurnData)
            
        case .sleepChanges:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: sleepChangesData)
            
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

func filterArrayWithSelectedSegmentInGraph(days:SegmentValueForGraph,array:[SymptomCalculation])->[SymptomCalculation]{
    let now = MyWellScore.sharedManager.todaysDate
    
    let timeIntervalByLastMonth:Double = getTimeIntervalBySelectedSegmentOfDays(days: days)
    let timeIntervalByNow:Double = now.timeIntervalSince1970
    var filteredArray:[SymptomCalculation] = []
    
    filteredArray = array.filter { item in
        //let timeInterval = item.endTimeStamp
      filterConditionForSymptoms(sampleItem: item, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
    }
    
    return filteredArray
}
