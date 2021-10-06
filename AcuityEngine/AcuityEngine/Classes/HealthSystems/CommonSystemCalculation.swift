//
//  CommonSystemCalculation.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 08/04/21.
//

import Foundation


//Total/Final System Score
func commonTotalSystemScoreWithDays(arrayDayWiseSystemScore:[Double]) -> Double{
    
    //print("arrayDayWiseSystemScore",arrayDayWiseSystemScore)
    //Calculate average system core for 1 day 7 days/30 days/3 months
    /*
     For 1 day, It will calculate MyWell score for Wheel....
     
     Below it's doing avarage for 7 days, 1month or 3 month score to show in pullup.
     For 7 days = [1 days score, 2nd day score, 3rd day score, 4th day score, 5th day score, 6th, 7th day score]
     E.g. [75,100,80,100,100,100]. Final score will average of 7 entry.
     
     For 1 month, calculate number of week. Ex. 1month has 4 week so array will have 4 entry
     E.g. [80,100,90] Final score will average of 4/5 entry.
     
     For 3 month, array will have 3 entry for every month..
     Eg. [100(1st month score),90(2nd month score),80(3rd month score)] Final score will average of 3 entry.
     */
    let calculatedScore = arrayDayWiseSystemScore.average()
    return calculatedScore
}
//calculate system score for Cardio
func commonSystemScoreWithDays(arrayFraction:[Double])->[Double]{
    var arrayDayWiseSystemScore:[Double] = []
    /*
     For 1 day, It will calculate MyWell score for Wheel....
     
    
     Below it's generate array of score for 7 days, 1month or 3 month to show in pullup.
     For 7 days = [1 days score, 2nd day score, 3rd day score, 4th day score, 5th day score, 6th, 7th day score]
     E.g. [75,100,80,100,100,100].
     
     For 1 month, calculate number of week. Ex. 1month has 4 week so array will have 4 entry
     E.g. [80,100,90]
     
     For 3 month, array will have 3 entry for every month..
     Eg. [100(1st month score),90(2nd month score),80(3rd month score)]
     */
    
    if arrayFraction.count > 0 {
        for i in 0...arrayFraction.count-1{
            let score = arrayFraction[i]
            let systemScore = (1-score)*100
            arrayDayWiseSystemScore.append(systemScore)
        }
    }
    //print("arrayDayWiseSystemScore",arrayDayWiseSystemScore)
    return arrayDayWiseSystemScore
}

//Fraction of Score to calculate System score
func commonAbnormalFractionWithDays(arrayDayWiseTotalScore:[Double],maxTotalScore:Double)->[Double]{
    
    //print("arrayDayWiseTotalScore",arrayDayWiseTotalScore)
    var arrayFraction:[Double] = []
    /*
     For 1 day, It will calculate MyWell score for Wheel....
     
     Below it's generate array of abnormal fraction for 7 days, 1month or 3 month by dividing totalScore with maxTotalScore  to show in pullup.
     For 7 days = [1 days score, 2nd day score, 3rd day score, 4th day score, 5th day score, 6th, 7th day score]
     E.g. [0.75,1,0.8,1,1,1].
     
     For 1 month, calculate number of week. Ex. 1month has 4 week so array will have 4 entry
     E.g. [0.75,1,0.8].
     
     For 3 month, array will have 3 entry for every month..
     Eg. [1(1st month score),0.9(2nd month score),0.8(3rd month score)]
     */
    if arrayDayWiseTotalScore.count > 0 {
        for i in 0...arrayDayWiseTotalScore.count-1{
            let totalScore = arrayDayWiseTotalScore[i]
            let fraction = totalScore/maxTotalScore
            arrayFraction.append(fraction)
        }
    }
    return arrayFraction
}


//Metrix total score
func commonTotalMetrixScoreWithDays(totalScoreCondition:[Double],totalScoreSymptom:[Double],totalScoreVitals:[Double],totalScoreLab:[Double]) -> [Double]{
    
    /*
     For 1 day, It will calculate MyWell score for Wheel....
     
     Below is logic for adding score from all metrics of Vital,symptoms,lab and conditions..
     Each array for Vital,symptoms,lab and conditions will have number of entry based upon 7 days, 1 month and 3 month  to show in pullup..
     all metrics score will be sum up and store in array...
     totalScoreVitals,totalScoreSymptom,totalScoreCondition and totalScoreLab willl have number of entries for each metric score based on 7 days, 1 month and 3 month 
     */
    var arrayDayWiseTotalScore:[Double] = []
    //compare that all totalScore array have same number of entries...
    if totalScoreVitals.count == totalScoreSymptom.count,totalScoreCondition.count == totalScoreLab.count && totalScoreVitals.count>0,totalScoreCondition.count>0{
        /*print("commonTotalMetrixScoreWithDays totalScoreSymptom",totalScoreSymptom)
        print("commonTotalMetrixScoreWithDays totalScoreVitals",totalScoreVitals)
        print("commonTotalMetrixScoreWithDays totalScoreLab",totalScoreLab)
        print("commonTotalMetrixScoreWithDays totalScoreCondition",totalScoreCondition)*/
        for i in 0...totalScoreVitals.count - 1{
            
            let totalScore1 = totalScoreVitals[i] + totalScoreCondition[i]
            let totalScore2 =  totalScoreLab[i] + totalScoreSymptom[i]
            let totalScore = totalScore1 + totalScore2
            
            arrayDayWiseTotalScore.append(totalScore)
        }
    }
    
    return arrayDayWiseTotalScore
}

