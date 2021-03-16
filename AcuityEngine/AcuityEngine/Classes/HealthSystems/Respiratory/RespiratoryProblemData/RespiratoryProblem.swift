//
//  CardioCondition.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class RespiratoryCondition {
    var COPDData:RespiratoryConditionData?
    var asthmaData:RespiratoryConditionData?
    var pneumoniaData:RespiratoryConditionData?
    var pulmonaryEmbolismData:RespiratoryConditionData?
    var allergicRhiniitisData:RespiratoryConditionData?
    var smoking:RespiratoryConditionData?
    
    func totalConditionDataScore() -> Double {
        let totalConditionScore1 =  Double(COPDData?.score ?? 0) +  Double(asthmaData?.score ?? 0)
        let totalConditionScore2 = Double(pneumoniaData?.score ?? 0) +  Double(pulmonaryEmbolismData?.score ?? 0)
        let totalConditionScore3 = Double(allergicRhiniitisData?.score ?? 0) +  Double(smoking?.score ?? 0)
        let totalConditionScore = totalConditionScore1 + totalConditionScore2 + totalConditionScore3
        
        return totalConditionScore;
    }
    
    func getMaxConditionDataScore() -> Double {
        let totalConditionScore1 =  Double(COPDData?.maxScore ?? 0) +  Double(asthmaData?.maxScore ?? 0)
        let totalConditionScore2 = Double(pneumoniaData?.maxScore ?? 0) +  Double(pulmonaryEmbolismData?.maxScore ?? 0)
        let totalConditionScore3 = Double(allergicRhiniitisData?.maxScore ?? 0) +  Double(smoking?.maxScore ?? 0)
        
        let totalConditionScore = totalConditionScore1 + totalConditionScore2 + totalConditionScore3
        
        return totalConditionScore;
    }
    
}
