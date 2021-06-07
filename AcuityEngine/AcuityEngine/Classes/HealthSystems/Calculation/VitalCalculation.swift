//
//  CardioCalculation.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation
import HealthKitReporter

class VitalCalculation:Metrix {
    
    var title: VitalsName = .heartRate // calculate based on symtomps type
    var systemName:SystemName = SystemName.Cardiovascular
    override var value:Double{
        didSet{
            if value < 0  {
                self.calculatedValue = RYGValue.Green.rawValue
            }else{
                switch title {
                //age
                case .age:
                    self.calculatedValue = getAgeValue().rawValue
                //heartRate
                case .heartRate:
                    self.calculatedValue = getHeartRateValue().rawValue
                //bloodPressure
                case .bloodPressure:
                    self.calculatedValue = getSBloodPressureValue().rawValue
                //bloodPressureSystolic
                case .bloodPressureSystolic:
                    self.calculatedValue = getSBloodPressureValue().rawValue
                //bloodPressureDiastolic
                case .bloodPressureDiastolic:
                    self.calculatedValue = getDBloodPressureValue().rawValue
                //BMI
                case .BMI:
                    self.calculatedValue = getBMIValue().rawValue
                //bloodSugar
                case .bloodSugar:
                    self.calculatedValue = getBloodSugarValue().rawValue
                //highHeartRate
                case .highHeartRate:
                    self.calculatedValue = getHighHeartRateValue().rawValue
                //lowHeartRate
                case .lowHeartRate:
                    self.calculatedValue = getLowHeartRateValue().rawValue
                //Temperature
                case .temperature:
                    self.calculatedValue = getTempratureValue().rawValue
                //vo2Max
                case .vo2Max:
                    self.calculatedValue = getVO2MaxValue().rawValue
                //irregularRhymesNotification
                case .irregularRhymesNotification:
                    self.calculatedValue = getIrregularRythmValue().rawValue
                //oxygenSaturation
                case .oxygenSaturation:
                    self.calculatedValue = getOxygenSaturationValue().rawValue
                //respiratoryRate
                case .respiratoryRate:
                    self.calculatedValue = getRespiratoryRateValue().rawValue
                //InhalerUsage
                case .InhalerUsage:
                    self.calculatedValue = getInhalerUsageValue().rawValue
                //peakflowRate
                case .peakflowRate:
                    self.calculatedValue = getPeakFlowRateValue().rawValue
                //stepLength
                case .stepLength:
                    self.calculatedValue = getstepLengthValue().rawValue
                default: break
                }
            }
        }
    }//H9 // -1 is default value, so we can compare with 0
    
