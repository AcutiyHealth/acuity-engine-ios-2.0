//
//  CardioVitalsData.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit



class CardioVital:VitalProtocol {
    /*
     S Blood pressure
     D Blood pressure
     Heart rate
     Irregular rhythm notification
     High heart rate
     Low heart rate
     VO2 Max
     Oxygen saturation
     */
    var heartRateData:[CardioVitalsData] = []
    var systolicBloodPressureData:[CardioVitalsData] = []
    var diastolicBloodPressureData:[CardioVitalsData] = []
    var irregularRhythmNotificationData:[CardioVitalsData] = []
    var highHeartRateData:[CardioVitalsData] = []
    var lowHeartRateData:[CardioVitalsData] = []
    var vO2MaxData:[CardioVitalsData] = []
    var oxygenSaturationData:[CardioVitalsData] = []
    var totalScore:[Double] = []
    var arrayDayWiseScoreTotal:[Double] = []
    
    
    func totalVitalsScore() -> Double {
        
        let heartRate = (Double(heartRateData.average(\.score) ).isNaN ? 0 : Double(heartRateData.average(\.score) ) )
        let systolicBloodPressur = (Double(systolicBloodPressureData.average(\.score)) .isNaN ? 0 : Double(systolicBloodPressureData.average(\.score)))
        let diastolicBloodPressure = (Double(diastolicBloodPressureData.average(\.score)).isNaN ? 0 : Double(diastolicBloodPressureData.average(\.score)))
        let irregularRhythmNotification = (Double(irregularRhythmNotificationData.average(\.score)).isNaN ? 0 :  Double(irregularRhythmNotificationData.average(\.score)))
        let highHeartRate = (Double(highHeartRateData.average(\.score)).isNaN ? 0 : Double(highHeartRateData.average(\.score)))
        let lowHeartRate = (Double(lowHeartRateData.average(\.score)).isNaN ? 0 : Double(lowHeartRateData.average(\.score)))
        let vo2max = (Double(vO2MaxData.average(\.score)).isNaN ? 0 : Double(vO2MaxData.average(\.score)))
        let oxygenSaturation = (Double(oxygenSaturationData.average(\.score)).isNaN ? 0 : Double(oxygenSaturationData.average(\.score)))
        
        let totalVitalScore = heartRate  + systolicBloodPressur + diastolicBloodPressure + irregularRhythmNotification + highHeartRate + lowHeartRate + vo2max + oxygenSaturation
        print("heartRate -> \(heartRate) \n systolicBloodPressur -> \(systolicBloodPressur) \n diastolicBloodPressure -> \(diastolicBloodPressure) \n irregularRhythmNotification -> \(irregularRhythmNotification) \n highHeartRate -> \(highHeartRate) \n lowHeartRate -> \(lowHeartRate) \n vo2max -> \(vo2max) oxygenSaturation -> \(oxygenSaturation)")
        
        return totalVitalScore;
    }
    
