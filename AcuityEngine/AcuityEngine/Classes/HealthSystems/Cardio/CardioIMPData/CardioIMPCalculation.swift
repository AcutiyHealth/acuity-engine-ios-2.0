//
//  CardioCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation
import HealthKitReporter

class CardioIMPCalculation {
    
    var relativeValue:Double = 100 //G26 // It is define in excel sheet given by client
    var startTimeStamp: Double = 0
    var endTimeStamp: Double = 0
    var VitalsType: CardioVitalsType = .heartRate // calculate based on symtomps type
    var value:Double = -1{
        didSet{
            switch VitalsType {
            case .heartRate:
                self.calculatedValue = getHeartRateValue().rawValue
            case .systolicBP:
                self.calculatedValue = getSBloodPressureValue().rawValue
            case .diastolicBP:
                self.calculatedValue = getDBloodPressureValue().rawValue
            case .highHeartRate:
                self.calculatedValue = getHighHeartRateValue().rawValue
            case .lowHeartRate:
                self.calculatedValue = getLowHeartRateValue().rawValue
            case .vo2Max:
                self.calculatedValue = getVO2MaxValue().rawValue
            case .irregularRhymesNotification:
                self.calculatedValue = getIrregularRythmValue().rawValue
            }
        }
    }//H9 // -1 is default value, so we can compare with 0
    
    var calculatedValue:Double = -1 // Calculation will be provided by child class
    var score:Double  {
        // We will calculate score of value
        if calculatedValue == -1 {
            return 0
        } else {
            return (calculatedValue * relativeValue) / 100 // it is percentage value of relative score to 1
        }
        
    }
    
    var maxScore:Double? {
        
        // =if(I25="","",1*G25)
        if score == -1 {
            return 0
        } else {
            return (1*relativeValue) / 100 // it is percentage value of relative score to 1
        }
    }
    
    //Heart Rate Calculation
    private func getHeartRateValue() -> HeartRateValue {
        
        // =if(H26="","",if(or(H26>110,H26<45),1*G26,if(or(H26>=85,H26<=50),0.5*G26,0)))
        
        if value < 0  {
            return HeartRateValue.Green
        } else if value > 110 || value < 45 {
            return HeartRateValue.Red
        } else if value >= 85 || value <= 50 {
            return HeartRateValue.Yellow
        }
        else if value >= 51 && value <= 84 {
            return HeartRateValue.Green
        }
        else {
            return HeartRateValue.Green
        }
    }
    
    //Systolic BP Calculation
    private func getSBloodPressureValue() -> HeartRateValue {
        
        // =if(H24="","",if(or(H24>=150,H24<85),1*G24,if(H24>=135,0.5*G24,0)))
        
        if value < 0  {
            return HeartRateValue.Green
        } else if value >= 150 || value < 85 {
            return HeartRateValue.Red
        } else if value >= 135 {
            return HeartRateValue.Yellow
        } else {
            return HeartRateValue.Green
        }
    }
    
    //Diastolic BP Calculation
    private func getDBloodPressureValue() -> HeartRateValue {
        
        // =if(H25="","",if(or(H25>=90,H25<45),1*G25,if(H25>=85,0.5*G25,0)))
        
        if value < 0  {
            return HeartRateValue.Green
        } else if value >= 90 || value < 45 {
            return HeartRateValue.Red
        } else if value >= 85 {
            return HeartRateValue.Yellow
        } else {
            return HeartRateValue.Green
        }
    }
    
    //Irregular Rhmes Notification
    private func getIrregularRythmValue() -> HeartRateValue {
        
        // =IF(H27="Yes",B27*G27,C27*G27)
        
        if value == 1  {
            return HeartRateValue.Red
        } else {
            return HeartRateValue.Green
        }
    }
    //High heart rate..
    private func getHighHeartRateValue() -> HeartRateValue {
        
        // =IF(H28="Yes",B28*G28,C28*G28)
        
        if value == 1  {
            return HeartRateValue.Red
        } else {
            return HeartRateValue.Green
        }
    }
    //Low heart rate..
    private func getLowHeartRateValue() -> HeartRateValue {
        
        // =IF(H28="Yes",B28*G28,C28*G28)
        
        if value == 1  {
            return HeartRateValue.Red
        } else {
            return HeartRateValue.Green
        }
    }
    
    //VO2 max calculation
    private func getVO2MaxValue() -> HeartRateValue {
        
        // if(H30="","",if(H30<30,1*G30,if(and(H30>=30,H30<=40),0.5*G30,0)))
        
        if value < 30  {
            return HeartRateValue.Red
        } else if value >= 30 && value <= 40 {
            return HeartRateValue.Yellow
        } else {
            return HeartRateValue.Green
        }
    }
}
