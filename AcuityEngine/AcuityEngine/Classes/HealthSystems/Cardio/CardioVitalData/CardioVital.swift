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
    //For Dictionary Representation
    private var arrVital:[VitalsModel] = []
    
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
        //print("heartRate -> \(heartRate) \n systolicBloodPressur -> \(systolicBloodPressur) \n diastolicBloodPressure -> \(diastolicBloodPressure) \n irregularRhythmNotification -> \(irregularRhythmNotification) \n highHeartRate -> \(highHeartRate) \n lowHeartRate -> \(lowHeartRate) \n vo2max -> \(vo2max) oxygenSaturation -> \(oxygenSaturation)")
        
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
        /*
         Here We get component is Month/Day and noOfTimesLoopExecute to execute.
         We get selection from Segment Control from Pull up
         When there is & days selected, loop will execute 7 times
         When there is 1 Month selected, loop will execute per weeks count
         When there is 3 month selected, loop will execute 3 times
         So any vital's start time is between range, take average of vital's score and after do sum of all vital and store it in array..
         So, if there is 7 times loop execute aboce process with execute 7 times and final array will have 7 entries.
         */
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
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[VitalsModel]{
        
        arrVital = []
        
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        
        //systolicBloodPressureData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: systolicBloodPressureData)
        
        //diastolicBloodPressureData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: diastolicBloodPressureData)
        
        //heartRateData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: heartRateData)
        
        //irregularRhythmNotificationData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: irregularRhythmNotificationData)
        
        //highHeartRateData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: highHeartRateData)
        
        //lowHeartRateData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: lowHeartRateData)
        
        //vO2MaxData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: vO2MaxData)
        
        //oxygenSaturationData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: oxygenSaturationData)
        
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
    
    //Get list of data for specific Vital in detail screen..
    func getArrayDataForVitals(days:SegmentValueForGraph,title:String) -> [VitalsModel]{
        var arrVital:[VitalsModel] = []
        let vitalsName = VitalsName(rawValue: title)
        var filterArray:[VitalCalculation] = []
        
        switch vitalsName {
        case .bloodPressureSystolic:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: systolicBloodPressureData)
            
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
        case .heartRate:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: heartRateData)
            
        case .irregularRhymesNotification:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: irregularRhythmNotificationData)
            
        case .highHeartRate:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: highHeartRateData)
            
        case .lowHeartRate:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: lowHeartRateData)
            
        case .vo2Max:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: vO2MaxData)
            
        case .oxygenSaturation:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: oxygenSaturationData)
            
            
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

