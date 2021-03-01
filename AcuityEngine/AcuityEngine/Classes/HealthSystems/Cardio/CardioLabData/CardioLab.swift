//
//  CardioLab.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class CardioLab {
    var potassiumLevelData:CardioLabData?
    var bPeptideData:CardioLabData?
    var troponinLevelData:CardioLabData?
    var bloodOxygenLevelData:CardioLabData?
    var magnesiumLevelData:CardioLabData?
    var hemoglobinLevelData:CardioLabData?
    
    func totalLabDataScore() -> Double {
        let totalLabScore1 =  Double(potassiumLevelData?.score ?? 0) +  Double(bPeptideData?.score ?? 0)
        let totalLabScore2 = Double(troponinLevelData?.score ?? 0) +  Double(bloodOxygenLevelData?.score ?? 0)
        let totalLabScore3 =  Double(magnesiumLevelData?.score ?? 0) +  Double(hemoglobinLevelData?.score ?? 0)
        
        let totalLabScore = totalLabScore1 + totalLabScore2 + totalLabScore3
        
        return totalLabScore;
    }
    
    func getMaxLabDataScore() -> Double {
        let totalLabScore1 =  Double(potassiumLevelData?.maxScore ?? 0) +  Double(bPeptideData?.maxScore ?? 0)
        let totalLabScore2 = Double(troponinLevelData?.maxScore ?? 0) +  Double(bloodOxygenLevelData?.maxScore ?? 0)
        let totalLabScore3 =  Double(magnesiumLevelData?.maxScore ?? 0) +  Double(hemoglobinLevelData?.maxScore ?? 0)
        
        let totalLabScore = totalLabScore1 + totalLabScore2 + totalLabScore3
        
        return totalLabScore;
    }
    
}
