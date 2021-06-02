//
//  SDHData.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class SDHData {
    var sdhVital:SDHVital = SDHVital()
    var sdhCondition:SDHCondition = SDHCondition()
    var sdhSymptoms:SDHSymptoms = SDHSymptoms()
    var sdhLab:SDHLab = SDHLab()
    var arrayDayWiseSystemScore:[Double] = []
    var sdhSystemScore:Double = 0
    var sdhWeightedSystemScore:Double{
        get{
            getWeightedSystemScore()
        }
    }
    var sdhRelativeImportance:Double = SystemRelativeImportance.SocialDeterminantsofHealth
    var maxScore:Double = SystemRelativeImportance.SocialDeterminantsofHealth
    
    
    func getWeightedSystemScore()->Double{
        print("<--------------------SDH------------------>")
        let score = totalSystemScoreWithDays(days: SegmentValueForGraph.OneDay)
        return (score * sdhRelativeImportance)/100
    }
    
    
    //Total/Final System Score
    func totalSystemScoreWithDays(days:SegmentValueForGraph) -> Double{
        print("<--------------------SDH------------------>")
        let arrayDayWiseSystemScore = systemScoreWithDays(days: days)
        //Calculate average system core for 7 days/30 days/3 months
        //Final system score for Cardio
        sdhSystemScore = commonTotalSystemScoreWithDays(arrayDayWiseSystemScore: arrayDayWiseSystemScore)
        let calculatedScore = sdhSystemScore
        print("SDH calculatedScore",calculatedScore)
        return calculatedScore
    }
    
    //calculate Daywise system score for SDH
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
        let totalScoreVitals = sdhVital.totalVitalsScoreForDays(days: days)
        let totalScoreCondition = sdhCondition.totalConditionScoreForDays(days: days)
        let totalScoreLab = sdhLab.totalLabScoreForDays(days: days)
        let totalScoreSymptom = sdhSymptoms.totalSymptomsScoreForDays(days: days)
        arrayDayWiseTotalScore = commonTotalMetrixScoreWithDays(totalScoreCondition: totalScoreCondition, totalScoreSymptom: totalScoreSymptom, totalScoreVitals: totalScoreVitals, totalScoreLab: totalScoreLab)
        
        return arrayDayWiseTotalScore
    }
    
    
    func maxTotalScore() -> Double{
        let maxScoreVitals = sdhVital.getMaxVitalsScore()
        let maxConditionData = sdhCondition.getMaxConditionDataScore()
        let maxLabData = sdhLab.getMaxLabDataScore()
        let maxsymptomData = sdhSymptoms.getMaxSymptomDataScore()
        
        let totalMaxScore = maxScoreVitals  + maxConditionData  + maxLabData + maxsymptomData
        
        
        print("totalMaxScore=======\(totalMaxScore) maxScoreVitals===\(maxScoreVitals)  maxConditionData===\(maxConditionData)  maxLabData === \(maxLabData) maxsymptomData===\(maxsymptomData)")
        return totalMaxScore
        
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[String:Any]{
        
        return [MetricsType.Conditions.rawValue:sdhCondition.dictionaryRepresentation(),MetricsType.Sympotms.rawValue:sdhSymptoms.dictionaryRepresentation(),MetricsType.LabData.rawValue:sdhLab.dictionaryRepresentation(),MetricsType.Vitals.rawValue:sdhVital.dictionaryRepresentation()] as [String : Any]
        
    }
}
