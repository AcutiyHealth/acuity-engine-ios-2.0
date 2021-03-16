//
//  CardioCondition.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class CardioCondition {
    var hyperTenstionData:CardioConditionData?
    var arrhythmiaData:CardioConditionData?
    var heartFailureData:CardioConditionData?
    var arteryDieseaseData:CardioConditionData?
    
    func totalConditionDataScore() -> Double {
        let totalConditionScore1 =  Double(hyperTenstionData?.score ?? 0) +  Double(arrhythmiaData?.score ?? 0)
        let totalConditionScore2 = Double(heartFailureData?.score ?? 0) +  Double(arteryDieseaseData?.score ?? 0)
        
        let totalConditionScore = totalConditionScore1 + totalConditionScore2
        
        return totalConditionScore;
    }
    
    func getMaxConditionDataScore() -> Double {
        let totalConditionScore1 =  Double(hyperTenstionData?.maxScore ?? 0) +  Double(arrhythmiaData?.maxScore ?? 0)
        let totalConditionScore2 = Double(heartFailureData?.maxScore ?? 0) +  Double(arteryDieseaseData?.maxScore ?? 0)
        
        let totalConditionScore = totalConditionScore1 + totalConditionScore2
        
        return totalConditionScore;
    }

    func dictionaryRepresentation()->[ConditionsModel]{
      
        let objModel = AcuityDetailConditionViewModel()
        return objModel.getConditionData()
           
    }
    
}
