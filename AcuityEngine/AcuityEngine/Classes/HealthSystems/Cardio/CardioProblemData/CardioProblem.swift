//
//  CardioProblem.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class CardioProblem {
    var hyperTenstionData:CardioProblemData?
    var arrhythmiaData:CardioProblemData?
    var heartFailureData:CardioProblemData?
    var arteryDieseaseData:CardioProblemData?
    
    func totalProblemDataScore() -> Double {
        let totalProblemScore1 =  Double(hyperTenstionData?.score ?? 0) +  Double(arrhythmiaData?.score ?? 0)
        let totalProblemScore2 = Double(heartFailureData?.score ?? 0) +  Double(arteryDieseaseData?.score ?? 0)
       
        let totalProblemScore = totalProblemScore1 + totalProblemScore2
        
        return totalProblemScore;
    }
    
    func getMaxProblemDataScore() -> Double {
        let totalProblemScore1 =  Double(hyperTenstionData?.maxScore ?? 0) +  Double(arrhythmiaData?.maxScore ?? 0)
        let totalProblemScore2 = Double(heartFailureData?.maxScore ?? 0) +  Double(arteryDieseaseData?.maxScore ?? 0)
       
        let totalProblemScore = totalProblemScore1 + totalProblemScore2
        
        return totalProblemScore;
    }
    
}
