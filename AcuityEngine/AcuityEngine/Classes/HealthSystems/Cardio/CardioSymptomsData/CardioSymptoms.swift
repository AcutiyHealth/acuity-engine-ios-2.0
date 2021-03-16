//
//  CardioSymptoms.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class CardioSymptoms {
    var chestPainData:CardioSymptomsPainData?
    var skippedHeartBeatData:CardioSymptomsPainData?
    var dizzinessData:CardioSymptomsPainData?
    var fatigueData:CardioSymptomsPainData?
    var rapidHeartBeatData:CardioSymptomsPainData?
    var faintingData:CardioSymptomsPainData?
    var nauseaData:CardioSymptomsPainData?
    var vomitingData:CardioSymptomsPainData?
    var memoryLapseData:CardioSymptomsPainData?
    var shortBreathData:CardioSymptomsPainData?
    var headacheData:CardioSymptomsPainData?
    var heartBurnData:CardioSymptomsPainData?
    var sleepChangesData:CardioSymptomsPainData?
    
    func totalSymptomDataScore() -> Double {
        let totalSymptomScore1 =  Double(chestPainData?.score ?? 0) +  Double(skippedHeartBeatData?.score ?? 0)
        let totalSymptomScore2 = Double(dizzinessData?.score ?? 0) +  Double(fatigueData?.score ?? 0)
        let totalSymptomScore3 =  Double(rapidHeartBeatData?.score ?? 0) +  Double(faintingData?.score ?? 0) +  Double(nauseaData?.score ?? 0)
        let totalSymptomScore4 =  Double(vomitingData?.score ?? 0) +  Double(memoryLapseData?.score ?? 0)
        let totalSymptomScore5 = Double(shortBreathData?.score ?? 0) +  Double(headacheData?.score ?? 0)
        let totalSymptomScore6 = Double(heartBurnData?.score ?? 0) +  Double(sleepChangesData?.score ?? 0)
        
        let totalSymptomScore = totalSymptomScore1 + totalSymptomScore2 + totalSymptomScore3 + totalSymptomScore4 + totalSymptomScore5 + totalSymptomScore6
        
        return totalSymptomScore;
    }
    
    func getMaxSymptomDataScore() -> Double {
        let totalSymptomScore1 =  Double(chestPainData?.maxScore ?? 0) +  Double(skippedHeartBeatData?.maxScore ?? 0)
        let totalSymptomScore2 = Double(dizzinessData?.maxScore ?? 0) +  Double(fatigueData?.maxScore ?? 0)
        let totalSymptomScore3 =  Double(rapidHeartBeatData?.maxScore ?? 0) +  Double(faintingData?.maxScore ?? 0) +  Double(nauseaData?.maxScore ?? 0)
        let totalSymptomScore4 =  Double(vomitingData?.maxScore ?? 0) +  Double(memoryLapseData?.maxScore ?? 0)
        let totalSymptomScore5 = Double(shortBreathData?.maxScore ?? 0) +  Double(headacheData?.maxScore ?? 0)
        let totalSymptomScore6 = Double(heartBurnData?.maxScore ?? 0) +  Double(sleepChangesData?.maxScore ?? 0)
        
        let totalSymptomScore = totalSymptomScore1 + totalSymptomScore2 + totalSymptomScore3 + totalSymptomScore4 + totalSymptomScore5 + totalSymptomScore6
        
        return totalSymptomScore;
    }
    
    func dictionaryRepresentation()->[SymptomsModel]{
      
        let objModel = AcuityDetailConditionViewModel()
        return objModel.getSymptomsData()
           
    }
}
