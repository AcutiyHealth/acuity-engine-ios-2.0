//
//  IDiseaseData.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class IDiseaseData {
    var iDiseaseVital:IDiseaseVital = IDiseaseVital()
    var iDiseaseCondition:IDiseaseCondition = IDiseaseCondition()
    var iDiseaseSymptoms:IDiseaseSymptoms = IDiseaseSymptoms()
    var iDiseaseLab:IDiseaseLab = IDiseaseLab()
    var arrayDayWiseSystemScore:[Double] = []
    var iDiseaseSystemScore:Double = 0
    var iDiseaseWeightedSystemScore:Double{
        get{
            getWeightedSystemScore()
        }
    }
    var iDiseaseRelativeImportance:Double = 100
    var maxScore:Double = 100
    
    
    func getWeightedSystemScore()->Double{
        print("<--------------------IDisease------------------>")
        let score = totalSystemScoreWithDays(days: SegmentValueForGraph.OneDay)
        return (score * iDiseaseRelativeImportance)/100
    }
    
    
    //Total/Final System Score
    func totalSystemScoreWithDays(days:SegmentValueForGraph) -> Double{
        print("<--------------------IDisease------------------>")
        let arrayDayWiseSystemScore = systemScoreWithDays(days: days)
        //Calculate average system core for 7 days/30 days/3 months
        //Final system score for Cardio
        iDiseaseSystemScore = commonTotalSystemScoreWithDays(arrayDayWiseSystemScore: arrayDayWiseSystemScore)
        let calculatedScore = iDiseaseSystemScore
        print("IDisease calculatedScore",calculatedScore)
        return calculatedScore
    }
    
    //calculate Daywise system score for IDisease
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
        let totalScoreVitals = iDiseaseVital.totalVitalsScoreForDays(days: days)
        let totalScoreCondition = iDiseaseCondition.totalConditionScoreForDays(days: days)
        let totalScoreLab = iDiseaseLab.totalLabScoreForDays(days: days)
        let totalScoreSymptom = iDiseaseSymptoms.totalSymptomsScoreForDays(days: days)
        arrayDayWiseTotalScore = commonTotalMetrixScoreWithDays(totalScoreCondition: totalScoreCondition, totalScoreSymptom: totalScoreSymptom, totalScoreVitals: totalScoreVitals, totalScoreLab: totalScoreLab)
        
        return arrayDayWiseTotalScore
    }
    
    
    func maxTotalScore() -> Double{
        let maxScoreVitals = iDiseaseVital.getMaxVitalsScore()
        let maxConditionData = iDiseaseCondition.getMaxConditionDataScore()
        let maxLabData = iDiseaseLab.getMaxLabDataScore()
        let maxsymptomData = iDiseaseSymptoms.getMaxSymptomDataScore()
        
        let totalMaxScore = maxScoreVitals  + maxConditionData  + maxLabData + maxsymptomData
        
        
        print("totalMaxScore=======\(totalMaxScore) maxScoreVitals===\(maxScoreVitals)  maxConditionData===\(maxConditionData)  maxLabData === \(maxLabData) maxsymptomData===\(maxsymptomData)")
        return totalMaxScore
        
    }
   
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[String:Any]{
        
        return [MetricsType.Conditions.rawValue:iDiseaseCondition.dictionaryRepresentation(),MetricsType.Sympotms.rawValue:iDiseaseSymptoms.dictionaryRepresentation(),MetricsType.LabData.rawValue:iDiseaseLab.dictionaryRepresentation(),MetricsType.Vitals.rawValue:iDiseaseVital.dictionaryRepresentation()] as [String : Any]
        
    }
}
