//
//  RespiratoryData.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class RespiratoryData {
    var respiratoryIMP:RespiratoryIMP = RespiratoryIMP()
    var respiratoryProblem:RespiratoryProblem = RespiratoryProblem()
    var respiratorySymptoms:RespiratorySymptoms = RespiratorySymptoms()
    var respiratoryLab:RespiratoryLab = RespiratoryLab()
    
    var respiratorySystemScore:Double{
        get{
            systemScore()
        }
    }
    var respiratoryWeightedSystemScore:Double{
        get{
            (respiratoryRelativeImportance * respiratorySystemScore)/100
        }
    }
    var respiratoryRelativeImportance:Double = 100
    var maxScore = 100
    
    func totalScore() -> Double{
        let totalScoreIMPData = respiratoryIMP.totalIMPDataScore()
        let totalProblemData = respiratoryProblem.totalProblemDataScore()
        let totalLabData = respiratoryLab.totalLabDataScore()
        let totalsymptomData = respiratorySymptoms.totalSymptomDataScore()
        
        let totalScore1 = totalScoreIMPData + totalProblemData
        let totalScore2 =  totalLabData + totalsymptomData
        let totalScore = totalScore1 + totalScore2
        print("totalScore=======\(totalScore)")
        
        return totalScore
    }
    
    func maxTotalScore() -> Double{
        let maxScoreIMPData = respiratoryIMP.getMaxIMPDataScore()
        let maxProblemData = respiratoryProblem.getMaxProblemDataScore()
        let maxLabData = respiratoryLab.getMaxLabDataScore()
        let maxsymptomData = respiratorySymptoms.getMaxSymptomDataScore()
        
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
