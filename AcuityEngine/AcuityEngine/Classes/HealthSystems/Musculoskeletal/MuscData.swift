//
//  MuscData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class MuscData {
    var muscVital:MuscVital = MuscVital()
    var muscCondition:MuscCondition = MuscCondition()
    var muscSymptoms:MuscSymptoms = MuscSymptoms()
    var muscLab:MuscLab = MuscLab()
    var arrayDayWiseSystemScore:[Double] = []
    var muscSystemScore:Double = 0
    var muscWeightedSystemScore:Double{
        get{
            getWeightedSystemScore()
        }
    }
    var muscRelativeImportance:Double = SystemRelativeImportance.Musculatory
    var maxScore:Double = SystemRelativeImportance.Musculatory
    
    
    func getWeightedSystemScore()->Double{
        print("<--------------------Musc------------------>")
        let score = totalSystemScoreWithDays(days: SegmentValueForGraph.OneDay)
        return (score * muscRelativeImportance)/100
    }
    
    
    //Total/Final System Score
    func totalSystemScoreWithDays(days:SegmentValueForGraph) -> Double{
        print("<--------------------Musc------------------>")
        let arrayDayWiseSystemScore = systemScoreWithDays(days: days)
        //Calculate average system core for 7 days/30 days/3 months
        //Final system score for Cardio
        muscSystemScore = commonTotalSystemScoreWithDays(arrayDayWiseSystemScore: arrayDayWiseSystemScore)
        let calculatedScore = muscSystemScore
        print("Musc calculatedScore",calculatedScore)
        return calculatedScore
    }
    
    //calculate Daywise system score for Musc
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
        let totalScoreVitals = muscVital.totalVitalsScoreForDays(days: days)
        let totalScoreCondition = muscCondition.totalConditionScoreForDays(days: days)
        let totalScoreLab = muscLab.totalLabScoreForDays(days: days)
        let totalScoreSymptom = muscSymptoms.totalSymptomsScoreForDays(days: days)
        arrayDayWiseTotalScore = commonTotalMetrixScoreWithDays(totalScoreCondition: totalScoreCondition, totalScoreSymptom: totalScoreSymptom, totalScoreVitals: totalScoreVitals, totalScoreLab: totalScoreLab)
        
        return arrayDayWiseTotalScore
    }
    
    
    func maxTotalScore() -> Double{
        let maxScoreVitals = muscVital.getMaxVitalsScore()
        let maxConditionData = muscCondition.getMaxConditionDataScore()
        let maxLabData = muscLab.getMaxLabDataScore()
        let maxsymptomData = muscSymptoms.getMaxSymptomDataScore()
        
        let totalMaxScore = maxScoreVitals  + maxConditionData  + maxLabData + maxsymptomData
        
        
        print("totalMaxScore=======\(totalMaxScore) maxScoreVitals===\(maxScoreVitals)  maxConditionData===\(maxConditionData)  maxLabData === \(maxLabData) maxsymptomData===\(maxsymptomData)")
        return totalMaxScore
        
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[String:Any]{
        
        return [MetricsType.Conditions.rawValue:muscCondition.dictionaryRepresentation(),MetricsType.Sympotms.rawValue:muscSymptoms.dictionaryRepresentation(),MetricsType.LabData.rawValue:muscLab.dictionaryRepresentation(),MetricsType.Vitals.rawValue:muscVital.dictionaryRepresentation()] as [String : Any]
        
    }
}
