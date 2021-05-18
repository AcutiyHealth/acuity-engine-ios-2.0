//
//  EndocrineVitals.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 05/02/21.
//

import UIKit

class EndocrineVital:VitalProtocol {
    /*S Blood pressure
     D Blood pressure
     Heart rate
     blood sugar
     Temperature*/
    
    var systolicBloodPressureData:[EndocrineVitalsData] = []
    var diastolicBloodPressureData:[EndocrineVitalsData] = []
    var heartRateData:[EndocrineVitalsData] = []
    var bloodSugarData:[EndocrineVitalsData] = []
    var tempratureData:[EndocrineVitalsData] = []
    
    var totalScore:[Double] = []
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    private var arrVital:[VitalsModel] = []
    
    func totalVitalsScore() -> Double {
        let systolicBloodPressur = (Double(systolicBloodPressureData.average(\.score)) .isNaN ? 0 : Double(systolicBloodPressureData.average(\.score)))
        let diastolicBloodPressure = (Double(diastolicBloodPressureData.average(\.score)).isNaN ? 0 : Double(diastolicBloodPressureData.average(\.score)))
        let heartRate = (Double(heartRateData.average(\.score)).isNaN ? 0 : Double(heartRateData.average(\.score)))
        let bloodSugar = (Double(bloodSugarData.average(\.score)).isNaN ? 0 : Double(bloodSugarData.average(\.score)))
        let temprature = (Double(tempratureData.average(\.score)).isNaN ? 0 : Double(tempratureData.average(\.score)))
        
        let totalVitalScore = systolicBloodPressur + diastolicBloodPressure + heartRate + temprature + bloodSugar
        
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
            let scoreSystolic = getScoreForVitalDataWithGivenDateRange(sampleItem: systolicBloodPressureData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //diastolicBloodPressure
            let scoreDyastolic = getScoreForVitalDataWithGivenDateRange(sampleItem: diastolicBloodPressureData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //tempratureData
            let scoreTemprature = getScoreForVitalDataWithGivenDateRange(sampleItem: tempratureData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //heartRateData
            let scoreHeartRate = getScoreForVitalDataWithGivenDateRange(sampleItem: heartRateData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //bloodSugarData
            let scoreBloodSugar = getScoreForVitalDataWithGivenDateRange(sampleItem: bloodSugarData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scoreSystolic + scoreDyastolic + scoreTemprature + scoreHeartRate + scoreBloodSugar
            arrayDayWiseScoreTotal.append(totalScore)
        }
        
        return arrayDayWiseScoreTotal
    }
    func getMaxVitalsScore() -> Double {
        
        let systolicBloodPressur = EndocrineVitalRelativeImportance.bloodPressureSystolic.getConvertedValueFromPercentage()
        let diastolicBloodPressure = EndocrineVitalRelativeImportance.bloodPressureDiastolic.getConvertedValueFromPercentage()
        let temperature = EndocrineVitalRelativeImportance.temperature.getConvertedValueFromPercentage()
        let heartRate = EndocrineVitalRelativeImportance.heartRate.getConvertedValueFromPercentage()
        let bloodSugar = EndocrineVitalRelativeImportance.bloodSugar.getConvertedValueFromPercentage()
        
        let totalVitalScore = systolicBloodPressur + diastolicBloodPressure  + temperature + heartRate + bloodSugar
        
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
        
        //tempratureData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: tempratureData)
        
        //heartRateData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: heartRateData)
        
        //bloodSugarData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: bloodSugarData)
        
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
        //temperature
        case .temperature:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: tempratureData)
        //heartRate
        case .heartRate:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: heartRateData)
        //bloodSugar
        case .bloodSugar:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: bloodSugarData)
            
        default:
            break
        }
        for item in filterArray{
            arrVital.append(saveVitalsInArray(item: item))
        }
        return arrVital
    }
}


