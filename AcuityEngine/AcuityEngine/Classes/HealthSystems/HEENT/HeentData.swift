//
//  HeentData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class HeentData {
    var heentVital:HeentVital = HeentVital()
    var heentCondition:HeentCondition = HeentCondition()
    var heentSymptoms:HeentSymptoms = HeentSymptoms()
    var heentLab:HeentLab = HeentLab()
    var arrayDayWiseSystemScore:[Double] = []
    var heentSystemScore:Double = 0
    var heentWeightedSystemScore:Double{
        get{
            getWeightedSystemScore()
        }
    }
    var heentRelativeImportance:Double = SystemRelativeImportance.Heent
    var maxScore:Double = SystemRelativeImportance.Heent
    
    /*
     Below method is used to caculate My well score. My well score need one day/today's data for calculation. So, we use totalSystemScoreWithDays with one day.
     */
    func getWeightedSystemScore()->Double{
        Log.d("<--------------------Heent------------------>")
        let score = totalSystemScoreWithDays(days: SegmentValueForGraph.OneDay)
        return (score * heentRelativeImportance)/100
    }
    
    
    //Total/Final System Score
    func totalSystemScoreWithDays(days:SegmentValueForGraph) -> Double{
        Log.d("<--------------------Heent------------------>")
        let arrayDayWiseSystemScore = systemScoreWithDays(days: days)
        //Calculate average system core for 7 days/30 days/3 months
        //Final system score for Cardio
        heentSystemScore = commonTotalSystemScoreWithDays(arrayDayWiseSystemScore: arrayDayWiseSystemScore)
        let calculatedScore = heentSystemScore
        Log.d("Heent calculatedScore-\(calculatedScore)")
        return calculatedScore
    }
    
    //calculate Daywise system score for Heent
    func systemScoreWithDays(days:SegmentValueForGraph)->[Double]{
        arrayDayWiseSystemScore = []
        let arrayFraction = abnormalFractionWithDays(days: days)
        arrayDayWiseSystemScore = commonSystemScoreWithDays(arrayFraction: arrayFraction)
        
        return arrayDayWiseSystemScore
    }
    
    //Fraction of Score to calculate System score
    func abnormalFractionWithDays(days:SegmentValueForGraph)->[Double]{
        let arrayDayWiseTotalScore = totalMetrixScoreWithDays(days: days)
        var arrayFraction:[Double] = []
        let maxScore = maxTotalScore()
        arrayFraction = commonAbnormalFractionWithDays(arrayDayWiseTotalScore: arrayDayWiseTotalScore, maxTotalScore: maxScore)
        return arrayFraction
    }
    
    
    //Metrix total score
    func totalMetrixScoreWithDays(days:SegmentValueForGraph) -> [Double]{
        var arrayDayWiseTotalScore:[Double] = []
        let totalScoreVitals = heentVital.totalVitalsScoreForDays(days: days)
        let totalScoreCondition = heentCondition.totalConditionScoreForDays(days: days)
        let totalScoreLab = heentLab.totalLabScoreForDays(days: days)
        let totalScoreSymptom = heentSymptoms.totalSymptomsScoreForDays(days: days)
        arrayDayWiseTotalScore = commonTotalMetrixScoreWithDays(totalScoreCondition: totalScoreCondition, totalScoreSymptom: totalScoreSymptom, totalScoreVitals: totalScoreVitals, totalScoreLab: totalScoreLab)
        
        return arrayDayWiseTotalScore
    }
    
    
    func maxTotalScore() -> Double{
        let maxScoreVitals = heentVital.getMaxVitalsScore()
        let maxConditionData = heentCondition.getMaxConditionDataScore()
        let maxLabData = heentLab.getMaxLabDataScore()
        let maxsymptomData = heentSymptoms.getMaxSymptomDataScore()
        
        let totalMaxScore = maxScoreVitals  + maxConditionData  + maxLabData + maxsymptomData
        
        
        Log.d("totalMaxScore=======\(totalMaxScore) maxScoreVitals===\(maxScoreVitals)  maxConditionData===\(maxConditionData)  maxLabData === \(maxLabData) maxsymptomData===\(maxsymptomData)")
        return totalMaxScore
        
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[String:Any]{
        
        return [MetricsType.Conditions.rawValue:heentCondition.dictionaryRepresentation(),MetricsType.Sympotms.rawValue:heentSymptoms.dictionaryRepresentation(),MetricsType.LabData.rawValue:heentLab.dictionaryRepresentation(),MetricsType.Vitals.rawValue:heentVital.dictionaryRepresentation()] as [String : Any]
        
    }
}
