//
//  IDiseaseVitals.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit



class IDiseaseVital:VitalProtocol {
    /*Temperature
     Heart rate
     Oxygen saturation
     S Blood pressure
     D Blood pressure*/
    var systolicBloodPressureData:[IDiseaseVitalsData] = []
    var diastolicBloodPressureData:[IDiseaseVitalsData] = []
    var temperatureData:[IDiseaseVitalsData] = []
    var heartRateData:[IDiseaseVitalsData] = []
    var oxygenSaturationData:[IDiseaseVitalsData] = []
    
    var totalScore:[Double] = []
    var arrayDayWiseScoreTotal:[Double] = []
    
    
    func totalVitalsScore() -> Double {
        let systolicBloodPressur = (Double(systolicBloodPressureData.average(\.score)) .isNaN ? 0 : Double(systolicBloodPressureData.average(\.score)))
        let diastolicBloodPressure = (Double(diastolicBloodPressureData.average(\.score)).isNaN ? 0 : Double(diastolicBloodPressureData.average(\.score)))
        let temperature = (Double(temperatureData.average(\.score)) .isNaN ? 0 : Double(temperatureData.average(\.score)))
        let heartRate = (Double(heartRateData.average(\.score)).isNaN ? 0 : Double(heartRateData.average(\.score)))
        let oxygenSaturation = (Double(oxygenSaturationData.average(\.score)) .isNaN ? 0 : Double(oxygenSaturationData.average(\.score)))
        
        let totalVitalScore = systolicBloodPressur + diastolicBloodPressure + temperature + heartRate + oxygenSaturation
        
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
            //temperatureData
            let scoreTemperature = getScoreForVitalDataWithGivenDateRange(sampleItem: temperatureData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //heartRateData
            let scoreHeartRate = getScoreForVitalDataWithGivenDateRange(sampleItem: heartRateData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //oxygenSaturationData
            let scoreOxygenSaturation = getScoreForVitalDataWithGivenDateRange(sampleItem: oxygenSaturationData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scoreSystolic + scoreDyastolic + scoreTemperature + scoreHeartRate + scoreOxygenSaturation
            arrayDayWiseScoreTotal.append(totalScore)
        }
        
        return arrayDayWiseScoreTotal
    }
    func getMaxVitalsScore() -> Double {
        
        let systolicBloodPressur = IDiseaseVitalRelativeImportance.bloodPressureSystolic.getConvertedValueFromPercentage()
        let diastolicBloodPressure = IDiseaseVitalRelativeImportance.bloodPressureDiastolic.getConvertedValueFromPercentage()
        let temprature = IDiseaseVitalRelativeImportance.temprature.getConvertedValueFromPercentage()
        let heartRate = IDiseaseVitalRelativeImportance.heartRate.getConvertedValueFromPercentage()
        let oxygenSaturation = IDiseaseVitalRelativeImportance.oxygenSaturation.getConvertedValueFromPercentage()
        
        
        let totalVitalScore = systolicBloodPressur + diastolicBloodPressure + temprature + heartRate + oxygenSaturation
        
        return totalVitalScore;
    }
    
    //Get recent data for Specific Vitals..
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[VitalsModel]{
        
        var arrVital:[VitalsModel] = []
        
        if systolicBloodPressureData.count > 0{
            let systolicBloodPressure = systolicBloodPressureData[0]
            arrVital.append(getVitalModel(item: systolicBloodPressure))
        }
        if diastolicBloodPressureData.count > 0{
            let diastolicBloodPressure = diastolicBloodPressureData[0]
            arrVital.append(getVitalModel(item: diastolicBloodPressure))
        }
        if temperatureData.count > 0{
            let temperature = temperatureData[0]
            arrVital.append(getVitalModel(item: temperature))
        }
        if heartRateData.count > 0{
            let heartRate = heartRateData[0]
            arrVital.append(getVitalModel(item: heartRate))
        }
        if oxygenSaturationData.count > 0{
            let oxygenSaturation = oxygenSaturationData[0]
            arrVital.append(getVitalModel(item: oxygenSaturation))
        }
        return arrVital
    }
    func getVitalModel(item:IDiseaseVitalsData)->VitalsModel{
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
        case .bloodPressureSystolic:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: systolicBloodPressureData)
            
        case .bloodPressureDiastolic:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: diastolicBloodPressureData)
            
        case .temperature:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: temperatureData)
            
        case .heartRate:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: heartRateData)
            
        case .oxygenSaturation:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: oxygenSaturationData)
            
        default:
            break
        }
        for item in filterArray{
            arrVital.append(saveVitalsInArray(item: item))
        }
        return arrVital
    }
}


