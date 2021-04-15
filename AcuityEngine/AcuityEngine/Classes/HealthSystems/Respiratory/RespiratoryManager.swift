//
//  RespiratoryManager.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 03/02/21.
//


import Foundation
import HealthKit
import HealthKitReporter

class RespiratoryManager: NSObject {
    
    
    static let sharedManager = RespiratoryManager()
    
    //Initialize  data...
    var respiratoryData = RespiratoryData()
    
    override init() {
        //super.init()
        
    }
    //Reset Respiratory Data
    func resetRespiratoryData(){
        respiratoryData = RespiratoryData()
    }
    
    //Save Vitals Data in respiratoryVital Model
    func saveQuantityInArray(quantityType:QuantityType,element:Quantity) {
        
        if quantityType == QuantityType.bloodPressureSystolic {
            
            let systolicBP = RespiratoryVitalsData(type: VitalsName.bloodPressureSystolic)
            systolicBP.value = Double(element.harmonized.value)
            systolicBP.startTimeStamp = element.startTimestamp
            self.respiratoryData.respiratoryVital.systolicBloodPressureData.append(systolicBP)
            
            print("---------\n bloodPressureSystolic \nValue \(systolicBP.value)\n Score \(systolicBP.score)\n Max Score\(systolicBP.maxScore ?? 0.0) \n---------")
        }
        else if quantityType == QuantityType.bloodPressureDiastolic {
            
            let diastolicBP = RespiratoryVitalsData(type: VitalsName.bloodPressureDiastolic)
            diastolicBP.value = Double(element.harmonized.value)
            diastolicBP.startTimeStamp = element.startTimestamp
            self.respiratoryData.respiratoryVital.diastolicBloodPressureData.append(diastolicBP)
            
        }
        else if quantityType == QuantityType.respiratoryRate {
            
            let respiratoryRate = RespiratoryVitalsData(type: VitalsName.respiratoryRate)
            respiratoryRate.value = Double(element.harmonized.value)
            respiratoryRate.startTimeStamp = element.startTimestamp
            self.respiratoryData.respiratoryVital.respiratoryRateData.append(respiratoryRate)
            
        }
        else if quantityType == QuantityType.oxygenSaturation {
            
            let oxygenSaturation = RespiratoryVitalsData(type: VitalsName.oxygenSaturation)
            oxygenSaturation.value = Double(element.harmonized.value)
            oxygenSaturation.startTimeStamp = element.startTimestamp
            self.respiratoryData.respiratoryVital.oxygenSaturationData.append(oxygenSaturation)
            
        }
        else if quantityType == QuantityType.heartRate {
            
            let heartRate = RespiratoryVitalsData(type: VitalsName.heartRate)
            heartRate.value = Double(element.harmonized.value)
            heartRate.startTimeStamp = element.startTimestamp
            self.respiratoryData.respiratoryVital.heartRateData.append(heartRate)
            
        }
        else if quantityType == QuantityType.peakExpiratoryFlowRate {
            
            let peakExpiratoryFlowRate = RespiratoryVitalsData(type: VitalsName.peakflowRate)
            peakExpiratoryFlowRate.value = Double(element.harmonized.value)
            peakExpiratoryFlowRate.startTimeStamp = element.startTimestamp
            self.respiratoryData.respiratoryVital.peakFlowRateData.append(peakExpiratoryFlowRate)
            
        }
        else if quantityType == QuantityType.vo2Max {
            
            let vo2Max = RespiratoryVitalsData(type: VitalsName.vo2Max)
            vo2Max.value = Double(element.harmonized.value)
            vo2Max.startTimeStamp = element.startTimestamp
            self.respiratoryData.respiratoryVital.vO2MaxData.append(vo2Max)
            
        }
        else if quantityType == QuantityType.inhalerUsage {
            
            let inhalerUsage = RespiratoryVitalsData(type: VitalsName.InhalerUsage)
            inhalerUsage.value = Double(element.harmonized.value)
            inhalerUsage.startTimeStamp = element.startTimestamp
            self.respiratoryData.respiratoryVital.inhalerUsageData.append(inhalerUsage)
        }
    }
    
    
    //Save Category Vitals data in respiratoryVital model
    func saveCategoryData(categoryType:CategoryType,value:Double,startTimeStamp:Double,endTimeStamp:Double){
        
        if categoryType == CategoryType.irregularHeartRhythmEvent {
            
            let irregularRhymesNotification = RespiratoryVitalsData(type: VitalsName.irregularRhymesNotification)
            irregularRhymesNotification.value = 1
            irregularRhymesNotification.startTimeStamp = startTimeStamp
            irregularRhymesNotification.endTimeStamp = endTimeStamp
            self.respiratoryData.respiratoryVital.irregularRhythmNotificationData.append(irregularRhymesNotification)
            
        }
        
    }
    
    //Save Symptoms data in respiratoryData model
    func saveSymptomsData(category:CategoryType,element:CategoryData){
        
        let symptomsData = RespiratorySymptomsPainData(type: category)
        symptomsData.value = Double(element.harmonized.value)
        symptomsData.startTimeStamp = element.startTimestamp
        symptomsData.endTimeStamp = element.endTimestamp
        
        switch category {
        case .chestTightnessOrPain:
            RespiratoryManager.sharedManager.respiratoryData.respiratorySymptoms.chestPainData.append(symptomsData)
        case .rapidPoundingOrFlutteringHeartbeat:
            RespiratoryManager.sharedManager.respiratoryData.respiratorySymptoms.rapidHeartBeatData.append(symptomsData)
        case .coughing:
            RespiratoryManager.sharedManager.respiratoryData.respiratorySymptoms.coughingData.append(symptomsData)
        case .fainting:
            RespiratoryManager.sharedManager.respiratoryData.respiratorySymptoms.faintingData.append(symptomsData)
        case .shortnessOfBreath:
            RespiratoryManager.sharedManager.respiratoryData.respiratorySymptoms.shortBreathData.append(symptomsData)
        case .runnyNose:
            RespiratoryManager.sharedManager.respiratoryData.respiratorySymptoms.runnyNoseData.append(symptomsData)
        case .soreThroat:
            RespiratoryManager.sharedManager.respiratoryData.respiratorySymptoms.soreThroatData.append(symptomsData)
        case .fever:
            RespiratoryManager.sharedManager.respiratoryData.respiratorySymptoms.feverData.append(symptomsData)
        case .chills:
            RespiratoryManager.sharedManager.respiratoryData.respiratorySymptoms.chillsData.append(symptomsData)
        default:
            break
        }
        
        
    }
    
}

