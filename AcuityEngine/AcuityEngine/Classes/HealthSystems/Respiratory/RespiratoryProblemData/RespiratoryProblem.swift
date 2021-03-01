//
//  CardioProblem.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class RespiratoryProblem {
    var COPDData:RespiratoryProblemData?
    var asthmaData:RespiratoryProblemData?
    var pneumoniaData:RespiratoryProblemData?
    var pulmonaryEmbolismData:RespiratoryProblemData?
    var allergicRhiniitisData:RespiratoryProblemData?
    var smoking:RespiratoryProblemData?
    
    func totalProblemDataScore() -> Double {
        let totalProblemScore1 =  Double(COPDData?.score ?? 0) +  Double(asthmaData?.score ?? 0)
        let totalProblemScore2 = Double(pneumoniaData?.score ?? 0) +  Double(pulmonaryEmbolismData?.score ?? 0)
        let totalProblemScore3 = Double(allergicRhiniitisData?.score ?? 0) +  Double(smoking?.score ?? 0)
        let totalProblemScore = totalProblemScore1 + totalProblemScore2 + totalProblemScore3
        
        return totalProblemScore;
    }
    
    func getMaxProblemDataScore() -> Double {
        let totalProblemScore1 =  Double(COPDData?.maxScore ?? 0) +  Double(asthmaData?.maxScore ?? 0)
        let totalProblemScore2 = Double(pneumoniaData?.maxScore ?? 0) +  Double(pulmonaryEmbolismData?.maxScore ?? 0)
        let totalProblemScore3 = Double(allergicRhiniitisData?.maxScore ?? 0) +  Double(smoking?.maxScore ?? 0)
        
        let totalProblemScore = totalProblemScore1 + totalProblemScore2 + totalProblemScore3
        
        return totalProblemScore;
    }
    
}
