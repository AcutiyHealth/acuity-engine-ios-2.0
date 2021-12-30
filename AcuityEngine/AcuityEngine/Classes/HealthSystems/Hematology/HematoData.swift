//
//  HematoData.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class HematoData {
    var hematoVital:HematoVital = HematoVital()
    var hematoCondition:HematoCondition = HematoCondition()
    var hematoSymptoms:HematoSymptoms = HematoSymptoms()
    var hematoLab:HematoLab = HematoLab()
    var arrayDayWiseSystemScore:[Double] = []
    var hematoSystemScore:Double = 0
    var hematoWeightedSystemScore:Double{
        get{
            getWeightedSystemScore()
        }
    }
    var hematoRelativeImportance:Double = SystemRelativeImportance.Hematology
    var maxScore:Double = SystemRelativeImportance.Hematology
    
    
    func getWeightedSystemScore()->Double{
        Log.d("<--------------------Hemato------------------>")
        let score = totalSystemScoreWithDays(days: SegmentValueForGraph.OneDay)
        return (score * hematoRelativeImportance)/100
    }
    
    
    //Total/Final System Score
    func totalSystemScoreWithDays(days:SegmentValueForGraph) -> Double{
        Log.d("<--------------------Hemato------------------>")
        let arrayDayWiseSystemScore = systemScoreWithDays(days: days)
        //Calculate average system core for 7 days/30 days/3 months
        //Final system score for Cardio
        hematoSystemScore = commonTotalSystemScoreWithDays(arrayDayWiseSystemScore: arrayDayWiseSystemScore)
        let calculatedScore = hematoSystemScore
        Log.d("Hemato calculatedScore--\(calculatedScore)")
        return calculatedScore
    }
    
    //calculate Daywise system score for Hemato
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
        let totalScoreVitals = hematoVital.totalVitalsScoreForDays(days: days)
        let totalScoreCondition = hematoCondition.totalConditionScoreForDays(days: days)
        let totalScoreLab = hematoLab.totalLabScoreForDays(days: days)
        let totalScoreSymptom = hematoSymptoms.totalSymptomsScoreForDays(days: days)
        arrayDayWiseTotalScore = commonTotalMetrixScoreWithDays(totalScoreCondition: totalScoreCondition, totalScoreSymptom: totalScoreSymptom, totalScoreVitals: totalScoreVitals, totalScoreLab: totalScoreLab)
        
        return arrayDayWiseTotalScore
    }
    
    
    func maxTotalScore() -> Double{
        let maxScoreVitals = hematoVital.getMaxVitalsScore()
        let maxConditionData = hematoCondition.getMaxConditionDataScore()
        let maxLabData = hematoLab.getMaxLabDataScore()
        let maxsymptomData = hematoSymptoms.getMaxSymptomDataScore()
        
        let totalMaxScore = maxScoreVitals  + maxConditionData  + maxLabData + maxsymptomData
        
        
        print("totalMaxScore=======\(totalMaxScore) maxScoreVitals===\(maxScoreVitals)  maxConditionData===\(maxConditionData)  maxLabData === \(maxLabData) maxsymptomData===\(maxsymptomData)")
        return totalMaxScore
        
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[String:Any]{
        
        return [MetricsType.Conditions.rawValue:hematoCondition.dictionaryRepresentation(),MetricsType.Sympotms.rawValue:hematoSymptoms.dictionaryRepresentation()] as [String : Any]
        
    }
}
