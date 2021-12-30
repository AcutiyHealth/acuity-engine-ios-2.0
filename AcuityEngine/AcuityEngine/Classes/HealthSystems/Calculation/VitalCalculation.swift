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
                    //heartRate
                case .heartRate:
                    self.calculatedValue = getHeartRateValue().rawValue
                    //headPhoneAudioLevel
                case .headPhoneAudioLevel:
                    self.calculatedValue = getHeadphoneAudioLevel().rawValue
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
                    //sleep
                case .sleep:
                    self.calculatedValue = getSleepCountValue().rawValue
                    //steps
                case .steps:
                    self.calculatedValue = getstepCountValue().rawValue
                    //waterIntake
                case .waterIntake:
                    self.calculatedValue = getWaterIntakeValue().rawValue
                default: break
                }
            }
        }
    }//H9 // -1 is default value, so we can compare with 0
    
    //Heart Rate Calculation
    private func getHeartRateValue() -> RYGValue{
        
        // =if(I29="","",if(or(I29>110,I29<45),1*H29,if(or(I29>=85,I29<=50),0.5*H29,0)))
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
    //Hadphone audio level
    private func getHeadphoneAudioLevel() -> RYGValue{
        if value >= 0 || value <= 60 {
            return RYGValue.Green
        }else{
            return RYGValue.Red
        }
    }
    //Age Calculation
    private func getAgeValue() -> RYGValue{
        
        if value > 65  {
            return RYGValue.Red
        }
        else {
            return RYGValue.Green
        }
    }
    //Systolic BP Calculation
    private func getSBloodPressureValue() -> RYGValue{
        
        //=if(I27="","",if(or(I27>=150,I27<85),1*H27,if(I27>=135,0.5*H27,0)))
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
        
        //=if(I28="","",if(or(I28>=90,I28<45),1*H28,if(I28>=85,0.5*H28,0)))
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
        
        //=IF(I30="Yes",C30*H30,D30*H30)
        
        if value == 1  {
            return RYGValue.Red
        } else {
            return RYGValue.Green
        }
    }
    //High heart rate..
    private func getHighHeartRateValue() -> RYGValue{
        
        //=IF(I31="Yes",C31*H31,D31*H31)
        
        if value == 1  {
            return RYGValue.Red
        } else {
            return RYGValue.Green
        }
    }
    //Low heart rate..
    private func getLowHeartRateValue() -> RYGValue{
        
        if value == 1  {
            return RYGValue.Red
        } else {
            return RYGValue.Green
        }
    }
    
    //VO2 max calculation
    private func getVO2MaxValue() -> RYGValue{
        
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
        }else{
            return RYGValue.Green
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
    
    //Step Count Value...
    private func getstepCountValue() -> RYGValue{
        
        if value < 4000  {
            return RYGValue.Red
        } else if value >= 4000 && value <= 7999 {
            return RYGValue.Yellow
        } else{
            return RYGValue.Green
        }
    }
    
    //Sleep Count Value...
    private func getSleepCountValue() -> RYGValue{
        
        if value < 4  {
            return RYGValue.Red
        } else if value >= 4 && value <= 6 {
            return RYGValue.Yellow
        } else{
            return RYGValue.Green
        }
    }
    
    //Water Intake Value...
    private func getWaterIntakeValue() -> RYGValue{
        
        if value < 600  {
            return RYGValue.Red
        } else if value >= 600 && value <= 1499 {
            return RYGValue.Yellow
        } else{
            return RYGValue.Green
        }
    }
    
    //Oxygen saturation calculation
    private func getOxygenSaturationValue() -> RYGValue{
        
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
