//
//  RespiratoryLab.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class RespiratoryLab {
    var bicarbonateData:RespiratoryLabData?
    var PaO2Data:RespiratoryLabData?
    var PaCO2Data:RespiratoryLabData?
    var HCO3Data:RespiratoryLabData?
    var O2SatData:RespiratoryLabData?
    var bloodOxygenLevelData:RespiratoryLabData?
    
    func totalLabDataScore() -> Double {
        let totalLabScore1 =  Double(bicarbonateData?.score ?? 0) +  Double(PaO2Data?.score ?? 0)
        let totalLabScore2 = Double(PaCO2Data?.score ?? 0) +  Double(HCO3Data?.score ?? 0)
        let totalLabScore3 =  Double(O2SatData?.score ?? 0) +  Double(bloodOxygenLevelData?.score ?? 0)
        
        let totalLabScore = totalLabScore1 + totalLabScore2 + totalLabScore3
        
        return totalLabScore;
    }
    
    func getMaxLabDataScore() -> Double {
        let totalLabScore1 =  Double(bicarbonateData?.maxScore ?? 0) +  Double(PaO2Data?.maxScore ?? 0)
        let totalLabScore2 = Double(PaCO2Data?.maxScore ?? 0) +  Double(HCO3Data?.maxScore ?? 0)
        let totalLabScore3 =  Double(O2SatData?.maxScore ?? 0) +  Double(bloodOxygenLevelData?.maxScore ?? 0)
        
        let totalLabScore = totalLabScore1 + totalLabScore2 + totalLabScore3
        
        return totalLabScore;
    }
    
}
