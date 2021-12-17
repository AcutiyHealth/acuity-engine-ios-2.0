//
//  NeuroVitals.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class NeuroVital:VitalProtocol {
    /*S Blood pressure
     D Blood pressure
     blood oxygen level
     VO2 max */
    
    var systolicBloodPressureData:[NeuroVitalsData] = []
    var diastolicBloodPressureData:[NeuroVitalsData] = []
    var bloodOxygenLevelData:[NeuroVitalsData] = []
    var vo2MaxData:[NeuroVitalsData] = []
    var stepsData:[NeuroVitalsData] = []
    var sleepData:[NeuroVitalsData] = []
    
    var totalScore:[Double] = []
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    private var arrVital:[VitalsModel] = []
    
    func totalVitalsScore() -> Double {
        
        let systolicBloodPressure = (Double(systolicBloodPressureData.average(\.score)) .isNaN ? 0 : Double(systolicBloodPressureData.average(\.score)))
        let diastolicBloodPressure = (Double(diastolicBloodPressureData.average(\.score)) .isNaN ? 0 : Double(diastolicBloodPressureData.average(\.score)))
        let bloodOxygenLevel = (Double(bloodOxygenLevelData.average(\.score)) .isNaN ? 0 : Double(bloodOxygenLevelData.average(\.score)))
        let vo2Max = (Double(vo2MaxData.average(\.score)) .isNaN ? 0 : Double(vo2MaxData.average(\.score)))
        let steps = (Double(stepsData.average(\.score)) .isNaN ? 0 : Double(stepsData.average(\.score)))
        let sleep = (Double(sleepData.average(\.score)) .isNaN ? 0 : Double(sleepData.average(\.score)))
        
        let totalVitalScore = systolicBloodPressure + diastolicBloodPressure + bloodOxygenLevel + vo2Max + steps + sleep
        return totalVitalScore;
    }
    
    func totalVitalsScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        arrayDayWiseScoreTotal = []
        
        var now = MyWellScore.sharedManager.todaysDate
        let getComponentAndLoop = getNumberOfTimesLoopToExecute(days: days)
        let component:Calendar.Component = getComponentAndLoop["component"] as! Calendar.Component
        let noOfTimesLoopExecute:Int = getComponentAndLoop["noOfTimesLoopExecute"] as! Int
        
        for _ in 0...noOfTimesLoopExecute-1{
            
            let day = Calendar.current.date(byAdding: component, value: -1, to: now)!
            
            let timeIntervalByLastMonth:Double = day.timeIntervalSince1970
            let timeIntervalByNow:Double = now.timeIntervalSince1970
            
            now = day
            
            //systolicBloodPressure
            let scoresystolicBloodPressure = getScoreForVitalDataWithGivenDateRange(sampleItem: systolicBloodPressureData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //diastolicBloodPressureData
            let scorediastolicBloodPressure = getScoreForVitalDataWithGivenDateRange(sampleItem: diastolicBloodPressureData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //bloodOxygenLevel
            let scorebloodOxygenLevel = getScoreForVitalDataWithGivenDateRange(sampleItem: bloodOxygenLevelData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //vo2Max
            let scorevo2Max = getScoreForVitalDataWithGivenDateRange(sampleItem: vo2MaxData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //step
            let scoresteps = getScoreForVitalDataWithGivenDateRange(sampleItem: stepsData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //sleep
            let scoresleep = getScoreForVitalDataWithGivenDateRange(sampleItem: sleepData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scoresystolicBloodPressure + scorediastolicBloodPressure + scorebloodOxygenLevel + scorevo2Max + scoresteps + scoresleep
            arrayDayWiseScoreTotal.append(totalScore)
        }
        
        return arrayDayWiseScoreTotal
    }
    func getMaxVitalsScore() -> Double {
        
        //bloodPressureSystolic
        let bloodPressureSystolic = NeuroVitalRelativeImportance.bloodPressureSystolic.getConvertedValueFromPercentage()
        //bloodPressureDiastolic
        let bloodPressureDiastolic = NeuroVitalRelativeImportance.bloodPressureDiastolic.getConvertedValueFromPercentage()
        //bloodOxygenLevel
        let bloodOxygenLevel = NeuroVitalRelativeImportance.bloodOxygenLevel.getConvertedValueFromPercentage()
        //vo2Max
        let vo2Max = NeuroVitalRelativeImportance.vo2Max.getConvertedValueFromPercentage()
        //steps
        let steps = NeuroVitalRelativeImportance.steps.getConvertedValueFromPercentage()
        //sleep
        let sleep = NeuroVitalRelativeImportance.sleep.getConvertedValueFromPercentage()
        
        
        let totalVitalScore = vo2Max + bloodOxygenLevel + bloodPressureSystolic + bloodPressureDiastolic + steps + sleep
        
        return totalVitalScore;
    }
    
    //Get recent data for Specific Vitals..
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[VitalsModel]{
        /*
         Here We get component is Month/Day and noOfTimesLoopExecute to execute.
         We get selection from Segment Control from Pull up
         When there is & days selected, loop will execute 7 times
         When there is 1 Month selected, loop will execute per weeks count
         When there is 3 month selected, loop will execute 3 times
         So any vital's start time is between range, take average of vital's score and after do sum of all vital and store it in array..
         So, if there is 7 times loop execute aboce process with execute 7 times and final array will have 7 entries.
         */
        arrVital = []
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        
        //systolicBloodPressure
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: systolicBloodPressureData)
        
        //diastolicBloodPressureData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: diastolicBloodPressureData)
        
        //bloodOxygenLevelData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: bloodOxygenLevelData)
        
        //vo2MaxData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: vo2MaxData)
        
        //stepsData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: stepsData)
        
        //sleepData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: sleepData)
        return arrVital
    }
    func filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days:SegmentValueForGraph,array:[VitalCalculation]){
        var filteredArray:[VitalCalculation] = []
        filteredArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: array)
        saveFilterDataInArrayVitals(filteredArray: filteredArray)
        //return filteredArray
    }
    
    func saveFilterDataInArrayVitals(filteredArray:[VitalCalculation]){
        if filteredArray.count > 0{
            let vital = filteredArray[0]
            arrVital.append(getVitalModel(item: vital))
        }
    }
    
    //MARK:- For DetailValue  Screen...
    
    //Get list of data for specific Vital..
    func getArrayDataForVitals(days:SegmentValueForGraph,title:String) -> [VitalsModel]{
        var arrVital:[VitalsModel] = []
        let vitalsName = VitalsName(rawValue: title)
        var filterArray:[VitalCalculation] = []
        
        switch vitalsName {
            //Systolic
        case .bloodPressureSystolic:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: systolicBloodPressureData)
            //Diastolic
        case .bloodPressureDiastolic:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: diastolicBloodPressureData)
            //bloodPressureSystolicDiastolic
        case .bloodPressureSystolicDiastolic:
            
            /* Note: Here we combine data of BP Systolic and Diastolic in one combine array..
             We execute loop for systeolic and get starttime stamp and match with diastolic array time stamp..
             And create one array which contain entry from both array..
             */
            let filterArraySystolic = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: systolicBloodPressureData)
            let filterArrayDiastolic = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: diastolicBloodPressureData)
            arrVital = combineBPSystolicAndDiastolic(arraySystolic: filterArraySystolic, arrayDiastolic: filterArrayDiastolic)
            //bloodOxygenLevelData
        case .oxygenSaturation:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: bloodOxygenLevelData)
            //vo2Max
        case .vo2Max:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: vo2MaxData)
            //stepsData
        case .steps:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: stepsData)
            //sleepData
        case .sleep:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: sleepData)
            
        default:
            break
        }
        if vitalsName != .bloodPressureSystolicDiastolic{
            for item in filterArray{
                arrVital.append(saveVitalsInArray(item: item))
            }
        }
        return arrVital
    }
}


