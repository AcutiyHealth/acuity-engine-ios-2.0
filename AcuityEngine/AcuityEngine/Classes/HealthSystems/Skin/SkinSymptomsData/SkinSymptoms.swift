//
//  SkinSymptoms.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class SkinSymptoms:SymptomsProtocol {
    /*
     Acne
     Dry Skin
     Hair Loss
     chills
     fever
     */
    var acneData:[SkinSymptomsPainData] = []
    var drySkinData:[SkinSymptomsPainData] = []
    var hairLossData:[SkinSymptomsPainData] = []
    var chillsData:[SkinSymptomsPainData] = []
    var feverData:[SkinSymptomsPainData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    private var arrSymptoms:[SymptomsModel] = []
    
    func totalSymptomDataScore() -> Double {
        return 0
    }
    
    func getMaxSymptomDataScore() -> Double {
        
        let acne = SkinSymptomsRelativeImportance.acne.getConvertedValueFromPercentage()
        let drySkin = SkinSymptomsRelativeImportance.drySkin.getConvertedValueFromPercentage()
        let hairLoss = SkinSymptomsRelativeImportance.hairLoss.getConvertedValueFromPercentage()
        
        let chills = SkinSymptomsRelativeImportance.chills.getConvertedValueFromPercentage()
        let fever = SkinSymptomsRelativeImportance.fever.getConvertedValueFromPercentage()
        
        let totalLabScore1 = acne + drySkin + hairLoss
        let totalLabScore2 = chills + fever
        
        
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
            
            //acne
            let scoreacne = getScoreForSymptomsDataWithGivenDateRange(sampleItem: acneData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //drySkin
            let scoredrySkin = getScoreForSymptomsDataWithGivenDateRange(sampleItem: drySkinData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //hairLoss
            let scorehairLoss = getScoreForSymptomsDataWithGivenDateRange(sampleItem: hairLossData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //chillsData
            let scorechills = getScoreForSymptomsDataWithGivenDateRange(sampleItem: chillsData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //fever
            let scorfever = getScoreForSymptomsDataWithGivenDateRange(sampleItem: feverData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore1 = scoreacne + scoredrySkin + scorehairLoss
            let totalScore2 = scorechills + scorfever
            
            arrayDayWiseScoreTotal.append(totalScore1 + totalScore2)
        }
        
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[SymptomsModel]{
        
        arrSymptoms = []
        
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        
        //acneData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: acneData)
        
        //drySkinData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: drySkinData)
        
        //hairLossData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: hairLossData)
        
        //chillsData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: chillsData)
        
        //feverData
        filterSymptomsArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: feverData)
        
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
        //acne
        case .acne:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: acneData)
        //drySkin
        case .drySkin:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: drySkinData)
            
        //hairLoss
        case .hairLoss:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: hairLossData)
        //chills
        case .chills:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: chillsData)
            
        //fever
        case .fever:
            filterArray = filterSymptomsArrayWithSelectedSegmentInGraph(days: days, array: feverData)
            
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

