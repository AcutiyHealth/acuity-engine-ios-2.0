//
//  CardioData.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class CardioData:SystemDataProtocol {
    var cardioIMP:CardioIMP = CardioIMP()
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
    var cardioRelativeImportance:Double = 100
    var maxScore = 100
    
    func getWeightedSystemScore()->Double{
        let score = totalSystemScoreWithDays(days: SegmentValueForGraph.OneDay)
        return (score * cardioRelativeImportance)/100
    }
    
    //Total/Final System Score
    func totalSystemScoreWithDays(days:SegmentValueForGraph) -> Double{
        let arrayDayWiseSystemScore = systemScoreWithDays(days: days)
        print("arrayDayWiseSystemScore",arrayDayWiseSystemScore)
        //Calculate average system core for 7 days/30 days/3 months
        let calculatedScore = arrayDayWiseSystemScore.average()
        
        //Final system score for Cardio
        cardioSystemScore = calculatedScore
        
        print("calculatedScore",calculatedScore)
        return calculatedScore
    }
    //calculate system score for Cardio
    func systemScoreWithDays(days:SegmentValueForGraph)->[Double]{
        arrayDayWiseSystemScore = []
        let arrayFraction = abnormalFractionWithDays(days: days)
        print("abnormalFractionWithDays",arrayFraction)
        if arrayFraction.count > 0 {
            for i in 0...arrayFraction.count-1{
                let score = arrayFraction[i]
                let systemScore = (1-score)*100
                arrayDayWiseSystemScore.append(systemScore)
            }
        }
        return arrayDayWiseSystemScore
    }
    
    //Fraction of Score to calculate System score
    func abnormalFractionWithDays(days:SegmentValueForGraph)->[Double]{
        let arrayDayWiseTotalScore = totalMetrixScoreWithDays(days: days)
        print("arrayDayWiseTotalScore",arrayDayWiseTotalScore)
        var arrayFraction:[Double] = []
        let maxScore = maxTotalScore()
        if arrayDayWiseTotalScore.count > 0 {
            for i in 0...arrayDayWiseTotalScore.count-1{
                let totalScore = arrayDayWiseTotalScore[i]
                let fraction = totalScore/maxScore
                arrayFraction.append(fraction)
            }
        }
        return arrayFraction
    }
    
    
    //Metrix total score
    func totalMetrixScoreWithDays(days:SegmentValueForGraph) -> [Double]{
        var arrayDayWiseTotalScore:[Double] = []
        let totalScoreVitals = cardioIMP.totalVitalsScoreForDays(days: days)
        let totalConditionData = cardioCondition.totalConditionScoreForDays(days: days)
        let totalLabData = cardioLab.totalLabScoreForDays(days: days)
        let totalsymptomData = cardioSymptoms.totalSymptomsScoreForDays(days: days)
        
        if totalScoreVitals.count == totalsymptomData.count,totalConditionData.count == totalLabData.count && totalScoreVitals.count>0,totalConditionData.count>0{
            for i in 0...totalScoreVitals.count - 1{
                
                let totalScore1 = totalScoreVitals[i] + totalConditionData[i]
                let totalScore2 =  totalLabData[i] + totalsymptomData[i]
                let totalScore = totalScore1 + totalScore2
                
                arrayDayWiseTotalScore.append(totalScore)
            }
        }
        
        return arrayDayWiseTotalScore
    }
    func maxTotalScore() -> Double{
        let maxScoreVitals = cardioIMP.getMaxVitalsScore()
        let maxConditionData = cardioCondition.getMaxConditionDataScore()
        let maxLabData = cardioLab.getMaxLabDataScore()
        let maxsymptomData = cardioSymptoms.getMaxSymptomDataScore() 
        
        let totalMaxScore = maxScoreVitals  + maxConditionData  + maxLabData + maxsymptomData
        
        
        print("totalMaxScore=======\(totalMaxScore) maxScoreVitals===\(maxScoreVitals)  maxConditionData===\(maxConditionData)  maxLabData === \(maxLabData) maxsymptomData===\(maxsymptomData)")
        return totalMaxScore
        
    }
    
    func dictionaryRepresentation()->[String:Any]{
        return [MetricsType.Conditions.rawValue:cardioCondition.dictionaryRepresentation(),MetricsType.Sympotms.rawValue:cardioSymptoms.dictionaryRepresentation(),MetricsType.LabData.rawValue:cardioLab.dictionaryRepresentation(),MetricsType.Vitals.rawValue:cardioIMP.dictionaryRepresentation()] as [String : Any]
        
    }
}
