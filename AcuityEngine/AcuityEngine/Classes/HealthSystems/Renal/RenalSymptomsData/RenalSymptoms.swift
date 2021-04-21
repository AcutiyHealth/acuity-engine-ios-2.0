//
//  RenalSymptoms.swift
//  HealthKitDemo
//
//  Created by  Bhoomi Jagani  on 05/02/21.
//

import UIKit

class RenalSymptoms:SymptomsProtocol {
   /*
     Rapid or fluttering heartbeat
     lower back pain
     dizziness
     fatigue
     fainting
     nausea
     vomiting
     */
    var rapidHeartBeatData:[RenalSymptomsPainData] = []
    var lowerBackPainData:[RenalSymptomsPainData] = []
    var dizzinessData:[RenalSymptomsPainData] = []
    var faintingData:[RenalSymptomsPainData] = []
    var fatigueData:[RenalSymptomsPainData] = []
    var nauseaData:[RenalSymptomsPainData] = []
    var vomitingData:[RenalSymptomsPainData] = []
   
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalSymptomDataScore() -> Double {

        let rapidHeartBeat = (Double(rapidHeartBeatData.average(\.score) ).isNaN ? 0 : Double(rapidHeartBeatData.average(\.score) ) )
        let fainting = (Double(faintingData.average(\.score)) .isNaN ? 0 : Double(faintingData.average(\.score)))
        let lowerBackPain = (Double(lowerBackPainData.average(\.score)).isNaN ? 0 : Double(lowerBackPainData.average(\.score)))
        let fatigue = (Double(fatigueData.average(\.score)) .isNaN ? 0 : Double(fatigueData.average(\.score)))
        let dizziness = (Double(dizzinessData.average(\.score) ).isNaN ? 0 : Double(dizzinessData.average(\.score) ) )
        let nausea = (Double(nauseaData.average(\.score)) .isNaN ? 0 : Double(nauseaData.average(\.score)))
        let vomiting = (Double(vomitingData.average(\.score)).isNaN ? 0 : Double(vomitingData.average(\.score)))
       
        let totalLabScore1 = rapidHeartBeat + fainting + lowerBackPain
        let totalLabScore2 =  fatigue + dizziness + vomiting + nausea
       
        return Double(totalLabScore1  + totalLabScore2)
    }
    
    func getMaxSymptomDataScore() -> Double {
        let rapidHeartBeat = RenalSymptomsRelativeImportance.rapidHeartbeat.getConvertedValueFromPercentage()
        let lowerBackPain = RenalSymptomsRelativeImportance.lowerBackPain.getConvertedValueFromPercentage()
        let fainting = RenalSymptomsRelativeImportance.fainting.getConvertedValueFromPercentage()
        let fatigue = RenalSymptomsRelativeImportance.fatigue.getConvertedValueFromPercentage()
        let dizziness = RenalSymptomsRelativeImportance.dizziness.getConvertedValueFromPercentage()
        let nausea = RenalSymptomsRelativeImportance.nausea.getConvertedValueFromPercentage()
        let vomiting = RenalSymptomsRelativeImportance.vomiting.getConvertedValueFromPercentage()
    
        let totalLabScore1 = lowerBackPain + rapidHeartBeat + fainting + fatigue
        let totalLabScore2 =  dizziness + nausea  + vomiting
        
        return Double(totalLabScore1  + totalLabScore2);
    }
    
    func totalSymptomsScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        //print(totalAmount) // 4500.0
        arrayDayWiseScoreTotal = []
        /*var cardioSymptomCalculation:[Metrix] = []
        cardioSymptomCalculation.append(contentsOf: rapidHeartBeatData)
        cardioSymptomCalculation.append(contentsOf: faintingData)
        cardioSymptomCalculation.append(contentsOf: lowerBackPainData)
        cardioSymptomCalculation.append(contentsOf: fatigueData)
        cardioSymptomCalculation.append(contentsOf: dizzinessData)
        cardioSymptomCalculation.append(contentsOf: nauseaData)
        cardioSymptomCalculation.append(contentsOf: vomitingData)

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
           //rapidHeartBeatData
            let scoreRapidHeartBeatData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: rapidHeartBeatData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //lowerBackPainData
            let scorelowerBackPainData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: lowerBackPainData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //dizzinessData
            let scoredizzinessData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: dizzinessData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //fatigueData
            let scorefatigueData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: fatigueData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //faintingData
            let scorefaintingData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: faintingData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //nauseaData
            let scorenauseaData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: nauseaData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //vomitingData
            let scorevomitingData = getScoreForSymptomsDataWithGivenDateRange(sampleItem: vomitingData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scoreRapidHeartBeatData + scorelowerBackPainData + scoredizzinessData + scorefaintingData + scorefatigueData + scorenauseaData + scorevomitingData
            arrayDayWiseScoreTotal.append(totalScore)
    }
       
        return arrayDayWiseScoreTotal
    }
    
    func dictionaryRepresentation()->[SymptomsModel]{
        
        var arrSymptoms:[SymptomsModel] = []
        
        if rapidHeartBeatData.count > 0{
            let symptom = rapidHeartBeatData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if faintingData.count > 0{
            let symptom = faintingData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if lowerBackPainData.count > 0{
            let symptom = lowerBackPainData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if fatigueData.count > 0{
            let symptom = fatigueData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        if dizzinessData.count > 0{
            let symptom = dizzinessData[0]
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
       
        return arrSymptoms
    }
    func getSymptomsModel(symptom:RenalSymptomsPainData)->SymptomsModel{
        return SymptomsModel(title: symptom.title, value: symptom.getSymptomsValue())
    }
    
    func getArrayDataForSymptoms(days:SegmentValueForGraph,title:String)->[SymptomsModel]{
        var arrSymptoms:[SymptomsModel] = []
        let symptomsName = SymptomsName(rawValue: title)
        var filterArray:[SymptomCalculation] = []
        switch symptomsName {
        
        case .rapidHeartbeat:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: rapidHeartBeatData)
       
        case .lowerBackPain:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: lowerBackPainData)
            
        case .fainting:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: faintingData)
            
        case .fatigue:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: fatigueData)
            
        case .dizziness:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: dizzinessData)
            
        case .nausea:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: nauseaData)
            
        case .vomiting:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: vomitingData)
            
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

