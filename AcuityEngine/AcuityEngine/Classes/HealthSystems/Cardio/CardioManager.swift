//
//  CardioManager.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 03/02/21.
//


import Foundation
import HealthKit
import HealthKitReporter

class CardioManager: NSObject {
    
    
    static let sharedManager = CardioManager()
    private var reporter: HealthKitReporter?
    
    //Initialize cardio data...
    var cardioData = CardioData()
    var totalSum:Double = 0
    var coun:Int = 0
    private lazy var heartRateType: HKQuantityType? = HKObjectType.quantityType(forIdentifier: .heartRate)
    
    override init() {
        //super.init()
        
    }
    
    func resetCardioData(){
       
        cardioData = CardioData()
    }
    
    func saveQuantityInArray(quantityType:QuantityType,element:Quantity) {
  
        if quantityType == QuantityType.bloodPressureSystolic {
            
            let systolicBP = CardioVitals(type: VitalsName.bloodPressureSystolic)
            systolicBP.value = Double(element.harmonized.value)
            systolicBP.startTimeStamp = element.startTimestamp
            self.cardioData.cardioVital.systolicBloodPressureData.append(systolicBP)
            
            
            print("---------\n bloodPressureSystolic \nValue \(systolicBP.value)\n Score \(systolicBP.score)\n Max Score\(systolicBP.maxScore ?? 0.0) \n---------")
        }
        else if quantityType == QuantityType.bloodPressureDiastolic {
            
            let diastolicBP = CardioVitals(type: VitalsName.bloodPressureDiastolic)
            diastolicBP.value = Double(element.harmonized.value)
            diastolicBP.startTimeStamp = element.startTimestamp
            print("diastolicBP date",getDateMediumFormat(time: diastolicBP.startTimeStamp))
            self.cardioData.cardioVital.diastolicBloodPressureData.append(diastolicBP)
            
            
            
            print("---------\n bloodPressureDiastolic \nValue \(diastolicBP.value)\n Score \(diastolicBP.score)\n Max Score\(diastolicBP.maxScore ?? 0.0) \n---------")
            
        }
        else if quantityType == QuantityType.vo2Max {
            
            let vo2Max = CardioVitals(type: VitalsName.vo2Max)
            vo2Max.value = Double(element.harmonized.value)
            vo2Max.startTimeStamp = element.startTimestamp
            self.cardioData.cardioVital.vO2MaxData.append(vo2Max)
            
            
            
            print("---------\n vO2MaxData \nValue \(vo2Max.value)\n Score \(vo2Max.score)\n Max Score\(vo2Max.maxScore ?? 0.0) \n---------")
            //print("---------\n VO2MaxData \nValue \(vo2Max.value)\n Score \(vo2Max.score)\n Max Score\(vo2Max.maxScore ?? 0.0) \n---------")
            
        }
        else if quantityType == QuantityType.heartRate {
            
            let heartRate = CardioVitals(type: VitalsName.heartRate)
            heartRate.value = Double(element.harmonized.value)
            heartRate.startTimeStamp = element.startTimestamp
            self.cardioData.cardioVital.heartRateData.append(heartRate)
            
            //print("---------\n HeartRateData \nValue \(heartRate.value)\n Score \(heartRate.score)\n Max Score\(heartRate.maxScore ?? 0.0) \n---------")
        }
        else if quantityType == QuantityType.oxygenSaturation {
            
            let oxygenSaturation = CardioVitals(type: VitalsName.oxygenSaturation)
            oxygenSaturation.value = Double(element.harmonized.value)
            oxygenSaturation.startTimeStamp = element.startTimestamp
            self.cardioData.cardioVital.oxygenSaturationData.append(oxygenSaturation)
            
            //print("---------\n HeartRateData \nValue \(heartRate.value)\n Score \(heartRate.score)\n Max Score\(heartRate.maxScore ?? 0.0) \n---------")
        }
        
        //dispatchSemaphore.signal()
        
        
    }
    
