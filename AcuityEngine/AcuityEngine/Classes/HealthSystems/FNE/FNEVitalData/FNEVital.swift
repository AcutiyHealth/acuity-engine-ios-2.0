//
//  FNEVitals.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit



class FNEVital:VitalProtocol {
    /*S Blood pressure
     D Blood pressure
     Heart rate
     Irregular rhythm notification
     body mass index*/
    
    var systolicBloodPressureData:[FNEVitalsData] = []
    var diastolicBloodPressureData:[FNEVitalsData] = []
    var heartRateData:[FNEVitalsData] = []
    var irregularRhymesNotificationData:[FNEVitalsData] = []
    var BMIData:[FNEVitalsData] = []
    var waterIntakeData:[FNEVitalsData] = []
    
    var totalScore:[Double] = []
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    private var arrVital:[VitalsModel] = []
    
    func totalVitalsScore() -> Double {
        let systolicBloodPressur = (Double(systolicBloodPressureData.average(\.score)) .isNaN ? 0 : Double(systolicBloodPressureData.average(\.score)))
        let diastolicBloodPressure = (Double(diastolicBloodPressureData.average(\.score)).isNaN ? 0 : Double(diastolicBloodPressureData.average(\.score)))
        let irregularRhymesNotification = (Double(irregularRhymesNotificationData.average(\.score)) .isNaN ? 0 : Double(irregularRhymesNotificationData.average(\.score)))
        let heartRate = (Double(heartRateData.average(\.score)).isNaN ? 0 : Double(heartRateData.average(\.score)))
        let BMI = (Double(BMIData.average(\.score)) .isNaN ? 0 : Double(BMIData.average(\.score)))
        let waterIntake = (Double(waterIntakeData.average(\.score)) .isNaN ? 0 : Double(waterIntakeData.average(\.score)))
       
        let totalVitalScore = systolicBloodPressur + diastolicBloodPressure + irregularRhymesNotification + heartRate + BMI + waterIntake
        
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
        /*
         Here We get component is Month/Day and noOfTimesLoopExecute to execute.
         We get selection from Segment Control from Pull up
         When there is & days selected, loop will execute 7 times
         When there is 1 Month selected, loop will execute per weeks count
         When there is 3 month selected, loop will execute 3 times
         So any vital's start time is between range, take average of vital's score and after do sum of all vital and store it in array..
         So, if there is 7 times loop execute aboce process with execute 7 times and final array will have 7 entries.
         */
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
            //irregularRhymesNotificationData
            let scoreIrregularRhymesNotification = getScoreForVitalDataWithGivenDateRange(sampleItem: irregularRhymesNotificationData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //heartRateData
            let scoreHeartRate = getScoreForVitalDataWithGivenDateRange(sampleItem: heartRateData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //BMIData
            let scoreBMI = getScoreForVitalDataWithGivenDateRange(sampleItem: BMIData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //waterIntakeData
            let scorewaterIntake = getScoreForVitalDataWithGivenDateRange(sampleItem: waterIntakeData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scoreSystolic + scoreDyastolic + scoreIrregularRhymesNotification + scoreHeartRate + scoreBMI + scorewaterIntake
            arrayDayWiseScoreTotal.append(totalScore)
        }
        
        return arrayDayWiseScoreTotal
    }
    func getMaxVitalsScore() -> Double {
        
        let systolicBloodPressur = FNEVitalRelativeImportance.bloodPressureSystolic.getConvertedValueFromPercentage()
        let diastolicBloodPressure = FNEVitalRelativeImportance.bloodPressureDiastolic.getConvertedValueFromPercentage()
        let heartRate = FNEVitalRelativeImportance.heartRate.getConvertedValueFromPercentage()
        let irregularRhymesNotification = FNEVitalRelativeImportance.irregularRhymesNotification.getConvertedValueFromPercentage()
        let BMI = FNEVitalRelativeImportance.BMI.getConvertedValueFromPercentage()
        let waterIntake = FNEVitalRelativeImportance.waterIntake.getConvertedValueFromPercentage()
        
        let totalVitalScore = systolicBloodPressur + diastolicBloodPressure + irregularRhymesNotification + heartRate + BMI + waterIntake
        
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
        
        //irregularRhymesNotificationData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: irregularRhymesNotificationData)
        
        //heartRateData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: heartRateData)
        
        //BMIData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: BMIData)
        
        //waterIntakeData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: waterIntakeData)
        
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
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: irregularRhymesNotificationData)
            
        case .BMI:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: BMIData)
            
        case .waterIntake:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: waterIntakeData)
         
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


