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
    
    func dictionaryRepresentation()->[SymptomsModel]{
        
        var arrSymptoms:[SymptomsModel] = []
        
        //fever
        if feverData.count > 0{
            let symptom = feverData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        //diarrhea
        if diarrheaData.count > 0{
            let symptom = diarrheaData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        //fatigue
        if fatigueData.count > 0{
            let symptom = fatigueData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        //cough
        if coughData.count > 0{
            let symptom = coughData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        //nausea
        if nauseaData.count > 0{
            let symptom = nauseaData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        //vomiting
        if vomitingData.count > 0{
            let symptom = vomitingData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        //chills
        if chillsData.count > 0{
            let symptom = chillsData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        //bladderIncontinence
        if bladderIncontinenceData.count > 0{
            let symptom = bladderIncontinenceData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        //headache
        if headacheData.count > 0{
            let symptom = headacheData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        //Abdominal cramps
        if abdominalCrampsData.count > 0{
            let symptom = abdominalCrampsData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        
        //Shortness of breath
        if shortOfBreathData.count > 0{
            let symptom = shortOfBreathData[0]
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        //dizziness
        if dizzinessData.count > 0{
            let symptom = dizzinessData[0]
            print(symptom.getSymptomSleepChangeValue().rawValue)
            arrSymptoms.append(getSymptomsModel(symptom: symptom))
        }
        
        
        return arrSymptoms
    }
    func getSymptomsModel(symptom:IDiseaseSymptomsPainData)->SymptomsModel{
        return SymptomsModel(title: symptom.title, value: symptom.getSymptomsValue())
    }
    
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
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: feverData)
            
        case .diarrhea:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: diarrheaData)
            
        case .fatigue:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: fatigueData)
            
        case .cough:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: coughData)
       
        case .nausea:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: nauseaData)
            
        case .vomiting:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: vomitingData)
            
        case .chills:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: chillsData)
       
        case .bladder_Incontinence:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: bladderIncontinenceData)
            
        case .headache:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: headacheData)
            
        case .abdominal_Cramps:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: abdominalCrampsData)
            
        case .shortnessOfBreath:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: shortOfBreathData)
            
        case .dizziness:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: dizzinessData)
            
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

