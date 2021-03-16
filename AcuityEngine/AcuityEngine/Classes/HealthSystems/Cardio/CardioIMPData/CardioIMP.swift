//
//  CardioVitals.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit



class CardioIMP {
    
    var heartRateData:CardioVitals?
    var systolicBloodPressureData:CardioVitals?
    var diastolicBloodPressureData:CardioVitals?
    var irregularRhythmNotificationData:CardioVitals?
    var highHeartRateData:CardioVitals?
    var lowHeartRateData:CardioVitals?
    var vO2MaxData:CardioVitals?
    
    var tempsystolicBloodPressureData:[CardioVitals]?
    
    func totalVitalsScore() -> Double {
      
        //print(totalAmount) // 4500.0
        let totalIMPScore1 =  Double(heartRateData?.score ?? 0) +  Double(systolicBloodPressureData?.score ?? 0)
        let totalIMPScore2 = Double(diastolicBloodPressureData?.score ?? 0) +  Double(irregularRhythmNotificationData?.score ?? 0)
        let totalIMPScore3 =  Double(highHeartRateData?.score ?? 0) +  Double(lowHeartRateData?.score ?? 0) +  Double(vO2MaxData?.score ?? 0)
        let totalIMPScore = totalIMPScore1 + totalIMPScore2 + totalIMPScore3
        
        return totalIMPScore;
    }
    
    func getMaxVitalsScore() -> Double {
        let totalIMPScore1 =  Double(heartRateData?.maxScore ?? 0) +  Double(systolicBloodPressureData?.maxScore ?? 0)
        let totalIMPScore2 = Double(diastolicBloodPressureData?.maxScore ?? 0) +  Double(irregularRhythmNotificationData?.maxScore ?? 0)
        let totalIMPScore3 =  Double(highHeartRateData?.maxScore ?? 0) +  Double(lowHeartRateData?.maxScore ?? 0) +  Double(vO2MaxData?.maxScore ?? 0)
        let totalIMPScore = totalIMPScore1 + totalIMPScore2 + totalIMPScore3
        
        return totalIMPScore;
    }
    
    func dictionaryRepresentation()->[VitalsModel]{
      
        let objModel = AcuityDetailConditionViewModel()
        return objModel.getVitals()
           
    }
}
