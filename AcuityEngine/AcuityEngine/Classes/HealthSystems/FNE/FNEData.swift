//
//  FNEData.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class FNEData {
    var fneVital:FNEVital = FNEVital()
    var fneCondition:FNECondition = FNECondition()
    var fneSymptoms:FNESymptoms = FNESymptoms()
    var fneLab:FNELab = FNELab()
    var arrayDayWiseSystemScore:[Double] = []
    var fneSystemScore:Double = 0
    var fneWeightedSystemScore:Double{
        get{
            getWeightedSystemScore()
        }
    }
    var fneRelativeImportance:Double = 100
    var maxScore:Double = 100
    
    
    func getWeightedSystemScore()->Double{
        print("<--------------------FNE------------------>")
        let score = totalSystemScoreWithDays(days: SegmentValueForGraph.OneDay)
        return (score * fneRelativeImportance)/100
    }
    
    
    //Total/Final System Score
    func totalSystemScoreWithDays(days:SegmentValueForGraph) -> Double{
        print("<--------------------FNE------------------>")
        let arrayDayWiseSystemScore = systemScoreWithDays(days: days)
        //Calculate average system core for 7 days/30 days/3 months
        //Final system score for Cardio
        fneSystemScore = commonTotalSystemScoreWithDays(arrayDayWiseSystemScore: arrayDayWiseSystemScore)
        let calculatedScore = fneSystemScore
        print("FNE calculatedScore",calculatedScore)
        return calculatedScore
    }
    
    //calculate Daywise system score for FNE
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
        let totalScoreVitals = fneVital.totalVitalsScoreForDays(days: days)
        let totalScoreCondition = fneCondition.totalConditionScoreForDays(days: days)
        let totalScoreLab = fneLab.totalLabScoreForDays(days: days)
        let totalScoreSymptom = fneSymptoms.totalSymptomsScoreForDays(days: days)
        arrayDayWiseTotalScore = commonTotalMetrixScoreWithDays(totalScoreCondition: totalScoreCondition, totalScoreSymptom: totalScoreSymptom, totalScoreVitals: totalScoreVitals, totalScoreLab: totalScoreLab)
        
        return arrayDayWiseTotalScore
    }
    
    
    func maxTotalScore() -> Double{
        let maxScoreVitals = fneVital.getMaxVitalsScore()
        let maxConditionData = fneCondition.getMaxConditionDataScore()
        let maxLabData = fneLab.getMaxLabDataScore()
        let maxsymptomData = fneSymptoms.getMaxSymptomDataScore()
        
        let totalMaxScore = maxScoreVitals  + maxConditionData  + maxLabData + maxsymptomData
        
        
        print("totalMaxScore=======\(totalMaxScore) maxScoreVitals===\(maxScoreVitals)  maxConditionData===\(maxConditionData)  maxLabData === \(maxLabData) maxsymptomData===\(maxsymptomData)")
        return totalMaxScore
        
    }
   
    func dictionaryRepresentation()->[String:Any]{
        
        return [MetricsType.Conditions.rawValue:fneCondition.dictionaryRepresentation(),MetricsType.Sympotms.rawValue:fneSymptoms.dictionaryRepresentation(),MetricsType.LabData.rawValue:fneLab.dictionaryRepresentation(),MetricsType.Vitals.rawValue:fneVital.dictionaryRepresentation()] as [String : Any]
        
    }
}
