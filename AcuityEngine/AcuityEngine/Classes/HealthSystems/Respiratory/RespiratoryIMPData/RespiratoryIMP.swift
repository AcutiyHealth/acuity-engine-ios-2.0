//
//  CardioIMPData.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit



class RespiratoryIMP {
    
    
    var respiratoryRateData:RespiratoryIMPData?
    var biPAPorcPAPData:RespiratoryIMPData?
    var supplementOxygenData:RespiratoryIMPData?
    var heartRateData:RespiratoryIMPData?
    var irregularRhymesNotificationData:RespiratoryIMPData?
    var highHeartRateData:RespiratoryIMPData?
    var lowHeartRateData:RespiratoryIMPData?
    var peakFlowRateData:RespiratoryIMPData?
    var sixMinWalkData:RespiratoryIMPData?
    var FEV1Data:RespiratoryIMPData?
    var vO2MaxData:RespiratoryIMPData?
    var inhalerUsageData:RespiratoryIMPData?
    
    func totalIMPDataScore() -> Double {
        let totalIMPScore1 =  Double(respiratoryRateData?.score ?? 0) +  Double(biPAPorcPAPData?.score ?? 0)
        let totalIMPScore2 = Double(supplementOxygenData?.score ?? 0) +  Double(heartRateData?.score ?? 0)
        let totalIMPScore3 =  Double(irregularRhymesNotificationData?.score ?? 0) +  Double(highHeartRateData?.score ?? 0) +  Double(lowHeartRateData?.score ?? 0)
        let totalIMPScore4 =  Double(peakFlowRateData?.score ?? 0) +  Double(sixMinWalkData?.score ?? 0) +  Double(FEV1Data?.score ?? 0)
        let totalIMPScore5 =  Double(vO2MaxData?.score ?? 0) +  Double(inhalerUsageData?.score ?? 0)
        let totalIMPScore = totalIMPScore1 + totalIMPScore2 + totalIMPScore3 + totalIMPScore4 + totalIMPScore5
        
        return totalIMPScore;
    }
    
    func getMaxIMPDataScore() -> Double {
        let totalIMPScore1 =  Double(respiratoryRateData?.maxScore ?? 0) +  Double(biPAPorcPAPData?.maxScore ?? 0)
        let totalIMPScore2 = Double(supplementOxygenData?.maxScore ?? 0) +  Double(heartRateData?.maxScore ?? 0)
        let totalIMPScore3 =  Double(irregularRhymesNotificationData?.maxScore ?? 0) +  Double(highHeartRateData?.maxScore ?? 0) +  Double(lowHeartRateData?.maxScore ?? 0)
        let totalIMPScore4 =  Double(peakFlowRateData?.maxScore ?? 0) +  Double(sixMinWalkData?.maxScore ?? 0) +  Double(FEV1Data?.maxScore ?? 0)
        let totalIMPScore5 =  Double(vO2MaxData?.maxScore ?? 0) +  Double(inhalerUsageData?.maxScore ?? 0)
        let totalIMPScore = totalIMPScore1 + totalIMPScore2 + totalIMPScore3 + totalIMPScore4 + totalIMPScore5
        
        return totalIMPScore;
    }
}
