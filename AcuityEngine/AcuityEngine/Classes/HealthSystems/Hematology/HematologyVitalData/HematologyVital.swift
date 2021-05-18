//
//  HematoVitals.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit



class HematoVital:VitalProtocol {
    /*S Blood pressure
     D Blood pressure
     body mass index
     Temperature*/
    
    var systolicBloodPressureData:[HematoVitalsData] = []
    var diastolicBloodPressureData:[HematoVitalsData] = []
    var tempratureData:[HematoVitalsData] = []
    var BMIData:[HematoVitalsData] = []
    
    var totalScore:[Double] = []
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    private var arrVital:[VitalsModel] = []
    
    
    func totalVitalsScore() -> Double {
        let systolicBloodPressur = (Double(systolicBloodPressureData.average(\.score)) .isNaN ? 0 : Double(systolicBloodPressureData.average(\.score)))
        let diastolicBloodPressure = (Double(diastolicBloodPressureData.average(\.score)).isNaN ? 0 : Double(diastolicBloodPressureData.average(\.score)))
        let temprature = (Double(tempratureData.average(\.score)).isNaN ? 0 : Double(tempratureData.average(\.score)))
        let BMI = (Double(BMIData.average(\.score)) .isNaN ? 0 : Double(BMIData.average(\.score)))
        
        let totalVitalScore = systolicBloodPressur + diastolicBloodPressure  + temprature + BMI
        
        return totalVitalScore;
    }
    
    func totalVitalsScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        //print(totalAmount) // 4500.0
        /*arrayDayWiseScoreTotal = []
         var arrVital:[Metrix] = []
         
         arrVital.append(contentsOf: systolicBloodPressureData)
         arrVital.append(contentsOf: diastolicBloodPressureData)
         
         arrayDayWiseScoreTotal = daywiseFilterMetrixsData(days: days, array: arrVital, metriXType: MetricsType.Vitals)
         
         arrVital = []*/
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
            //BMIData
            let scoreBMI = getScoreForVitalDataWithGivenDateRange(sampleItem: BMIData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scoreSystolic + scoreDyastolic + scoreTemprature + scoreBMI
            arrayDayWiseScoreTotal.append(totalScore)
        }
        
        return arrayDayWiseScoreTotal
    }
    func getMaxVitalsScore() -> Double {
        
        let systolicBloodPressur = HematoVitalRelativeImportance.bloodPressureSystolic.getConvertedValueFromPercentage()
        let diastolicBloodPressure = HematoVitalRelativeImportance.bloodPressureDiastolic.getConvertedValueFromPercentage()
        let temperature = HematoVitalRelativeImportance.temperature.getConvertedValueFromPercentage()
        let BMI = HematoVitalRelativeImportance.BMI.getConvertedValueFromPercentage()
        
        
        let totalVitalScore = systolicBloodPressur + diastolicBloodPressure  + temperature + BMI
        
        return totalVitalScore;
    }
    
    //Get recent data for Specific Vitals..
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[VitalsModel]{
        
        arrVital = []
        
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        
        //systolicBloodPressureData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: systolicBloodPressureData)
        
        //diastolicBloodPressureData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: diastolicBloodPressureData)
        
        //tempratureData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: tempratureData)
        
        //BMIData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: BMIData)
        
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
        case .bloodPressureSystolic:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: systolicBloodPressureData)
            
        case .bloodPressureDiastolic:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: diastolicBloodPressureData)
            
        case .temperature:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: tempratureData)
            
        case .BMI:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: BMIData)
            
        default:
            break
        }
        for item in filterArray{
            arrVital.append(saveVitalsInArray(item: item))
        }
        return arrVital
    }
}


