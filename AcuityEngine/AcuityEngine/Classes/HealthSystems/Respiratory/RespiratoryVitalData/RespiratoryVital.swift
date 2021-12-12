//
//  RespiratoryVitalsData.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit



class RespiratoryVital:VitalProtocol {
    var systolicBloodPressureData:[RespiratoryVitalsData] = []
    var diastolicBloodPressureData:[RespiratoryVitalsData] = []
    var respiratoryRateData:[RespiratoryVitalsData] = []
    var oxygenSaturationData:[RespiratoryVitalsData] = []
    var heartRateData:[RespiratoryVitalsData] = []
    var irregularRhythmNotificationData:[RespiratoryVitalsData] = []
    var peakFlowRateData:[RespiratoryVitalsData] = []
    var vO2MaxData:[RespiratoryVitalsData] = []
    var stepsData:[RespiratoryVitalsData] = []
    var sleepData:[RespiratoryVitalsData] = []
    //var inhalerUsageData:[RespiratoryVitalsData] = []
    var totalScore:[Double] = []
    var arrayDayWiseScoreTotal:[Double] = []
    
    //For Dictionary Representation
    private var arrVital:[VitalsModel] = []
    
    func totalVitalsScore() -> Double {
        let systolicBloodPressur = (Double(systolicBloodPressureData.average(\.score)) .isNaN ? 0 : Double(systolicBloodPressureData.average(\.score)))
        let diastolicBloodPressure = (Double(diastolicBloodPressureData.average(\.score)).isNaN ? 0 : Double(diastolicBloodPressureData.average(\.score)))
        let respiratoryRate = (Double(respiratoryRateData.average(\.score)).isNaN ? 0 : Double(respiratoryRateData.average(\.score)))
        let oxygenSaturation = (Double(oxygenSaturationData.average(\.score)).isNaN ? 0 : Double(oxygenSaturationData.average(\.score)))
        let heartRate = (Double(heartRateData.average(\.score) ).isNaN ? 0 : Double(heartRateData.average(\.score) ) )
        let irregularRhythmNotification = (Double(irregularRhythmNotificationData.average(\.score)).isNaN ? 0 :  Double(irregularRhythmNotificationData.average(\.score)))
        let vo2max = (Double(vO2MaxData.average(\.score)).isNaN ? 0 : Double(vO2MaxData.average(\.score)))
        let peakFlowRate = (Double(peakFlowRateData.average(\.score)).isNaN ? 0 : Double(peakFlowRateData.average(\.score)))
        let steps = (Double(stepsData.average(\.score)).isNaN ? 0 : Double(stepsData.average(\.score)))
        let sleep = (Double(sleepData.average(\.score)).isNaN ? 0 : Double(sleepData.average(\.score)))
        //let inhalerUsage = (Double(inhalerUsageData.average(\.score)).isNaN ? 0 : Double(inhalerUsageData.average(\.score)))
        
        
        let totalVitalScore = systolicBloodPressur + diastolicBloodPressure + irregularRhythmNotification + respiratoryRate + oxygenSaturation   + heartRate   + vo2max + peakFlowRate + sleep + steps
        
        return totalVitalScore;
    }
    
