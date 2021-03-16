//
//  CardioData.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class CardioData {
    var cardioIMP:CardioIMP = CardioIMP()
    var cardioCondition:CardioCondition = CardioCondition()
    var cardioSymptoms:CardioSymptoms = CardioSymptoms()
    var cardioLab:CardioLab = CardioLab()
    
    var cardioSystemScore:Double{
        get{
            systemScore()
        }
    }
    var cardioWeightedSystemScore:Double{
        get{
            (cardioRelativeImportance * cardioSystemScore)/100
        }
    }
    var cardioRelativeImportance:Double = 100
    var maxScore = 100
    
    func totalScore() -> Double{
        let totalScoreVitals = cardioIMP.totalVitalsScore()
        let totalConditionData = cardioCondition.totalConditionDataScore()
        let totalLabData = cardioLab.totalLabDataScore()
        let totalsymptomData = cardioSymptoms.totalSymptomDataScore()
        
        let totalScore1 = totalScoreVitals + totalConditionData
        let totalScore2 =  totalLabData + totalsymptomData
        let totalScore = totalScore1 + totalScore2
        print("totalScore=======\(totalScore)")
        
        return totalScore
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
    
    func abnormalFraction()->Double{
        let fraction = totalScore()/maxTotalScore()
        return fraction
    }
    
    func systemScore()->Double{
        let score = abnormalFraction()
        return (1-score)*100
    }
    
    func dictionaryRepresentation()->[String:Any]{
      
       return [MetricsType.Conditions.rawValue:cardioCondition.dictionaryRepresentation(),MetricsType.Sympotms.rawValue:cardioSymptoms.dictionaryRepresentation(),MetricsType.LabData.rawValue:cardioLab.dictionaryRepresentation(),MetricsType.Vitals.rawValue:cardioIMP.dictionaryRepresentation()] as [String : Any]
     
    }
}
