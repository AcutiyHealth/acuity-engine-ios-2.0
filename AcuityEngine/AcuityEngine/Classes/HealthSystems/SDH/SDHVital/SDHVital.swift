//
//  SDHVitals.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class SDHVital:VitalProtocol {
    /*S Blood pressure
     D Blood pressure
     Age
     body mass index
     Oxygen saturation */
    
    var systolicBloodPressureData:[SDHVitalsData] = []
    var diastolicBloodPressureData:[SDHVitalsData] = []
    var ageData:[SDHVitalsData] = []
    var BMIData:[SDHVitalsData] = []
    var oxygenSaturationData:[SDHVitalsData] = []
    var stepsData:[SDHVitalsData] = []
    var waterIntakeData:[SDHVitalsData] = []
    var sleepData:[SDHVitalsData] = []
    
    var totalScore:[Double] = []
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    private var arrVital:[VitalsModel] = []
    
    func totalVitalsScore() -> Double {
        
        let systolicBloodPressure = (Double(systolicBloodPressureData.average(\.score)) .isNaN ? 0 : Double(systolicBloodPressureData.average(\.score)))
        let diastolicBloodPressure = (Double(diastolicBloodPressureData.average(\.score)) .isNaN ? 0 : Double(diastolicBloodPressureData.average(\.score)))
        let age = (Double(ageData.average(\.score)) .isNaN ? 0 : Double(ageData.average(\.score)))
        let BMI = (Double(BMIData.average(\.score)) .isNaN ? 0 : Double(BMIData.average(\.score)))
        let oxygenSaturation = (Double(oxygenSaturationData.average(\.score)) .isNaN ? 0 : Double(oxygenSaturationData.average(\.score)))
        let steps = (Double(stepsData.average(\.score)) .isNaN ? 0 : Double(stepsData.average(\.score)))
        let waterIntake = (Double(waterIntakeData.average(\.score)) .isNaN ? 0 : Double(waterIntakeData.average(\.score)))
        let sleep = (Double(sleepData.average(\.score)) .isNaN ? 0 : Double(sleepData.average(\.score)))
        
        let totalVitalScore = systolicBloodPressure + diastolicBloodPressure + age + BMI + oxygenSaturation + steps + waterIntake + sleep;
        return totalVitalScore;
    }
    
    func totalVitalsScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
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
            let scoresystolicBloodPressure = getScoreForVitalDataWithGivenDateRange(sampleItem: systolicBloodPressureData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //diastolicBloodPressureData
            let scorediastolicBloodPressure = getScoreForVitalDataWithGivenDateRange(sampleItem: diastolicBloodPressureData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //age
            let scoreAge = getScoreForVitalDataWithGivenDateRange(sampleItem: ageData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //BMI
            let scoreBMI = getScoreForVitalDataWithGivenDateRange(sampleItem: BMIData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //oxygenSaturation
            let scoreoxygenSaturation = getScoreForVitalDataWithGivenDateRange(sampleItem: oxygenSaturationData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //steps
            let scoreSteps = getScoreForVitalDataWithGivenDateRange(sampleItem: stepsData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //waterIntake
            let scorewaterIntakeData = getScoreForVitalDataWithGivenDateRange(sampleItem: waterIntakeData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //sleepData
            let scoresleepData = getScoreForVitalDataWithGivenDateRange(sampleItem: sleepData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scoresystolicBloodPressure + scorediastolicBloodPressure + scoreAge + scoreBMI + scoreoxygenSaturation + scoresleepData + scorewaterIntakeData + scoreSteps
            arrayDayWiseScoreTotal.append(totalScore)
        }
        
        return arrayDayWiseScoreTotal
    }
    func getMaxVitalsScore() -> Double {
        
        //bloodPressureSystolic
        let bloodPressureSystolic = SDHVitalRelativeImportance.bloodPressureSystolic.getConvertedValueFromPercentage()
        //bloodPressureDiastolic
        let bloodPressureDiastolic = SDHVitalRelativeImportance.bloodPressureDiastolic.getConvertedValueFromPercentage()
        //age
        let age = SDHVitalRelativeImportance.age.getConvertedValueFromPercentage()
        //BMI
        let BMI = SDHVitalRelativeImportance.BMI.getConvertedValueFromPercentage()
        //oxygenSaturation
        let oxygenSaturation = SDHVitalRelativeImportance.oxygenSaturation.getConvertedValueFromPercentage()
        //steps
        let steps = SDHVitalRelativeImportance.steps.getConvertedValueFromPercentage()
        //waterIntake
        let waterIntake = SDHVitalRelativeImportance.waterIntake.getConvertedValueFromPercentage()
        //sleep
        let sleep = SDHVitalRelativeImportance.sleep.getConvertedValueFromPercentage()
        
        let totalVitalScore =  bloodPressureSystolic + bloodPressureDiastolic + age + BMI + oxygenSaturation + steps + waterIntake + sleep
        
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
        
        //ageData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: ageData)
        
        //BMIData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: BMIData)
        
        //oxygenSaturationData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: oxygenSaturationData)
        
        //stepsData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: stepsData)
        
        //waterIntakeData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: waterIntakeData)
        
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
            //age
        case .age:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: ageData)
            //BMI
        case .BMI:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: BMIData)
            //oxygenSaturation
        case .oxygenSaturation:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: oxygenSaturationData)
            //stepsData
        case .steps:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: stepsData)
            //sleepData
        case .sleep:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: sleepData)
            //waterIntakeData
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


