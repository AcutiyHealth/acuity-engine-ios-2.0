//
//  EndocrineData.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class EndocrineData {
    var endocrineVital:EndocrineVital = EndocrineVital()
    var endocrineCondition:EndocrineCondition = EndocrineCondition()
    var endocrineSymptoms:EndocrineSymptoms = EndocrineSymptoms()
    var endocrineLab:EndocrineLab = EndocrineLab()
    var arrayDayWiseSystemScore:[Double] = []
    var endocrineSystemScore:Double = 0
    var endocrineWeightedSystemScore:Double{
        get{
            getWeightedSystemScore()
        }
    }
    var endocrineRelativeImportance:Double = SystemRelativeImportance.Endocrine
    var maxScore:Double = SystemRelativeImportance.Endocrine
    
    
    func getWeightedSystemScore()->Double{
        print("<--------------------Endocrine------------------>")
        let score = totalSystemScoreWithDays(days: SegmentValueForGraph.OneDay)
        return (score * endocrineRelativeImportance)/100
    }
    
    
    //Total/Final System Score
    func totalSystemScoreWithDays(days:SegmentValueForGraph) -> Double{
        print("<--------------------Endocrine------------------>")
        let arrayDayWiseSystemScore = systemScoreWithDays(days: days)
        //Calculate average system core for 7 days/30 days/3 months
        //Final system score for Cardio
        endocrineSystemScore = commonTotalSystemScoreWithDays(arrayDayWiseSystemScore: arrayDayWiseSystemScore)
        let calculatedScore = endocrineSystemScore
        print("Endocrine calculatedScore",calculatedScore)
        return calculatedScore
    }
    
    //calculate Daywise system score for Endocrine
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
        let totalScoreVitals = endocrineVital.totalVitalsScoreForDays(days: days)
        let totalScoreCondition = endocrineCondition.totalConditionScoreForDays(days: days)
        let totalScoreLab = endocrineLab.totalLabScoreForDays(days: days)
        let totalScoreSymptom = endocrineSymptoms.totalSymptomsScoreForDays(days: days)
        arrayDayWiseTotalScore = commonTotalMetrixScoreWithDays(totalScoreCondition: totalScoreCondition, totalScoreSymptom: totalScoreSymptom, totalScoreVitals: totalScoreVitals, totalScoreLab: totalScoreLab)
        
        return arrayDayWiseTotalScore
    }
    
    
    func maxTotalScore() -> Double{
        let maxScoreVitals = endocrineVital.getMaxVitalsScore()
        let maxConditionData = endocrineCondition.getMaxConditionDataScore()
        let maxLabData = endocrineLab.getMaxLabDataScore()
        let maxsymptomData = endocrineSymptoms.getMaxSymptomDataScore()
        
        let totalMaxScore = maxScoreVitals  + maxConditionData  + maxLabData + maxsymptomData
        
        
        print("totalMaxScore=======\(totalMaxScore) maxScoreVitals===\(maxScoreVitals)  maxConditionData===\(maxConditionData)  maxLabData === \(maxLabData) maxsymptomData===\(maxsymptomData)")
        return totalMaxScore
        
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[String:Any]{
        
        return [MetricsType.Conditions.rawValue:endocrineCondition.dictionaryRepresentation(),MetricsType.Sympotms.rawValue:endocrineSymptoms.dictionaryRepresentation(),MetricsType.LabData.rawValue:endocrineLab.dictionaryRepresentation(),MetricsType.Vitals.rawValue:endocrineVital.dictionaryRepresentation()] as [String : Any]
        
    }
}
