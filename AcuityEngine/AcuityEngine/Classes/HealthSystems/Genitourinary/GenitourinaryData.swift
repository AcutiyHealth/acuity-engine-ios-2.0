//
//  GenitourinaryData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class GenitourinaryData {
    var genitourinaryVital:GenitourinaryVital = GenitourinaryVital()
    var genitourinaryCondition:GenitourinaryCondition = GenitourinaryCondition()
    var genitourinarySymptoms:GenitourinarySymptoms = GenitourinarySymptoms()
    var genitourinaryLab:GenitourinaryLab = GenitourinaryLab()
    var arrayDayWiseSystemScore:[Double] = []
    var genitourinarySystemScore:Double = 0
    var genitourinaryWeightedSystemScore:Double{
        get{
            getWeightedSystemScore()
        }
    }
    var genitourinaryRelativeImportance:Double = SystemRelativeImportance.Genitourinary
    var maxScore:Double = SystemRelativeImportance.Genitourinary
    
    
    func getWeightedSystemScore()->Double{
        Log.d("<--------------------Genitourinary------------------>")
        let score = totalSystemScoreWithDays(days: SegmentValueForGraph.OneDay)
        return (score * genitourinaryRelativeImportance)/100
    }
    
    
    //Total/Final System Score
    func totalSystemScoreWithDays(days:SegmentValueForGraph) -> Double{
        Log.d("<--------------------Genitourinary------------------>")
        let arrayDayWiseSystemScore = systemScoreWithDays(days: days)
        //Calculate average system core for 7 days/30 days/3 months
        //Final system score for Cardio
        genitourinarySystemScore = commonTotalSystemScoreWithDays(arrayDayWiseSystemScore: arrayDayWiseSystemScore)
        let calculatedScore = genitourinarySystemScore
        Log.d("Genitourinary calculatedScore--\(calculatedScore)")
        return calculatedScore
    }
    
    //calculate Daywise system score for Genitourinary
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
        let totalScoreVitals = genitourinaryVital.totalVitalsScoreForDays(days: days)
        let totalScoreCondition = genitourinaryCondition.totalConditionScoreForDays(days: days)
        let totalScoreLab = genitourinaryLab.totalLabScoreForDays(days: days)
        let totalScoreSymptom = genitourinarySymptoms.totalSymptomsScoreForDays(days: days)
        arrayDayWiseTotalScore = commonTotalMetrixScoreWithDays(totalScoreCondition: totalScoreCondition, totalScoreSymptom: totalScoreSymptom, totalScoreVitals: totalScoreVitals, totalScoreLab: totalScoreLab)
        
        return arrayDayWiseTotalScore
    }
    
    
    func maxTotalScore() -> Double{
        let maxScoreVitals = genitourinaryVital.getMaxVitalsScore()
        let maxConditionData = genitourinaryCondition.getMaxConditionDataScore()
        let maxLabData = genitourinaryLab.getMaxLabDataScore()
        let maxsymptomData = genitourinarySymptoms.getMaxSymptomDataScore()
        
        let totalMaxScore = maxScoreVitals  + maxConditionData  + maxLabData + maxsymptomData
        
        
        //Log.d("totalMaxScore=======\(totalMaxScore) maxScoreVitals===\(maxScoreVitals)  maxConditionData===\(maxConditionData)  maxLabData === \(maxLabData) maxsymptomData===\(maxsymptomData)")
        return totalMaxScore
        
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[String:Any]{
        
        return [MetricsType.Conditions.rawValue:genitourinaryCondition.dictionaryRepresentation(),MetricsType.Sympotms.rawValue:genitourinarySymptoms.dictionaryRepresentation()] as [String : Any]
        
    }
}
