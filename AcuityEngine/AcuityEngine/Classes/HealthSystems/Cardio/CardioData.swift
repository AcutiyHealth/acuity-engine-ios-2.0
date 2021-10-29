//
//  CardioData.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class CardioData:SystemDataProtocol {
    var cardioVital:CardioVital = CardioVital()
    var cardioCondition:CardioCondition = CardioCondition()
    var cardioSymptoms:CardioSymptoms = CardioSymptoms()
    var cardioLab:CardioLab = CardioLab()
    var arrayDayWiseSystemScore:[Double] = []
    var cardioSystemScore:Double = 0
    var cardioWeightedSystemScore:Double{
        get{
            getWeightedSystemScore()
        }
    }
    
    var weightedSystemScore:Double  = 0
    var cardioRelativeImportance:Double = SystemRelativeImportance.Cardiovascular
    var maxScore:Double = SystemRelativeImportance.Cardiovascular
    
    func getWeightedSystemScore()->Double{
        let score = totalSystemScoreWithDays(days: SegmentValueForGraph.OneDay)
        return (score * cardioRelativeImportance)/100
    }
    
    
    //Total/Final System Score
    func totalSystemScoreWithDays(days:SegmentValueForGraph) -> Double{
        Log.d("<--------------------Cardio------------------>")
        let arrayDayWiseSystemScore = systemScoreWithDays(days: days)
        //Calculate average system core for 7 days/30 days/3 months
        //Final system score for Cardio
        cardioSystemScore = commonTotalSystemScoreWithDays(arrayDayWiseSystemScore: arrayDayWiseSystemScore)
        let calculatedScore = cardioSystemScore
        Log.d("calculatedScore--\(calculatedScore)")
        return calculatedScore
    }
    
    //calculate Daywise system score for Cardio
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
    
    //2nd Step
    //Get total score
    /*
     Get all Conditions metric total scrore which gets by value of metrix apply to calculation(which is sum of all conditions metrics)
     Get all Symptoms metric total scrore which gets by value of metrix apply to calculation(which is sum of all symptoms metrics)
     Get all vitals metric total scrore which gets by value of metrix apply to calculation(which is sum of all vitals metrics)
     Get all Labs metric total scrore which gets by value of metrix apply to calculatione(which is sum of all Labs metrics)
     
     Finally, Do sum of all 4 systems's total score
     
     */
    //Metrix total score
    func totalMetrixScoreWithDays(days:SegmentValueForGraph) -> [Double]{
        var arrayDayWiseTotalScore:[Double] = []
        let totalScoreVitals = cardioVital.totalVitalsScoreForDays(days: days)
        let totalScoreCondition = cardioCondition.totalConditionScoreForDays(days: days)
        let totalScoreLab = cardioLab.totalLabScoreForDays(days: days)
        let totalScoreSymptom = cardioSymptoms.totalSymptomsScoreForDays(days: days)
        
        arrayDayWiseTotalScore = commonTotalMetrixScoreWithDays(totalScoreCondition: totalScoreCondition, totalScoreSymptom: totalScoreSymptom, totalScoreVitals: totalScoreVitals, totalScoreLab: totalScoreLab)
        
        return arrayDayWiseTotalScore
    }
    //1st Step
    //Get Max total score
    /*
     Get all Conditions metric Max scrore(which is sum of all conditions metrics)
     Get all Symptoms metric Max scrore(which is sum of all symptoms metrics)
     Get all vitals metric Max scrore(which is sum of all vitals metrics)
     Get all Labs metric Max scrore(which is sum of all Labs metrics)
     
     Finally, Do sum of all 4 systems's max score
     */
    func maxTotalScore() -> Double{
        let maxScoreVitals = cardioVital.getMaxVitalsScore()
        let maxConditionData = cardioCondition.getMaxConditionDataScore()
        let maxLabData = cardioLab.getMaxLabDataScore()
        let maxsymptomData = cardioSymptoms.getMaxSymptomDataScore() 
        
        let totalMaxScore = maxScoreVitals  + maxConditionData  + maxLabData + maxsymptomData
        
        Log.d("totalMaxScore=======\(totalMaxScore) maxScoreVitals===\(maxScoreVitals)  maxConditionData===\(maxConditionData)  maxLabData === \(maxLabData) maxsymptomData===\(maxsymptomData)")
        return totalMaxScore
        
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[String:Any]{
        return [MetricsType.Conditions.rawValue:cardioCondition.dictionaryRepresentation(),MetricsType.Sympotms.rawValue:cardioSymptoms.dictionaryRepresentation(),MetricsType.LabData.rawValue:cardioLab.dictionaryRepresentation(),MetricsType.Vitals.rawValue:cardioVital.dictionaryRepresentation()] as [String : Any]
        
    }
}
