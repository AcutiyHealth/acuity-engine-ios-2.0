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
        
        var arrVital:[VitalsModel] = []
        //systolicBloodPressure
        if systolicBloodPressureData.count > 0{
            let systolicBloodPressure = systolicBloodPressureData[0]
            arrVital.append(getVitalModel(item: systolicBloodPressure))
        }
        //diastolicBloodPressure
        if diastolicBloodPressureData.count > 0{
            let diastolicBloodPressure = diastolicBloodPressureData[0]
            arrVital.append(getVitalModel(item: diastolicBloodPressure))
        }
        //temprature
        if tempratureData.count > 0{
            let temprature = tempratureData[0]
            arrVital.append(getVitalModel(item: temprature))
        }
        //heartRate
        if heartRateData.count > 0{
            let heartRate = heartRateData[0]
            arrVital.append(getVitalModel(item: heartRate))
        }
        //bloodSugar
        if bloodSugarData.count > 0{
            let bloodSugar = bloodSugarData[0]
            arrVital.append(getVitalModel(item: bloodSugar))
        }
        return arrVital
    }
    func getVitalModel(item:EndocrineVitalsData)->VitalsModel{
        let impData =  VitalsModel(title: item.title.rawValue, value: String(format: "%.2f", item.value))
        impData.color = item.getUIColorFromCalculatedValue()
        return impData
    }
    
    //Get list of data for specific Vital..
    func getArrayDataForVitals(days:SegmentValueForGraph,title:String) -> [VitalsModel]{
        var arrVital:[VitalsModel] = []
        let vitalsName = VitalsName(rawValue: title)
        var filterArray:[VitalCalculation] = []
        
        switch vitalsName {
        //Systolic
        case .bloodPressureSystolic:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: systolicBloodPressureData)
        //Diastolic
        case .bloodPressureDiastolic:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: diastolicBloodPressureData)
        //temperature
        case .temperature:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: tempratureData)
        //heartRate
        case .heartRate:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: heartRateData)
        //bloodSugar
        case .bloodSugar:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: bloodSugarData)
            
        default:
            break
        }
        for item in filterArray{
            arrVital.append(saveVitalsInArray(item: item))
        }
        return arrVital
    }
}


