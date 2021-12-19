//
//  MuscVitals.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class MuscVital:VitalProtocol {
    /*Step Length
     body mass index */
    
    var stepsData:[MuscVitalsData] = []
    var BMIData:[MuscVitalsData] = []
    var waterIntakeData:[MuscVitalsData] = []
    
    var totalScore:[Double] = []
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    private var arrVital:[VitalsModel] = []
    
    func totalVitalsScore() -> Double {
        
        let steps = (Double(stepsData.average(\.score)) .isNaN ? 0 : Double(stepsData.average(\.score)))
        let BMI = (Double(BMIData.average(\.score)) .isNaN ? 0 : Double(BMIData.average(\.score)))
        let waterIntake = (Double(waterIntakeData.average(\.score)) .isNaN ? 0 : Double(waterIntakeData.average(\.score)))
        
        let totalVitalScore = steps + BMI + waterIntake;
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
            
            //stepsData
            let scoresteps = getScoreForVitalDataWithGivenDateRange(sampleItem: stepsData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //BMI
            let scoreBMI = getScoreForVitalDataWithGivenDateRange(sampleItem: BMIData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //waterIntake
            let scorewaterIntake = getScoreForVitalDataWithGivenDateRange(sampleItem: waterIntakeData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore =  scoreBMI + scoresteps + scorewaterIntake
            arrayDayWiseScoreTotal.append(totalScore)
        }
        
        return arrayDayWiseScoreTotal
    }
    func getMaxVitalsScore() -> Double {
        
        //steps
        let steps = MuscVitalRelativeImportance.steps.getConvertedValueFromPercentage()
        
        //BMI
        let BMI = MuscVitalRelativeImportance.BMI.getConvertedValueFromPercentage()
        
        //waterIntake
        let waterIntake = MuscVitalRelativeImportance.waterIntake.getConvertedValueFromPercentage()
        
        
        let totalVitalScore =  steps  + BMI + waterIntake
        
        return totalVitalScore;
    }
    
    //Get recent data for Specific Vitals..
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[VitalsModel]{
        
        arrVital = []
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        
        //stepsData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: stepsData)
        
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
            //stepLength
        case .stepsData:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: stepsData)
            //BMI
        case .BMI:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: BMIData)
            //waterIntakeData
        case .waterIntake:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: waterIntakeData)
        default:
            break
        }
        for item in filterArray{
            arrVital.append(saveVitalsInArray(item: item))
        }
        return arrVital
    }
}


