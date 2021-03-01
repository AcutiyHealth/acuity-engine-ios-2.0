//
//  RespiratoryCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation
import HealthKitReporter

class RespiratoryIMPCalculation {
    
    var relativeValue:Double = 100 //G26 // It is define in excel sheet given by client
    var IMPDataType: RespiratoryIMPDataType = .heartRate // calculate based on symtomps type
    var value:Double = -1{
        didSet{
            switch IMPDataType {
            case .heartRate:
                self.calculatedValue = getHeartRateValue().rawValue
            case .respiratoryRate:
                self.calculatedValue = getRespiratoryRateValue().rawValue
            case .supplementOxygen:
                self.calculatedValue = getSupplementOxygenValue().rawValue
            case .highHeartRate:
                self.calculatedValue = getHighHeartRateValue().rawValue
            case .lowHeartRate:
                self.calculatedValue = getLowHeartRateValue().rawValue
            case .vo2Max:
                self.calculatedValue = getVO2MaxValue().rawValue
            case .irregularRhymesNotification:
                self.calculatedValue = getIrregularRythmValue().rawValue
            case .biPAPOrcPAP:
                self.calculatedValue = getBiPapCPapValue().rawValue
            case .peakFlowRate:
                self.calculatedValue = getPeakFlowRateValue().rawValue
            case .sixMinWalk:
                self.calculatedValue = getSixMinWalkValue().rawValue
            case .fev1:
                self.calculatedValue = getFEV1Value().rawValue
            case .inhalerUsage:
                self.calculatedValue = getInhalerUsageValue().rawValue
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
    
    //Respiratory Rate Calculation
    private func getRespiratoryRateValue() -> HeartRateValue {
        
        
        return HeartRateValue.Green
        
    }
    
    // Supplement Oxygen
    private func getSupplementOxygenValue() -> HeartRateValue {
        
        
        return HeartRateValue.Green
        
    }
    // using BiPAP or cPAP
    private func getBiPapCPapValue() -> HeartRateValue {
        
        
        return HeartRateValue.Green
        
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
    
    //Peak flow rate calculation
    private func getPeakFlowRateValue() -> HeartRateValue {
        
        return HeartRateValue.Green
        
    }
    
    //VO2 max calculation
    private func getSixMinWalkValue() -> HeartRateValue {
        
        return HeartRateValue.Green
        
    }
    
    //VO2 max calculation
    private func getFEV1Value() -> HeartRateValue {
        
        // if(H30="","",if(H30<30,1*G30,if(and(H30>=30,H30<=40),0.5*G30,0)))
        
        if value < 2.5  {
            return HeartRateValue.Red
        } else if value >= 2.5 && value <= 3.5 {
            return HeartRateValue.Yellow
        } else if value >= 3 && value <= 4.5{
            return HeartRateValue.Green
        }else{
            return HeartRateValue.Green
        }
    }
    
    //   Inhaler usage calculation
    private func getInhalerUsageValue() -> HeartRateValue {
        
        // if(H30="","",if(H30<30,1*G30,if(and(H30>=30,H30<=40),0.5*G30,0)))
        
        if value > 2  {
            return HeartRateValue.Red
        } else if value >= 1 && value <= 2 {
            return HeartRateValue.Yellow
        } else{
            return HeartRateValue.Green
        }
    }
    
}
