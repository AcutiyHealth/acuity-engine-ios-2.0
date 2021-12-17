//
//  GastrointestinalVitals.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 05/02/21.
//

import UIKit

class GastrointestinalVital:VitalProtocol {
    /*body mass index*/
    var bodyMassIndexData:[GastrointestinalVitalsData] = []
    var waterIntakeData:[GastrointestinalVitalsData] = []
    var stepsData:[GastrointestinalVitalsData] = []
    var totalScore:[Double] = []
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    private var arrVital:[VitalsModel] = []
    
    func totalVitalsScore() -> Double {
        let bodyMassIndex = (Double(bodyMassIndexData.average(\.score)) .isNaN ? 0 : Double(bodyMassIndexData.average(\.score)))
        let steps = (Double(stepsData.average(\.score)) .isNaN ? 0 : Double(stepsData.average(\.score)))
        let waterIntake = (Double(waterIntakeData.average(\.score)) .isNaN ? 0 : Double(waterIntakeData.average(\.score)))
        
        let totalVitalScore = bodyMassIndex + steps + waterIntake
        
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
            let scorebodyMassIndex = getScoreForVitalDataWithGivenDateRange(sampleItem: bodyMassIndexData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //stepsData
            let scoresteps = getScoreForVitalDataWithGivenDateRange(sampleItem: stepsData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //waterIntakeData
            let scorewaterIntake = getScoreForVitalDataWithGivenDateRange(sampleItem: waterIntakeData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore = scorebodyMassIndex + scoresteps + scorewaterIntake
            arrayDayWiseScoreTotal.append(totalScore)
        }
        
        return arrayDayWiseScoreTotal
    }
    func getMaxVitalsScore() -> Double {
        
        let bodyMassIndex = GastrointestinalVitalRelativeImportance.bodyMassIndex.getConvertedValueFromPercentage()
        let steps = GastrointestinalVitalRelativeImportance.steps.getConvertedValueFromPercentage()
        let waterIntake = GastrointestinalVitalRelativeImportance.waterIntake.getConvertedValueFromPercentage()
        
        
        let totalVitalScore = bodyMassIndex + steps + waterIntake
        
        return totalVitalScore;
    }
    
    //Get recent data for Specific Vitals..
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[VitalsModel]{
        
        arrVital = []
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        //bodyMassIndexData
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: bodyMassIndexData)
        //steps
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: stepsData)
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
            //BMI
        case .BMI:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: bodyMassIndexData)
            //steps
        case .steps:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: stepsData)
            
            //waterIntake
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


