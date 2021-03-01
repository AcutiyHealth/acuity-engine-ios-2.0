//
//  CardioSymptoms.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class RespiratorySymptoms {
    var chestPainData:RespiratorySymptomsPainData?
    var skippedHeartBeatData:RespiratorySymptomsPainData?
    var coughData:RespiratorySymptomsPainData?
    var wheezeData:RespiratorySymptomsPainData?
    var rapidHeartBeatData:RespiratorySymptomsPainData?
    var faintingData:RespiratorySymptomsPainData?
    var shortBreathData:RespiratorySymptomsPainData?

    
    func totalSymptomDataScore() -> Double {
        let totalSymptomScore1 =  Double(chestPainData?.score ?? 0) +  Double(skippedHeartBeatData?.score ?? 0)
        let totalSymptomScore2 = Double(coughData?.score ?? 0) +  Double(wheezeData?.score ?? 0)
        let totalSymptomScore3 =  Double(rapidHeartBeatData?.score ?? 0) +  Double(faintingData?.score ?? 0) +  Double(shortBreathData?.score ?? 0)
         
        let totalSymptomScore = totalSymptomScore1 + totalSymptomScore2 + totalSymptomScore3
        
        return totalSymptomScore;
    }
    
    func getMaxSymptomDataScore() -> Double {
        let totalSymptomScore1 =  Double(chestPainData?.maxScore ?? 0) +  Double(skippedHeartBeatData?.maxScore ?? 0)
        let totalSymptomScore2 = Double(coughData?.maxScore ?? 0) +  Double(wheezeData?.maxScore ?? 0)
        let totalSymptomScore3 =  Double(rapidHeartBeatData?.maxScore ?? 0) +  Double(faintingData?.maxScore ?? 0) +  Double(shortBreathData?.maxScore ?? 0)
         
        let totalSymptomScore = totalSymptomScore1 + totalSymptomScore2 + totalSymptomScore3
        
        return totalSymptomScore;
    }
    
    
}

