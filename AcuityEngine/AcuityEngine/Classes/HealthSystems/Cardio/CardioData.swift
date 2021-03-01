//
//  CardioData.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class CardioData {
    var cardioIMP:CardioIMP = CardioIMP()
    var cardioProblem:CardioProblem = CardioProblem()
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
        let totalScoreIMPData = cardioIMP.totalIMPDataScore()
        let totalProblemData = cardioProblem.totalProblemDataScore()
        let totalLabData = cardioLab.totalLabDataScore()
        let totalsymptomData = cardioSymptoms.totalSymptomDataScore()
        
        let totalScore1 = totalScoreIMPData + totalProblemData
        let totalScore2 =  totalLabData + totalsymptomData
        let totalScore = totalScore1 + totalScore2
        print("totalScore=======\(totalScore)")
        
        return totalScore
    }
    
    func maxTotalScore() -> Double{
        let maxScoreIMPData = cardioIMP.getMaxIMPDataScore()
        let maxProblemData = cardioProblem.getMaxProblemDataScore()
        let maxLabData = cardioLab.getMaxLabDataScore()
        let maxsymptomData = cardioSymptoms.getMaxSymptomDataScore() 
        
        let totalMaxScore = maxScoreIMPData  + maxProblemData  + maxLabData + maxsymptomData
        
        
        print("totalMaxScore=======\(totalMaxScore) maxScoreIMPData===\(maxScoreIMPData)  maxProblemData===\(maxProblemData)  maxLabData === \(maxLabData) maxsymptomData===\(maxsymptomData)")
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
    
}
