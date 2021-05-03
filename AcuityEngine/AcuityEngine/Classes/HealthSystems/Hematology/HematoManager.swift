//
//  HematoManager.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 03/02/21.
//


import Foundation
import HealthKit
import HealthKitReporter

class HematoManager: NSObject {
    
    
    static let sharedManager = HematoManager()
    
    //Initialize  data...
    var hematoData = HematoData()
    
    override init() {
        //super.init()
        
    }
    //Reset Hemato Data
    func resetHematoData(){
        hematoData = HematoData()
    }
    
    //Save Vitals Data in hematoVital Model
    func saveQuantityInArray(quantityType:QuantityType,element:Quantity) {
        //bloodPressureSystolic
        if quantityType == QuantityType.bloodPressureSystolic {
            
            let systolicBP = HematoVitalsData(type: VitalsName.bloodPressureSystolic)
            systolicBP.value = Double(element.harmonized.value)
            systolicBP.startTimeStamp = element.startTimestamp
            self.hematoData.hematoVital.systolicBloodPressureData.append(systolicBP)
            
            print("---------\n bloodPressureSystolic \nValue \(systolicBP.value)\n Score \(systolicBP.score)\n Max Score\(systolicBP.maxScore ?? 0.0) \n---------")
        }
        //bloodPressureDiastolic
        else if quantityType == QuantityType.bloodPressureDiastolic {
            
            let diastolicBP = HematoVitalsData(type: VitalsName.bloodPressureDiastolic)
            diastolicBP.value = Double(element.harmonized.value)
            diastolicBP.startTimeStamp = element.startTimestamp
            self.hematoData.hematoVital.diastolicBloodPressureData.append(diastolicBP)
        }
        //bodyTemperature
        else if quantityType == QuantityType.bodyTemperature {
            
            let temperature = HematoVitalsData(type: VitalsName.temperature)
            temperature.value = Double(element.harmonized.value)
            temperature.startTimeStamp = element.startTimestamp
            self.hematoData.hematoVital.tempratureData.append(temperature)
        }
        //bodyMassIndex
        else if quantityType == QuantityType.bodyMassIndex {
            
            let bodyMassIndex = HematoVitalsData(type: VitalsName.BMI)
            bodyMassIndex.value = Double(element.harmonized.value)
            bodyMassIndex.startTimeStamp = element.startTimestamp
            self.hematoData.hematoVital.BMIData.append(bodyMassIndex)
        }
    }
    
    //Save Symptoms data in hematoData model
    func saveSymptomsData(category:CategoryType,element:CategoryData){
        
        let symptomsData = HematoSymptomsPainData(type: category)
        symptomsData.value = Double(element.harmonized.value)
        symptomsData.startTimeStamp = element.startTimestamp
        symptomsData.endTimeStamp = element.endTimestamp
        
        switch category {
        //dizziness
        case .dizziness:
            HematoManager.sharedManager.hematoData.hematoSymptoms.dizzinessData.append(symptomsData)
        //fatigue
        case .fatigue:
            HematoManager.sharedManager.hematoData.hematoSymptoms.fatigueData.append(symptomsData)
        //rapidPoundingOrFlutteringHeartbeat
        case .rapidPoundingOrFlutteringHeartbeat:
            HematoManager.sharedManager.hematoData.hematoSymptoms.rapidHeartBeatData.append(symptomsData)
            
        //fainting
        case .fainting:
            HematoManager.sharedManager.hematoData.hematoSymptoms.faintingData.append(symptomsData)
        //chestTightnessOrPain
        case .chestTightnessOrPain:
            HematoManager.sharedManager.hematoData.hematoSymptoms.chestPainData.append(symptomsData)
        //shortnessOfBreath
        case .shortnessOfBreath:
            HematoManager.sharedManager.hematoData.hematoSymptoms.shortnessOfBreathData.append(symptomsData)
        default:
            break
        }
        
        
    }
    //MARK: save condition data..
    func saveConditionsData(element:ConditionsModel){
        let conditionType = ConditionType(rawValue: element.title!)
        guard let conditionTypeData = conditionType else {
            return
        }
        let conditionData = HematoConditionData(type: conditionTypeData)
        conditionData.value = element.value.rawValue
        
        switch conditionType {
        case .anemia:
            HematoManager.sharedManager.hematoData.hematoCondition.anemiaData.append(conditionData)
        case .cancer:
            HematoManager.sharedManager.hematoData.hematoCondition.cancerData.append(conditionData)
        case .otherHematoProblem:
            HematoManager.sharedManager.hematoData.hematoCondition.otherHematoProblemData.append(conditionData)
        default:
            break
        }
    }
}

