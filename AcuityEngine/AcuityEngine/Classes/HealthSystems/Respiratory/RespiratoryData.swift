//
//  RespiratoryData.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class RespiratoryData {
    var respiratoryVital:RespiratoryVital = RespiratoryVital()
    var respiratoryCondition:RespiratoryCondition = RespiratoryCondition()
    var respiratorySymptoms:RespiratorySymptoms = RespiratorySymptoms()
    var respiratoryLab:RespiratoryLab = RespiratoryLab()
    var arrayDayWiseSystemScore:[Double] = []
    var respiratorySystemScore:Double = 0
    var respiratoryWeightedSystemScore:Double{
        get{
            getWeightedSystemScore()
        }
    }
    var respiratoryRelativeImportance:Double = SystemRelativeImportance.Respiratory
    var maxScore:Double = SystemRelativeImportance.Respiratory
    
    /*
     Below method is used to caculate My well score. My well score need one day/today's data for calculation. So, we use totalSystemScoreWithDays with one day.
     */
    func getWeightedSystemScore()->Double{
        print("<--------------------Respirratory------------------>")
        let score = totalSystemScoreWithDays(days: SegmentValueForGraph.OneDay)
        return (score * respiratoryRelativeImportance)/100
    }
    
    
    //Total/Final System Score
    func totalSystemScoreWithDays(days:SegmentValueForGraph) -> Double{
        print("<--------------------Respirratory------------------>")
        let arrayDayWiseSystemScore = systemScoreWithDays(days: days)
        //Calculate average system core for 7 days/30 days/3 months
        //Final system score for Cardio
        respiratorySystemScore = commonTotalSystemScoreWithDays(arrayDayWiseSystemScore: arrayDayWiseSystemScore)
        let calculatedScore = respiratorySystemScore
        print("Respirratory calculatedScore",calculatedScore)
        return calculatedScore
    }
    
    //calculate Daywise system score for Respiratory
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
        let totalScoreVitals = respiratoryVital.totalVitalsScoreForDays(days: days)
        let totalScoreCondition = respiratoryCondition.totalConditionScoreForDays(days: days)
        let totalScoreLab = respiratoryLab.totalLabScoreForDays(days: days)
        let totalScoreSymptom = respiratorySymptoms.totalSymptomsScoreForDays(days: days)
        arrayDayWiseTotalScore = commonTotalMetrixScoreWithDays(totalScoreCondition: totalScoreCondition, totalScoreSymptom: totalScoreSymptom, totalScoreVitals: totalScoreVitals, totalScoreLab: totalScoreLab)
        
        return arrayDayWiseTotalScore
    }
    
    
    func maxTotalScore() -> Double{
        let maxScoreVitals = respiratoryVital.getMaxVitalsScore()
        let maxConditionData = respiratoryCondition.getMaxConditionDataScore()
        let maxLabData = respiratoryLab.getMaxLabDataScore()
        let maxsymptomData = respiratorySymptoms.getMaxSymptomDataScore()
        
        let totalMaxScore = maxScoreVitals  + maxConditionData  + maxLabData + maxsymptomData
        
        
        print("totalMaxScore=======\(totalMaxScore) maxScoreVitals===\(maxScoreVitals)  maxConditionData===\(maxConditionData)  maxLabData === \(maxLabData) maxsymptomData===\(maxsymptomData)")
        return totalMaxScore
        
    }
   
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[String:Any]{
        
        return [MetricsType.Conditions.rawValue:respiratoryCondition.dictionaryRepresentation(),MetricsType.Sympotms.rawValue:respiratorySymptoms.dictionaryRepresentation(),MetricsType.LabData.rawValue:respiratoryLab.dictionaryRepresentation(),MetricsType.Vitals.rawValue:respiratoryVital.dictionaryRepresentation()] as [String : Any]
        
    }
}
