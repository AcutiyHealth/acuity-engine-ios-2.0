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
    
    var totalScore:[Double] = []
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    private var arrVital:[VitalsModel] = []
    
    func totalVitalsScore() -> Double {
        
        let systolicBloodPressure = (Double(systolicBloodPressureData.average(\.score)) .isNaN ? 0 : Double(systolicBloodPressureData.average(\.score)))
        let diastolicBloodPressure = (Double(diastolicBloodPressureData.average(\.score)) .isNaN ? 0 : Double(diastolicBloodPressureData.average(\.score)))
        let bloodOxygenLevel = (Double(bloodOxygenLevelData.average(\.score)) .isNaN ? 0 : Double(bloodOxygenLevelData.average(\.score)))
        let vo2Max = (Double(vo2MaxData.average(\.score)) .isNaN ? 0 : Double(vo2MaxData.average(\.score)))
        
        let totalVitalScore = systolicBloodPressure + diastolicBloodPressure + bloodOxygenLevel + vo2Max
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
            
            let totalScore = scoresystolicBloodPressure + scorediastolicBloodPressure + scorebloodOxygenLevel + scorevo2Max
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
        
        let totalVitalScore = vo2Max + bloodOxygenLevel + bloodPressureSystolic + bloodPressureDiastolic
        
        return totalVitalScore;
    }
    
    //Get recent data for Specific Vitals..
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[VitalsModel]{
        
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
        //bloodOxygenLevelData
        case .oxygenSaturation:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: bloodOxygenLevelData)
        //vo2Max
        case .vo2Max:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: vo2MaxData)
            
        default:
            break
        }
        for item in filterArray{
            arrVital.append(saveVitalsInArray(item: item))
        }
        return arrVital
    }
}


