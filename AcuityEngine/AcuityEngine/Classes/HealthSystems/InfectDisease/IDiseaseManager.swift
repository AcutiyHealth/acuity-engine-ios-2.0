//
//  IDiseaseManager.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 03/02/21.
//


import Foundation
import HealthKit
import HealthKitReporter

class IDiseaseManager: NSObject {
    
    
    static let sharedManager = IDiseaseManager()
    
    //Initialize  data...
    var iDiseaseData = IDiseaseData()
    
    override init() {
        //super.init()
        
    }
    //Reset IDisease Data
    func resetIDiseaseData(){
        iDiseaseData = IDiseaseData()
    }
    
    //Save Vitals Data in iDiseaseVital Model
    func saveQuantityInArray(quantityType:QuantityType,element:Quantity) {
        
        if quantityType == QuantityType.bloodPressureSystolic {
            
            let systolicBP = IDiseaseVitalsData(type: VitalsName.bloodPressureSystolic)
            systolicBP.value = Double(element.harmonized.value)
            systolicBP.startTimeStamp = element.startTimestamp
            self.iDiseaseData.iDiseaseVital.systolicBloodPressureData.append(systolicBP)
            
            print("---------\n bloodPressureSystolic \nValue \(systolicBP.value)\n Score \(systolicBP.score)\n Max Score\(systolicBP.maxScore ) \n---------")
        }
        else if quantityType == QuantityType.bloodPressureDiastolic {
            
            let diastolicBP = IDiseaseVitalsData(type: VitalsName.bloodPressureDiastolic)
            diastolicBP.value = Double(element.harmonized.value)
            diastolicBP.startTimeStamp = element.startTimestamp
            self.iDiseaseData.iDiseaseVital.diastolicBloodPressureData.append(diastolicBP)
        }
        
        else if quantityType == QuantityType.bodyTemperature {
            
            let temperature = IDiseaseVitalsData(type: VitalsName.temperature)
            temperature.value = Double(element.harmonized.value)
            temperature.startTimeStamp = element.startTimestamp
            self.iDiseaseData.iDiseaseVital.temperatureData.append(temperature)
        }
        else if quantityType == QuantityType.heartRate {
            
            let heartRate = IDiseaseVitalsData(type: VitalsName.heartRate)
            heartRate.value = Double(element.harmonized.value)
            heartRate.startTimeStamp = element.startTimestamp
            self.iDiseaseData.iDiseaseVital.heartRateData.append(heartRate)
        }
        else if quantityType == QuantityType.oxygenSaturation {
            
            let oxygenSaturation = IDiseaseVitalsData(type: VitalsName.oxygenSaturation)
            oxygenSaturation.value = Double(element.harmonized.value)
            oxygenSaturation.startTimeStamp = element.startTimestamp
            self.iDiseaseData.iDiseaseVital.oxygenSaturationData.append(oxygenSaturation)
        }
    }
    
    
    //Save Symptoms data in iDiseaseData model
    func saveSymptomsData(category:CategoryType,element:CategoryData){
        
        let symptomsData = IDiseaseSymptomsPainData(type: category)
        symptomsData.value = Double(element.harmonized.value)
        symptomsData.startTimeStamp = element.startTimestamp
        symptomsData.endTimeStamp = element.endTimestamp
        
        switch category {
        case .fever:
            IDiseaseManager.sharedManager.iDiseaseData.iDiseaseSymptoms.feverData.append(symptomsData)
        case .diarrhea:
            IDiseaseManager.sharedManager.iDiseaseData.iDiseaseSymptoms.diarrheaData.append(symptomsData)
        case .fatigue:
            IDiseaseManager.sharedManager.iDiseaseData.iDiseaseSymptoms.fatigueData.append(symptomsData)
        case .coughing:
            IDiseaseManager.sharedManager.iDiseaseData.iDiseaseSymptoms.coughData.append(symptomsData)
        case .nausea:
            IDiseaseManager.sharedManager.iDiseaseData.iDiseaseSymptoms.nauseaData.append(symptomsData)
        case .vomiting:
            IDiseaseManager.sharedManager.iDiseaseData.iDiseaseSymptoms.vomitingData.append(symptomsData)
        case .chills:
            IDiseaseManager.sharedManager.iDiseaseData.iDiseaseSymptoms.chillsData.append(symptomsData)
        case .bladderIncontinence:
            IDiseaseManager.sharedManager.iDiseaseData.iDiseaseSymptoms.bladderIncontinenceData.append(symptomsData)
        case .headache:
            IDiseaseManager.sharedManager.iDiseaseData.iDiseaseSymptoms.headacheData.append(symptomsData)
        case .abdominalCramps:
            IDiseaseManager.sharedManager.iDiseaseData.iDiseaseSymptoms.abdominalCrampsData.append(symptomsData)
        case .shortnessOfBreath:
            IDiseaseManager.sharedManager.iDiseaseData.iDiseaseSymptoms.shortOfBreathData.append(symptomsData)
        case .dizziness:
            do {
                //E24 in ID tab has dizziness value 1 for Present and 0 for Not Present.
                //We get value 4->Severe 3-> Moderate 2->Mild 0->Present and 1 -> Not Presetnt from healthkit for symptoms
                //So save data for Value 1 and 0 only.
                if symptomsData.value <= 1{
                    IDiseaseManager.sharedManager.iDiseaseData.iDiseaseSymptoms.dizzinessData.append(symptomsData)
                }
            }
            
        default:
            break
        }
        
        
    }
    
}