//MARK: Create or Get Vital Models..
func getVitalModel(item:VitalCalculation)->VitalsModel{
    let impData =  VitalsModel(title: item.title.rawValue, value: String(format: "%.2f", item.value))
    impData.color = item.getUIColorFromCalculatedValue()
    return impData
}
//MARK: Create or Get Lab Models..
func getLabModel(item:LabCalculation)->LabModel{
    let impData =  LabModel(title: item.metricType.rawValue, value: String(format: "%.2f", item.value))
    impData.color = item.getUIColorFromCalculatedValue()
    return impData
}
//MARK: Create or Get Conditions Models..
func getConditionsModel(condition:ConditionCalculation)->ConditionsModel{
    let conditionValue = condition.calculatedValue < 0 ? 0 : condition.calculatedValue
    let conditionsModel = ConditionsModel(title: condition.type.rawValue, value: ConditionValue(rawValue: conditionValue)!)
    conditionsModel.startTime = condition.startTimeStamp
    return conditionsModel
}
//MARK: Create or Get Symptoms Models..
func getSymptomsModel(symptom:SymptomCalculation)->SymptomsModel{
    return SymptomsModel(title: symptom.title, value: symptom.getSymptomsValue())
}
//MARK: saveVitalsInArray
func saveVitalsInArray(item:VitalCalculation)->VitalsModel{
    let impData =  VitalsModel(title: item.title.rawValue, value: String(format: "%.2f", item.value))
    impData.startTime = item.startTimeStamp
    impData.color = item.getUIColorFromCalculatedValue()
    return impData
}

//MARK: saveLabsInArray
func saveLabsInArray(item:LabCalculation)->LabModel{
    let impData =  LabModel(title: item.metricType.rawValue, value: String(format: "%.2f", item.value))
    impData.startTime = item.startTimeStamp
    impData.color = item.getUIColorFromCalculatedValue()
    return impData
}

func filterVitalArrayWithSelectedSegmentInGraph(days:SegmentValueForGraph,array:[VitalCalculation])->[VitalCalculation]{
    let now = MyWellScore.sharedManager.todaysDate
    
    let timeIntervalByLastMonth:Double = getTimeIntervalBySelectedSegmentOfDays(days: days)
    let timeIntervalByNow:Double = now.timeIntervalSince1970
    var filteredArray:[VitalCalculation] = []
    
    filteredArray = array.filter { item in
        filterMatricsForVitalOrLab(sampleItem: item, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
    }
    
    return filteredArray
}
func combineBPSystolicAndDiastolic(arraySystolic:[VitalCalculation],arrayDiastolic:[VitalCalculation])->[VitalsModel]{
    var arrayVitalBPModel:[VitalsModel] = []
    for modelSystolic in arraySystolic {
      let filterDiastolicArray = arrayDiastolic.filter { (modelDiastolic)  in
            return modelDiastolic.startTimeStamp == modelSystolic.startTimeStamp
        }
        var diastolicValue:Double = 0
        var diastolicColor = UIColor.clear
        if filterDiastolicArray.count>0{
            let item = filterDiastolicArray[0]
            diastolicValue = item.value
            diastolicColor = item.getUIColorFromCalculatedValue()
        }
        
        let newVitalModel = VitalsModel(title: VitalsName.bloodPressureSystolicDiastolic.rawValue, value: String(format: "%.2f", modelSystolic.value) , isBPModel: true, valueForDiastolic: String(format: "%.2f", diastolicValue), colorForDiastolic: diastolicColor)
        newVitalModel.startTime = modelSystolic.startTimeStamp
        newVitalModel.endTime = modelSystolic.endTimeStamp
        arrayVitalBPModel.append(newVitalModel)
    }
    
    return arrayVitalBPModel;
}
func filterSymptomsArrayWithSelectedSegmentInGraph(days:SegmentValueForGraph,array:[SymptomCalculation])->[SymptomCalculation]{
    let now = MyWellScore.sharedManager.todaysDate
    
    let timeIntervalByLastMonth:Double = getTimeIntervalBySelectedSegmentOfDays(days: days)
    let timeIntervalByNow:Double = now.timeIntervalSince1970
    var filteredArray:[SymptomCalculation] = []
    
    filteredArray = array.filter { item in
        filterMatricsForSymptoms(sampleItem: item, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
    }
    
    return filteredArray
}

func filterLabArrayWithSelectedSegmentInGraph(days:SegmentValueForGraph,array:[LabCalculation])->[LabCalculation]{
    let now = MyWellScore.sharedManager.todaysDate
    
    let timeIntervalByLastMonth:Double = getTimeIntervalBySelectedSegmentOfDays(days: days)
    let timeIntervalByNow:Double = now.timeIntervalSince1970
    var filteredArray:[LabCalculation] = []
    
    filteredArray = array.filter { item in
        filterMatricsForVitalOrLab(sampleItem: item, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
    }
    
    return filteredArray
}

