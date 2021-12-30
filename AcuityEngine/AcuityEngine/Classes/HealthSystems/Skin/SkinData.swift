//
//  SkinData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class SkinData {
    var skinVital:SkinVital = SkinVital()
    var skinCondition:SkinCondition = SkinCondition()
    var skinSymptoms:SkinSymptoms = SkinSymptoms()
    var skinLab:SkinLab = SkinLab()
    var arrayDayWiseSystemScore:[Double] = []
    var skinSystemScore:Double = 0
    var skinWeightedSystemScore:Double{
        get{
            getWeightedSystemScore()
        }
    }
    var skinRelativeImportance:Double = SystemRelativeImportance.Integumentary
    var maxScore:Double = SystemRelativeImportance.Integumentary
    
    /*
     Below method is used to caculate My well score. My well score need one day/today's data for calculation. So, we use totalSystemScoreWithDays with one day.
     */
    func getWeightedSystemScore()->Double{
        Log.d("<--------------------Skin------------------>")
        let score = totalSystemScoreWithDays(days: SegmentValueForGraph.OneDay)
        return (score * skinRelativeImportance)/100
    }
    
    
    //Total/Final System Score
    func totalSystemScoreWithDays(days:SegmentValueForGraph) -> Double{
        Log.d("<--------------------Skin------------------>")
        let arrayDayWiseSystemScore = systemScoreWithDays(days: days)
        //Calculate average system core for 7 days/30 days/3 months
        //Final system score for Cardio
        skinSystemScore = commonTotalSystemScoreWithDays(arrayDayWiseSystemScore: arrayDayWiseSystemScore)
        let calculatedScore = skinSystemScore
        Log.d("Skin calculatedScore-\(calculatedScore)")
        return calculatedScore
    }
    
    //calculate Daywise system score for Skin
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
        let totalScoreVitals = skinVital.totalVitalsScoreForDays(days: days)
        let totalScoreCondition = skinCondition.totalConditionScoreForDays(days: days)
        let totalScoreLab = skinLab.totalLabScoreForDays(days: days)
        let totalScoreSymptom = skinSymptoms.totalSymptomsScoreForDays(days: days)
        arrayDayWiseTotalScore = commonTotalMetrixScoreWithDays(totalScoreCondition: totalScoreCondition, totalScoreSymptom: totalScoreSymptom, totalScoreVitals: totalScoreVitals, totalScoreLab: totalScoreLab)
        
        return arrayDayWiseTotalScore
    }
    
    
    func maxTotalScore() -> Double{
        let maxScoreVitals = skinVital.getMaxVitalsScore()
        let maxConditionData = skinCondition.getMaxConditionDataScore()
        let maxLabData = skinLab.getMaxLabDataScore()
        let maxsymptomData = skinSymptoms.getMaxSymptomDataScore()
        
        let totalMaxScore = maxScoreVitals  + maxConditionData  + maxLabData + maxsymptomData
        
        
        Log.d("totalMaxScore=======\(totalMaxScore) maxScoreVitals===\(maxScoreVitals)  maxConditionData===\(maxConditionData)  maxLabData === \(maxLabData) maxsymptomData===\(maxsymptomData)")
        return totalMaxScore
        
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[String:Any]{
        
        return [MetricsType.Conditions.rawValue:skinCondition.dictionaryRepresentation(),MetricsType.Sympotms.rawValue:skinSymptoms.dictionaryRepresentation()] as [String : Any]
        
    }
}
