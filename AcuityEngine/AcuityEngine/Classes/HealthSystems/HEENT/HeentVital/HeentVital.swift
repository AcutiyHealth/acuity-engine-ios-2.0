//
//  HeentVitals.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class HeentVital:VitalProtocol {
    /*/*
     Headphone Audio Levels
     Temperature
     Oxygen saturation
     Inhaler usage (times/day)
     */*/
    
    var headphoneAudioLevelsData:[HeentVitalsData] = []
    var temperatureData:[HeentVitalsData] = []
    var oxygenSaturationData:[HeentVitalsData] = []
    var inhalerUsageData:[HeentVitalsData] = []
    
    var totalScore:[Double] = []
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    private var arrVital:[VitalsModel] = []
    
    func totalVitalsScore() -> Double {
        
        let headphoneAudioLevels = (Double(headphoneAudioLevelsData.average(\.score)) .isNaN ? 0 : Double(headphoneAudioLevelsData.average(\.score)))
        let temperature = (Double(temperatureData.average(\.score)) .isNaN ? 0 : Double(temperatureData.average(\.score)))
        let oxygenSaturation = (Double(oxygenSaturationData.average(\.score)) .isNaN ? 0 : Double(oxygenSaturationData.average(\.score)))
        let inhalerUsage = (Double(inhalerUsageData.average(\.score)) .isNaN ? 0 : Double(inhalerUsageData.average(\.score)))
        
        let totalVitalScore = headphoneAudioLevels + temperature + oxygenSaturation + inhalerUsage;
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
            
            //headphoneAudioLevelsData
            let scoreheadphoneAudioLevels = getScoreForVitalDataWithGivenDateRange(sampleItem: headphoneAudioLevelsData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //temperatureData
            let scoretemperature = getScoreForVitalDataWithGivenDateRange(sampleItem: temperatureData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //oxygenSaturation
            let scoreoxygenSaturation = getScoreForVitalDataWithGivenDateRange(sampleItem: oxygenSaturationData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            //inhalerUsage
            let scoreinhalerUsage = getScoreForVitalDataWithGivenDateRange(sampleItem: inhalerUsageData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
        
            let totalScore = scoreheadphoneAudioLevels + scoretemperature + scoreoxygenSaturation + scoreinhalerUsage
            arrayDayWiseScoreTotal.append(totalScore)
        }
        
        return arrayDayWiseScoreTotal
    }
    func getMaxVitalsScore() -> Double {
        
        //temperature
        let temperature = HeentVitalRelativeImportance.temperature.getConvertedValueFromPercentage()
        //headPhoneAudioLevel
        let headPhoneAudioLevel = HeentVitalRelativeImportance.headPhoneAudioLevel.getConvertedValueFromPercentage()
        //oxygenSaturation
        let oxygenSaturation = HeentVitalRelativeImportance.oxygenSaturation.getConvertedValueFromPercentage()
        //InhalerUsage
        let inhalerUsage = HeentVitalRelativeImportance.InhalerUsage.getConvertedValueFromPercentage()
        
        let totalVitalScore =  temperature + headPhoneAudioLevel + oxygenSaturation + inhalerUsage
        
        return totalVitalScore;
    }
    
    //Get recent data for Specific Vitals..
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[VitalsModel]{
        
        arrVital = []
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        
        //headphoneAudioLevels
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: headphoneAudioLevelsData)
        
        //temperature
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: temperatureData)
        
        //oxygenSaturation
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: oxygenSaturationData)
        
        //inhalerUsage
        filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: inhalerUsageData)
        
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
        
        //headPhoneAudioLevel
        case .headPhoneAudioLevel:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: headphoneAudioLevelsData)
            
        //temperatureData
        case .temperature:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: temperatureData)
            
        //oxygenSaturation
        case .oxygenSaturation:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: oxygenSaturationData)
            
        //InhalerUsage
        case .InhalerUsage:
            filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: inhalerUsageData)
            
        default:
            break
        }
        for item in filterArray{
            arrVital.append(saveVitalsInArray(item: item))
        }
        return arrVital
    }
}


