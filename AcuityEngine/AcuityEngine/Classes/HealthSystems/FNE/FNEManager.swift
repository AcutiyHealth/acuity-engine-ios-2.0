//
//  FNEManager.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 03/02/21.
//


import Foundation
import HealthKit
import HealthKitReporter

class FNEManager: NSObject {
    
    
    static let sharedManager = FNEManager()
    
    //Initialize  data...
    var fneData = FNEData()
    
    override init() {
        //super.init()
        
    }
    //Reset FNE Data
    func resetFNEData(){
        fneData = FNEData()
    }
    
    //Save Vitals Data in fneVital Model
    func saveQuantityInArray(quantityType:QuantityType,element:Quantity) {
        //bloodPressureSystolic
        if quantityType == QuantityType.bloodPressureSystolic {
            
            let systolicBP = FNEVitalsData(type: VitalsName.bloodPressureSystolic)
            systolicBP.value = Double(element.harmonized.value)
            systolicBP.startTimeStamp = element.startTimestamp
            self.fneData.fneVital.systolicBloodPressureData.append(systolicBP)
            
            print("---------\n bloodPressureSystolic \nValue \(systolicBP.value)\n Score \(systolicBP.score)\n Max Score\(systolicBP.maxScore ?? 0.0) \n---------")
        }
        //bloodPressureDiastolic
        else if quantityType == QuantityType.bloodPressureDiastolic {
            
            let diastolicBP = FNEVitalsData(type: VitalsName.bloodPressureDiastolic)
            diastolicBP.value = Double(element.harmonized.value)
            diastolicBP.startTimeStamp = element.startTimestamp
            self.fneData.fneVital.diastolicBloodPressureData.append(diastolicBP)
        }
        //heartRate
        else if quantityType == QuantityType.heartRate {
            
            let heartRate = FNEVitalsData(type: VitalsName.heartRate)
            heartRate.value = Double(element.harmonized.value)
            heartRate.startTimeStamp = element.startTimestamp
            self.fneData.fneVital.heartRateData.append(heartRate)
        }
        //bodyMassIndex
        else if quantityType == QuantityType.bodyMassIndex {
            
            let bodyMassIndex = FNEVitalsData(type: VitalsName.BMI)
            bodyMassIndex.value = Double(element.harmonized.value)
            bodyMassIndex.startTimeStamp = element.startTimestamp
            self.fneData.fneVital.BMIData.append(bodyMassIndex)
        }
    }
    
    func saveCategoryData(categoryType:CategoryType,value:Double,startTimeStamp:Double,endTimeStamp:Double){
        
        if categoryType == CategoryType.irregularHeartRhythmEvent {
            
            let irregularHeartRhythmEvent = FNEVitalsData(type: VitalsName.irregularRhymesNotification)
            irregularHeartRhythmEvent.value = 1
            irregularHeartRhythmEvent.startTimeStamp = startTimeStamp
            irregularHeartRhythmEvent.endTimeStamp = endTimeStamp
            self.fneData.fneVital.irregularRhymesNotificationData.append(irregularHeartRhythmEvent)
            
            
        }
    }
    //Save Symptoms data in fneData model
    func saveSymptomsData(category:CategoryType,element:CategoryData){
        
        let symptomsData = FNESymptomsPainData(type: category)
        symptomsData.value = Double(element.harmonized.value)
        symptomsData.startTimeStamp = element.startTimestamp
        symptomsData.endTimeStamp = element.endTimestamp
        
        switch category {
        //fatigue
        case .fatigue:
            FNEManager.sharedManager.fneData.fneSymptoms.fatigueData.append(symptomsData)
        //generalizedBodyAche
        case .generalizedBodyAche:
            FNEManager.sharedManager.fneData.fneSymptoms.bodyAcheData.append(symptomsData)
        //diarrhea
        case .diarrhea:
            FNEManager.sharedManager.fneData.fneSymptoms.diarrheaData.append(symptomsData)
            
        //nausea
        case .nausea:
            FNEManager.sharedManager.fneData.fneSymptoms.nauseaData.append(symptomsData)
        //vomiting
        case .vomiting:
            FNEManager.sharedManager.fneData.fneSymptoms.vomitingData.append(symptomsData)
        //headache
        case .headache:
            FNEManager.sharedManager.fneData.fneSymptoms.headacheData.append(symptomsData)
            
        //dizziness
        case .dizziness:
            FNEManager.sharedManager.fneData.fneSymptoms.dizzinessData.append(symptomsData)
        //fainting
        case .fainting:
            FNEManager.sharedManager.fneData.fneSymptoms.faintingData.append(symptomsData)
        //hairLoss
        case .hairLoss:
            FNEManager.sharedManager.fneData.fneSymptoms.hairLossData.append(symptomsData)
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
        let conditionData = FNEConditionData(type: conditionTypeData)
        conditionData.value = element.value.rawValue
        
        switch conditionType {
        //electrolyteDisorders
        case .electrolyteDisorders:
            FNEManager.sharedManager.fneData.fneCondition.electrolyteDisordersData.append(conditionData)
        //underweightOrMalnutritionData
        case .underweightOrMalnutrition:
            FNEManager.sharedManager.fneData.fneCondition.underweightOrMalnutritionData.append(conditionData)
        //overweightOrObesity
        case .overweightOrObesity:
            FNEManager.sharedManager.fneData.fneCondition.overweightOrObesityData.append(conditionData)
        case .kidneyDiease:
            FNEManager.sharedManager.fneData.fneCondition.kidneyDieaseData.append(conditionData)
        case .pneumonia:
            FNEManager.sharedManager.fneData.fneCondition.pneumoniaData.append(conditionData)
        case .gastroentritis:
            FNEManager.sharedManager.fneData.fneCondition.gastroentritisData.append(conditionData)
        case .diabetes:
            FNEManager.sharedManager.fneData.fneCondition.diabetesData.append(conditionData)
        default:
            break
        }
    }
}