    func saveCategoryData(categoryType:CategoryType,value:Double,startTimeStamp:Double,endTimeStamp:Double){
        
        if categoryType == CategoryType.highHeartRateEvent {
            
            let highHeartRate = CardioVitals(type: VitalsName.highHeartRate)
            highHeartRate.value = 1
            highHeartRate.startTimeStamp = startTimeStamp
            highHeartRate.endTimeStamp = endTimeStamp
            self.cardioData.cardioVital.highHeartRateData.append(highHeartRate)
            
            
        } else  if categoryType == CategoryType.lowHeartRateEvent {
            
            let lowHeartRate = CardioVitals(type: VitalsName.lowHeartRate)
            lowHeartRate.value = 1
            lowHeartRate.startTimeStamp = startTimeStamp
            lowHeartRate.endTimeStamp = endTimeStamp
            self.cardioData.cardioVital.lowHeartRateData.append(lowHeartRate)
            
            
        } else  if categoryType == CategoryType.irregularHeartRhythmEvent {
            
            let irregularRhymesNotification = CardioVitals(type: VitalsName.irregularRhymesNotification)
            irregularRhymesNotification.value = 1
            irregularRhymesNotification.startTimeStamp = startTimeStamp
            irregularRhymesNotification.endTimeStamp = endTimeStamp
            self.cardioData.cardioVital.irregularRhythmNotificationData.append(irregularRhymesNotification)
            
        }
        
    }
    
    func saveSymptomsData(category:CategoryType,element:CategoryData){
        
        let chestPainData = CardioSymptomsPainData(type: category)
        chestPainData.value = Double(element.harmonized.value)
        chestPainData.startTimeStamp = element.startTimestamp
        chestPainData.endTimeStamp = element.endTimestamp
        
        switch category {
        case .chestTightnessOrPain:
            CardioManager.sharedManager.cardioData.cardioSymptoms.chestPainData.append(chestPainData)
        case .skippedHeartbeat:
            CardioManager.sharedManager.cardioData.cardioSymptoms.skippedHeartBeatData.append(chestPainData)
        case .dizziness:
            CardioManager.sharedManager.cardioData.cardioSymptoms.dizzinessData.append(chestPainData)
        case .fatigue:
            CardioManager.sharedManager.cardioData.cardioSymptoms.fatigueData.append(chestPainData)
        case .rapidPoundingOrFlutteringHeartbeat:
            CardioManager.sharedManager.cardioData.cardioSymptoms.rapidHeartBeatData.append(chestPainData)
        case .fainting:
            CardioManager.sharedManager.cardioData.cardioSymptoms.faintingData.append(chestPainData)
        case .nausea:
            CardioManager.sharedManager.cardioData.cardioSymptoms.nauseaData.append(chestPainData)
        case .vomiting:
            CardioManager.sharedManager.cardioData.cardioSymptoms.vomitingData.append(chestPainData)
        case .memoryLapse:
            CardioManager.sharedManager.cardioData.cardioSymptoms.memoryLapseData.append(chestPainData)
        case .shortnessOfBreath:
            CardioManager.sharedManager.cardioData.cardioSymptoms.shortBreathData.append(chestPainData)
        case .headache:
            CardioManager.sharedManager.cardioData.cardioSymptoms.headacheData.append(chestPainData)
        case .heartburn:
            CardioManager.sharedManager.cardioData.cardioSymptoms.heartBurnData.append(chestPainData)
        case .sleepChanges:
            CardioManager.sharedManager.cardioData.cardioSymptoms.sleepChangesData.append(chestPainData)
        default:
            break
        }
       
        //print("---------\n CardioChestPainData element.harmonized \(element)")
        
        print("---------\n CardioChestPainData \n category \(category) \n Value \(chestPainData.value)\n Score \(chestPainData.score)\n Max Score\(chestPainData.maxScore ) \n---------")
        
        
    }
}