    func totalVitalsScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        //print(totalAmount) // 4500.0
        /*arrayDayWiseScoreTotal = []
         var arrVital:[Metrix] = []
         
         arrVital.append(contentsOf: systolicBloodPressureData)
         arrVital.append(contentsOf: diastolicBloodPressureData)
         arrVital.append(contentsOf: heartRateData)
         arrVital.append(contentsOf: respiratoryRateData)
         arrVital.append(contentsOf: oxygenSaturationData)
         arrVital.append(contentsOf: irregularRhythmNotificationData)
         arrVital.append(contentsOf: peakFlowRateData)
         arrVital.append(contentsOf: vO2MaxData)
         arrVital.append(contentsOf: inhalerUsageData)
         
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
            //print("timeIntervalByLastMonth",getDateMediumFormat(time:timeIntervalByLastMonth))
            let timeIntervalByNow:Double = now.timeIntervalSince1970
            //print("timeIntervalByNow",getDateMediumFormat(time:timeIntervalByNow))
            now = day
            
            //systolicBloodPressureData
            let scoreSystolic = getScoreForVitalDataWithGivenDateRange(sampleItem: systolicBloodPressureData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //diastolicBloodPressureData
            let scoreDyastolic = getScoreForVitalDataWithGivenDateRange(sampleItem: diastolicBloodPressureData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //respiratoryRateData
            let scoreRespiratoryRateData = getScoreForVitalDataWithGivenDateRange(sampleItem: respiratoryRateData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //oxygenSaturationData
            let scoreOxygenSaturationData = getScoreForVitalDataWithGivenDateRange(sampleItem: oxygenSaturationData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //heartRateData
            let scoreHeartRateData = getScoreForVitalDataWithGivenDateRange(sampleItem: heartRateData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //irregularRhythmNotificationData
            let scoreIrregularRhythmNotification = getScoreForVitalDataWithGivenDateRange(sampleItem: irregularRhythmNotificationData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //peakFlowRateData
            let scorePeakFlowRateData = getScoreForVitalDataWithGivenDateRange(sampleItem: peakFlowRateData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //vO2MaxData
            let scoreVO2MaxData = getScoreForVitalDataWithGivenDateRange(sampleItem: vO2MaxData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //inhalerUsageData
            //let scoreInhalerUsageData = getScoreForVitalDataWithGivenDateRange(sampleItem: inhalerUsageData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //stepsData
            let scorestepsData = getScoreForVitalDataWithGivenDateRange(sampleItem: stepsData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //sleepData
            let scoresleepData = getScoreForVitalDataWithGivenDateRange(sampleItem: sleepData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            let totalScore = scoreSystolic + scoreDyastolic + scoreRespiratoryRateData + scoreOxygenSaturationData + scoreHeartRateData + scoreIrregularRhythmNotification + scorePeakFlowRateData + scoreVO2MaxData + scoresleepData + scorestepsData
            arrayDayWiseScoreTotal.append(totalScore)
        }
        
        
        
        return arrayDayWiseScoreTotal
    }
    func getMaxVitalsScore() -> Double {
        
        let systolicBloodPressur = RespiratoryVitalRelativeImportance.bloodPressureSystolic.getConvertedValueFromPercentage()
        let diastolicBloodPressure = RespiratoryVitalRelativeImportance.bloodPressureDiastolic.getConvertedValueFromPercentage()
        let heartRate = RespiratoryVitalRelativeImportance.heartRate.getConvertedValueFromPercentage()
        let respiratoryRate = RespiratoryVitalRelativeImportance.respiratoryRate.getConvertedValueFromPercentage()
        let oxygenSaturation = RespiratoryVitalRelativeImportance.oxygenSaturation.getConvertedValueFromPercentage()
        let irregularRhythmNotification = RespiratoryVitalRelativeImportance.irregularRhymesNotification.getConvertedValueFromPercentage()
        let peakFlowRate = RespiratoryVitalRelativeImportance.peakFlowRate.getConvertedValueFromPercentage()
        let vo2max = RespiratoryVitalRelativeImportance.vo2Max.getConvertedValueFromPercentage()
        let sleep = RespiratoryVitalRelativeImportance.sleep.getConvertedValueFromPercentage()
        let steps = RespiratoryVitalRelativeImportance.steps.getConvertedValueFromPercentage()
        //let inhalerUsage = RespiratoryVitalRelativeImportance.inhalerUsage.getConvertedValueFromPercentage()
        
        let totalVitalScore = systolicBloodPressur + diastolicBloodPressure  + heartRate + respiratoryRate + irregularRhythmNotification  + oxygenSaturation + peakFlowRate + vo2max + sleep + steps
        
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
        
        //respiratoryRateData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: respiratoryRateData)
        
        //oxygenSaturationData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: oxygenSaturationData)
        
        //irregularRhythmNotificationData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: irregularRhythmNotificationData)
        
        //peakFlowRateData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: peakFlowRateData)
        
        //vO2MaxData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: vO2MaxData)
        
        //inhalerUsageData
        //filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: inhalerUsageData)
        
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
            
        case .respiratoryRate:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: respiratoryRateData)
            
        case .oxygenSaturation:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: oxygenSaturationData)
            
        case .heartRate:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: heartRateData)
            
        case .irregularRhymesNotification:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: irregularRhythmNotificationData)
            
        case .vo2Max:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: vO2MaxData)
            
//        case .InhalerUsage:
//            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: inhalerUsageData)
//
        case .peakflowRate:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: peakFlowRateData)
            
        case .sleep:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: sleepData)
          
        case .steps:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: stepsData)
          
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


