//
//  RenalData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 05/02/21.
//

import UIKit

class RenalData {
    var renalVital:RenalVital = RenalVital()
    var renalCondition:RenalCondition = RenalCondition()
    var renalSymptoms:RenalSymptoms = RenalSymptoms()
    var renalLab:RenalLab = RenalLab()
    var arrayDayWiseSystemScore:[Double] = []
    var renalSystemScore:Double = 0
    var renalWeightedSystemScore:Double{
        get{
            getWeightedSystemScore()
        }
    }
    var renalRelativeImportance:Double = SystemRelativeImportance.Renal
    var maxScore:Double = SystemRelativeImportance.Renal
    
    
    func getWeightedSystemScore()->Double{
        Log.d("<--------------------Renal------------------>")
        let score = totalSystemScoreWithDays(days: SegmentValueForGraph.OneDay)
        return (score * renalRelativeImportance)/100
    }
    
    
    //Total/Final System Score
    func totalSystemScoreWithDays(days:SegmentValueForGraph) -> Double{
        Log.d("<--------------------Renal------------------>")
        let arrayDayWiseSystemScore = systemScoreWithDays(days: days)
        //Calculate average system core for 7 days/30 days/3 months
        //Final system score for Cardio
        renalSystemScore = commonTotalSystemScoreWithDays(arrayDayWiseSystemScore: arrayDayWiseSystemScore)
        let calculatedScore = renalSystemScore
        Log.d("Renal calculatedScore--\(calculatedScore)")
        return calculatedScore
    }
    
    //calculate Daywise system score for Renal
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
        let totalScoreVitals = renalVital.totalVitalsScoreForDays(days: days)
        let totalScoreCondition = renalCondition.totalConditionScoreForDays(days: days)
        let totalScoreLab = renalLab.totalLabScoreForDays(days: days)
        let totalScoreSymptom = renalSymptoms.totalSymptomsScoreForDays(days: days)
        arrayDayWiseTotalScore = commonTotalMetrixScoreWithDays(totalScoreCondition: totalScoreCondition, totalScoreSymptom: totalScoreSymptom, totalScoreVitals: totalScoreVitals, totalScoreLab: totalScoreLab)
        
        return arrayDayWiseTotalScore
    }
    
    
    func maxTotalScore() -> Double{
        let maxScoreVitals = renalVital.getMaxVitalsScore()
        let maxConditionData = renalCondition.getMaxConditionDataScore()
        let maxLabData = renalLab.getMaxLabDataScore()
        let maxsymptomData = renalSymptoms.getMaxSymptomDataScore()
        
        let totalMaxScore = maxScoreVitals  + maxConditionData  + maxLabData + maxsymptomData
        
        
        Log.d("totalMaxScore=======\(totalMaxScore) maxScoreVitals===\(maxScoreVitals)  maxConditionData===\(maxConditionData)  maxLabData === \(maxLabData) maxsymptomData===\(maxsymptomData)")
        return totalMaxScore
        
    }
   
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[String:Any]{
        
        return [MetricsType.Conditions.rawValue:renalCondition.dictionaryRepresentation(),
                MetricsType.Sympotms.rawValue:renalSymptoms.dictionaryRepresentation(),
                MetricsType.LabData.rawValue:renalLab.dictionaryRepresentation(),
                MetricsType.Vitals.rawValue:renalVital.dictionaryRepresentation()] as [String : Any]
        
    }
}