    //Heart Rate Calculation
    private func getHeartRateValue() -> RYGValue{
        
        // =if(H26="","",if(or(H26>110,H26<45),1*G26,if(or(H26>=85,H26<=50),0.5*G26,0)))
        if value > 110 || value < 45 {
            return RYGValue.Red
        } else if value >= 85 || value <= 50 {
            return RYGValue.Yellow
        }
        else if value >= 51 && value <= 84 {
            return RYGValue.Green
        }
        else {
            return RYGValue.Green
        }
    }
    //Age Calculation
    private func getAgeValue() -> RYGValue{
        
        // =if(H26="","",if(or(H26>110,H26<45),1*G26,if(or(H26>=85,H26<=50),0.5*G26,0)))
        
        if value > 65  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //Systolic BP Calculation
    private func getSBloodPressureValue() -> RYGValue{
        
        // =if(H24="","",if(or(H24>=150,H24<85),1*G24,if(H24>=135,0.5*G24,0)))
        if value >= 150 || value < 85 {
            return RYGValue.Red
        } else if value >= 135 {
            return RYGValue.Yellow
        } else {
            return RYGValue.Green
        }
    }
    
    //Diastolic BP Calculation
    private func getDBloodPressureValue() -> RYGValue{
        
        // =if(H25="","",if(or(H25>=90,H25<45),1*G25,if(H25>=85,0.5*G25,0)))
        
        if value >= 90 || value < 45 {
            return RYGValue.Red
        } else if value >= 85 {
            return RYGValue.Yellow
        } else {
            return RYGValue.Green
        }
    }
    
    //BMI
    private func getBMIValue() -> RYGValue{
        
        if value > 30 || value < 18  {
            return RYGValue.Red
        } else if value >= 25 && value <= 30 {
            return RYGValue.Yellow
        } else{
            return RYGValue.Green
        }
    }
    //getBloodSugarValue
    private func getBloodSugarValue() -> RYGValue{
        
        if value > 200 || value < 70  {
            return RYGValue.Red
        } else if value >= 127 && value <= 200 {
            return RYGValue.Yellow
        } else{
            return RYGValue.Green
        }
    }
    
    //Irregular Rhmes Notification
    private func getIrregularRythmValue() -> RYGValue{
        
        // =IF(H27="Yes",B27*G27,C27*G27)
        
        if value == 1  {
            return RYGValue.Red
        } else {
            return RYGValue.Green
        }
    }
    //High heart rate..
    private func getHighHeartRateValue() -> RYGValue{
        
        // =IF(H28="Yes",B28*G28,C28*G28)
        
        if value == 1  {
            return RYGValue.Red
        } else {
            return RYGValue.Green
        }
    }
    //Low heart rate..
    private func getLowHeartRateValue() -> RYGValue{
        
        // =IF(H28="Yes",B28*G28,C28*G28)
        
        if value == 1  {
            return RYGValue.Red
        } else {
            return RYGValue.Green
        }
    }
    
    //VO2 max calculation
    private func getVO2MaxValue() -> RYGValue{
        
        // if(H30="","",if(H30<30,1*G30,if(and(H30>=30,H30<=40),0.5*G30,0)))
        
        if value < 30  {
            return RYGValue.Red
        } else if value >= 30 && value <= 40 {
            return RYGValue.Yellow
        } else {
            return RYGValue.Green
        }
    }
    
    //Peak Flow Rate max calculation
    private func getPeakFlowRateValue() -> RYGValue{
        
        if value < 400 || value > 700  {
            return RYGValue.Red
        } else if value >= 400 && value <= 700 {
            return RYGValue.Green
        } else{
            return RYGValue.Yellow
        }
    }
    
    
    //Step Length Value...
    private func getstepLengthValue() -> RYGValue{
        
        if value > 110 || value < 45  {
            return RYGValue.Red
        } else if value >= 85 && value <= 50 {
            return RYGValue.Yellow
        } else{
            return RYGValue.Green
        }
    }
    
    //Oxygen saturation calculation
    private func getOxygenSaturationValue() -> RYGValue{
        
        // if(H30="","",if(H30<30,1*G30,if(and(H30>=30,H30<=40),0.5*G30,0)))
        
        if value < 90  {
            return RYGValue.Red
        } else if value >= 90 && value <= 94 {
            return RYGValue.Yellow
        } else {
            return RYGValue.Green
        }
        
    }
    
    //Temprature calculation
    private func getTempratureValue() -> RYGValue{
        
        // if(H30="","",if(H30<30,1*G30,if(and(H30>=30,H30<=40),0.5*G30,0)))
        
        if value >= 100.4  {
            return RYGValue.Red
        } else if value >= 99 && value <= 100 {
            return RYGValue.Yellow
        } else if value >= 97 && value < 99 {
            return RYGValue.Green
        }
        return RYGValue.Green
    }
    //   Inhaler usage calculation
    private func getInhalerUsageValue() -> RYGValue{
        //=if(H33="","",if(H33>2,1*G33,if(and(H33>=1,H33<=2),0.5*G33,0)))
        
        if value > 2  {
            return RYGValue.Red
        } else if value >= 1 && value <= 2 {
            return RYGValue.Yellow
        } else{
            return RYGValue.Green
        }
    }
    //getRespiratoryRateValue calculation
    private func getRespiratoryRateValue() -> RYGValue{
        //=if(H33="","",if(H33>2,1*G33,if(and(H33>=1,H33<=2),0.5*G33,0)))
        
        if value > 20 || value < 12 {
            return RYGValue.Red
        } else if value >= 12 && value <= 17 {
            return RYGValue.Green
        } else{
            return RYGValue.Yellow
        }
    }
    
    
    //Get UIColor from Calculated Value
    func getUIColorFromCalculatedValue() -> UIColor {
        
        // if(H30="","",if(H30<30,1*G30,if(and(H30>=30,H30<=40),0.5*G30,0)))
        switch calculatedValue {
        case RYGValue.Green.rawValue:
            return ChartColor.GREENCOLOR
        case RYGValue.Red.rawValue:
            return ChartColor.REDCOLOR
        case RYGValue.Yellow.rawValue:
            return ChartColor.YELLOWCOLOR
        default:
            break
        }
        return ChartColor.GREENCOLOR
    }
    
}