    func totalVitalsScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        //print(totalAmount) // 4500.0
        /*arrayDayWiseScoreTotal = []
        var arrVital:[Metrix] = []
        
        arrVital.append(contentsOf: systolicBloodPressureData)
        arrVital.append(contentsOf: diastolicBloodPressureData)
        arrVital.append(contentsOf: heartRateData)
        arrVital.append(contentsOf: irregularRhythmNotificationData)
        arrVital.append(contentsOf: highHeartRateData)
        arrVital.append(contentsOf: lowHeartRateData)
        arrVital.append(contentsOf: vO2MaxData)
        arrVital.append(contentsOf: oxygenSaturationData)
        
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
            //print("timeIntervalByLastMonth",getDateMediumFormat(time:timeIntervalByLastMonth))
            let timeIntervalByNow:Double = now.timeIntervalSince1970
            //print("timeIntervalByNow",getDateMediumFormat(time:timeIntervalByNow))
            now = day
            
            //systolicBloodPressureData
            let scoreSystolic = getScoreForVitalDataWithGivenDateRange(sampleItem: systolicBloodPressureData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //diastolicBloodPressureData
            let scoreDyastolic = getScoreForVitalDataWithGivenDateRange(sampleItem: diastolicBloodPressureData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //heartRateData
            let scoreHeartRateData = getScoreForVitalDataWithGivenDateRange(sampleItem: heartRateData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //irregularRhythmNotificationData
            let scoreIrregularRhythmNotification = getScoreForVitalDataWithGivenDateRange(sampleItem: irregularRhythmNotificationData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //highHeartRateData
            let scoreHighHeartRateData = getScoreForVitalDataWithGivenDateRange(sampleItem: highHeartRateData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //lowHeartRateData
            let scoreLowHeartRateData = getScoreForVitalDataWithGivenDateRange(sampleItem: lowHeartRateData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //vO2MaxData
            let scoreVO2MaxData = getScoreForVitalDataWithGivenDateRange(sampleItem: vO2MaxData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //oxygenSaturationData
            let scoreOxygenSaturationData = getScoreForVitalDataWithGivenDateRange(sampleItem: oxygenSaturationData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scoreSystolic + scoreDyastolic + scoreHeartRateData + scoreIrregularRhythmNotification  + scoreHighHeartRateData + scoreLowHeartRateData + scoreVO2MaxData + scoreOxygenSaturationData
            arrayDayWiseScoreTotal.append(totalScore)
        }
        return arrayDayWiseScoreTotal
    }
    
    func getMaxVitalsScore() -> Double {
        
        let heartRate = CardioVitalRelativeImportance.heartRate.getConvertedValueFromPercentage()
        let systolicBloodPressur = CardioVitalRelativeImportance.bloodPressureSystolic.getConvertedValueFromPercentage()
        let diastolicBloodPressure = CardioVitalRelativeImportance.bloodPressureDiastolic.getConvertedValueFromPercentage()
        let irregularRhythmNotification = CardioVitalRelativeImportance.irregularRhymesNotification.getConvertedValueFromPercentage()
        let highHeartRate = CardioVitalRelativeImportance.highHeartRate.getConvertedValueFromPercentage()
        let lowHeartRate = CardioVitalRelativeImportance.lowHeartRate.getConvertedValueFromPercentage()
        let vo2max = CardioVitalRelativeImportance.vo2Max.getConvertedValueFromPercentage()
        let oxygenSaturation = CardioVitalRelativeImportance.oxygenSaturation.getConvertedValueFromPercentage()
        
        
        let totalVitalScore = heartRate  + systolicBloodPressur + diastolicBloodPressure + irregularRhythmNotification + highHeartRate + lowHeartRate + vo2max + oxygenSaturation
        
        return totalVitalScore;
    }
    
    //Get recent data for Specific Vitals..
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
        if heartRateData.count > 0{
            let heartRate = heartRateData[0]
            arrVital.append(getVitalModel(item: heartRate))
        }
        if irregularRhythmNotificationData.count > 0{
            let irregularRhythmNotification = irregularRhythmNotificationData[0]
            arrVital.append(getVitalModel(item: irregularRhythmNotification))
        }
        if highHeartRateData.count > 0{
            let highHeartRate = highHeartRateData[0]
            arrVital.append(getVitalModel(item: highHeartRate))
        }
        if lowHeartRateData.count > 0{
            let lowHeartRate = lowHeartRateData[0]
            arrVital.append(getVitalModel(item: lowHeartRate))
        }
        if vO2MaxData.count > 0{
            let vO2Max = vO2MaxData[0]
            arrVital.append(getVitalModel(item: vO2Max))
        }
        if oxygenSaturationData.count > 0{
            let oxygenSaturation = oxygenSaturationData[0]
            arrVital.append(getVitalModel(item: oxygenSaturation))
        }
        
        return arrVital
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
            
        case .heartRate:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: heartRateData)
            
        case .irregularRhymesNotification:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: irregularRhythmNotificationData)
            
        case .highHeartRate:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: highHeartRateData)
            
        case .lowHeartRate:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: lowHeartRateData)
            
        case .vo2Max:
            filterArray = filterArrayWithSelectedSegmentInGraph(days: days, array: vO2MaxData)
            
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

