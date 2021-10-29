//
//  NeuroData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class NeuroData {
    var neuroVital:NeuroVital = NeuroVital()
    var neuroCondition:NeuroCondition = NeuroCondition()
    var neuroSymptoms:NeuroSymptoms = NeuroSymptoms()
    var neuroLab:NeuroLab = NeuroLab()
    var arrayDayWiseSystemScore:[Double] = []
    var neuroSystemScore:Double = 0
    var neuroWeightedSystemScore:Double{
        get{
            getWeightedSystemScore()
        }
    }
    var neuroRelativeImportance:Double = SystemRelativeImportance.Nuerological
    var maxScore:Double = SystemRelativeImportance.Nuerological
    
    
    func getWeightedSystemScore()->Double{
        Log.d("<--------------------Neuro------------------>")
        let score = totalSystemScoreWithDays(days: SegmentValueForGraph.OneDay)
        return (score * neuroRelativeImportance)/100
    }
    
    
    //Total/Final System Score
    func totalSystemScoreWithDays(days:SegmentValueForGraph) -> Double{
        Log.d("<--------------------Neuro------------------>")
        let arrayDayWiseSystemScore = systemScoreWithDays(days: days)
        //Calculate average system core for 7 days/30 days/3 months
        //Final system score for Cardio
        neuroSystemScore = commonTotalSystemScoreWithDays(arrayDayWiseSystemScore: arrayDayWiseSystemScore)
        let calculatedScore = neuroSystemScore
        Log.d("Neuro calculatedScore--\(calculatedScore)")
        return calculatedScore
    }
    
    //calculate Daywise system score for Neuro
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
        let totalScoreVitals = neuroVital.totalVitalsScoreForDays(days: days)
        let totalScoreCondition = neuroCondition.totalConditionScoreForDays(days: days)
        let totalScoreLab = neuroLab.totalLabScoreForDays(days: days)
        let totalScoreSymptom = neuroSymptoms.totalSymptomsScoreForDays(days: days)
        arrayDayWiseTotalScore = commonTotalMetrixScoreWithDays(totalScoreCondition: totalScoreCondition, totalScoreSymptom: totalScoreSymptom, totalScoreVitals: totalScoreVitals, totalScoreLab: totalScoreLab)
        
        return arrayDayWiseTotalScore
    }
    
    
    func maxTotalScore() -> Double{
        let maxScoreVitals = neuroVital.getMaxVitalsScore()
        let maxConditionData = neuroCondition.getMaxConditionDataScore()
        let maxLabData = neuroLab.getMaxLabDataScore()
        let maxsymptomData = neuroSymptoms.getMaxSymptomDataScore()
        
        let totalMaxScore = maxScoreVitals  + maxConditionData  + maxLabData + maxsymptomData
        
        
        Log.d("totalMaxScore=======\(totalMaxScore) maxScoreVitals===\(maxScoreVitals)  maxConditionData===\(maxConditionData)  maxLabData === \(maxLabData) maxsymptomData===\(maxsymptomData)")
        return totalMaxScore
        
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[String:Any]{
        
        return [MetricsType.Conditions.rawValue:neuroCondition.dictionaryRepresentation(),MetricsType.Sympotms.rawValue:neuroSymptoms.dictionaryRepresentation(),MetricsType.LabData.rawValue:neuroLab.dictionaryRepresentation(),MetricsType.Vitals.rawValue:neuroVital.dictionaryRepresentation()] as [String : Any]
        
    }
}
