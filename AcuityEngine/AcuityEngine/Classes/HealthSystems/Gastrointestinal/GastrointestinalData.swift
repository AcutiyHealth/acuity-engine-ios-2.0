//
//  GastrointestinalData.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class GastrointestinalData {
    var gastrointestinalVital:GastrointestinalVital = GastrointestinalVital()
    var gastrointestinalCondition:GastrointestinalCondition = GastrointestinalCondition()
    var gastrointestinalSymptoms:GastrointestinalSymptoms = GastrointestinalSymptoms()
    var gastrointestinalLab:GastrointestinalLab = GastrointestinalLab()
    var arrayDayWiseSystemScore:[Double] = []
    var gastrointestinalSystemScore:Double = 0
    var gastrointestinalWeightedSystemScore:Double{
        get{
            getWeightedSystemScore()
        }
    }
    var gastrointestinalRelativeImportance:Double = SystemRelativeImportance.Gastrointestinal
    var maxScore:Double = SystemRelativeImportance.Gastrointestinal
    
    
    func getWeightedSystemScore()->Double{
        print("<--------------------Gastrointestinal------------------>")
        let score = totalSystemScoreWithDays(days: SegmentValueForGraph.OneDay)
        return (score * gastrointestinalRelativeImportance)/100
    }
    
    
    //Total/Final System Score
    func totalSystemScoreWithDays(days:SegmentValueForGraph) -> Double{
        print("<--------------------Gastrointestinal------------------>")
        let arrayDayWiseSystemScore = systemScoreWithDays(days: days)
        //Calculate average system core for 7 days/30 days/3 months
        //Final system score for Cardio
        gastrointestinalSystemScore = commonTotalSystemScoreWithDays(arrayDayWiseSystemScore: arrayDayWiseSystemScore)
        let calculatedScore = gastrointestinalSystemScore
        print("Gastrointestinal calculatedScore",calculatedScore)
        return calculatedScore
    }
    
    //calculate Daywise system score for Gastrointestinal
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
        let totalScoreVitals = gastrointestinalVital.totalVitalsScoreForDays(days: days)
        let totalScoreCondition = gastrointestinalCondition.totalConditionScoreForDays(days: days)
        let totalScoreLab = gastrointestinalLab.totalLabScoreForDays(days: days)
        let totalScoreSymptom = gastrointestinalSymptoms.totalSymptomsScoreForDays(days: days)
        arrayDayWiseTotalScore = commonTotalMetrixScoreWithDays(totalScoreCondition: totalScoreCondition, totalScoreSymptom: totalScoreSymptom, totalScoreVitals: totalScoreVitals, totalScoreLab: totalScoreLab)
        
        return arrayDayWiseTotalScore
    }
    
    
    func maxTotalScore() -> Double{
        let maxScoreVitals = gastrointestinalVital.getMaxVitalsScore()
        let maxConditionData = gastrointestinalCondition.getMaxConditionDataScore()
        let maxLabData = gastrointestinalLab.getMaxLabDataScore()
        let maxsymptomData = gastrointestinalSymptoms.getMaxSymptomDataScore()
        
        let totalMaxScore = maxScoreVitals  + maxConditionData  + maxLabData + maxsymptomData
        
        
        print("totalMaxScore=======\(totalMaxScore) maxScoreVitals===\(maxScoreVitals)  maxConditionData===\(maxConditionData)  maxLabData === \(maxLabData) maxsymptomData===\(maxsymptomData)")
        return totalMaxScore
        
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[String:Any]{
        
        return [MetricsType.Conditions.rawValue:gastrointestinalCondition.dictionaryRepresentation(),MetricsType.Sympotms.rawValue:gastrointestinalSymptoms.dictionaryRepresentation(),MetricsType.LabData.rawValue:gastrointestinalLab.dictionaryRepresentation(),MetricsType.Vitals.rawValue:gastrointestinalVital.dictionaryRepresentation()] as [String : Any]
        
    }
}
