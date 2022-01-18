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
    //MARK: Statastics Data
    func saveStatasticsInArray(quantityType:QuantityType,value:Double,startTimestamp:Double) {
        switch quantityType {
        case .stepCount:
            do{
                /*guard let value = element.harmonized.summary  else {
                    return
                }*/
                let stepCount = RespiratoryVitalsData(type: VitalsName.steps)
                stepCount.value = Double(value)
                stepCount.startTimeStamp = startTimestamp
                self.respiratoryData.respiratoryVital.stepsData.append(stepCount)
            }
            
        default:break
        }
    }
    //Save Vitals Data in respiratoryVital Model
    func saveQuantityInArray(quantityType:QuantityType,element:Quantity) {
        switch quantityType {
        case .bloodPressureSystolic:
            do{
                let systolicBP = RespiratoryVitalsData(type: VitalsName.bloodPressureSystolic)
                systolicBP.value = Double(element.harmonized.value)
                systolicBP.startTimeStamp = element.startTimestamp
                self.respiratoryData.respiratoryVital.systolicBloodPressureData.append(systolicBP)
                
            }
        case .bloodPressureDiastolic:
            do{
                let diastolicBP = RespiratoryVitalsData(type: VitalsName.bloodPressureDiastolic)
                diastolicBP.value = Double(element.harmonized.value)
                diastolicBP.startTimeStamp = element.startTimestamp
                self.respiratoryData.respiratoryVital.diastolicBloodPressureData.append(diastolicBP)
            }
        case .respiratoryRate:
            do{
                let respiratoryRate = RespiratoryVitalsData(type: VitalsName.respiratoryRate)
                respiratoryRate.value = Double(element.harmonized.value)
                respiratoryRate.startTimeStamp = element.startTimestamp
                self.respiratoryData.respiratoryVital.respiratoryRateData.append(respiratoryRate)
            }
        case .oxygenSaturation:
            do{
                /*
                 Multiply value with 100 because we get oxygen saturation value in Float from health app. Oxygen saturation 1- 100 will get 0.1-1 from health app
                 */
                let oxygenSaturation = RespiratoryVitalsData(type: VitalsName.oxygenSaturation)
                let newValue = Double(element.harmonized.value) * 100
                oxygenSaturation.value = newValue
                oxygenSaturation.startTimeStamp = element.startTimestamp
                self.respiratoryData.respiratoryVital.oxygenSaturationData.append(oxygenSaturation)
                
            }
        case .heartRate:
            do{
                let heartRate = RespiratoryVitalsData(type: VitalsName.heartRate)
                heartRate.value = Double(element.harmonized.value)
                heartRate.startTimeStamp = element.startTimestamp
                self.respiratoryData.respiratoryVital.heartRateData.append(heartRate)
                
            }
        case .peakExpiratoryFlowRate:
            do{
                
                let peakExpiratoryFlowRate = RespiratoryVitalsData(type: VitalsName.peakflowRate)
                peakExpiratoryFlowRate.value = Double(element.harmonized.value)
                peakExpiratoryFlowRate.startTimeStamp = element.startTimestamp
                self.respiratoryData.respiratoryVital.peakFlowRateData.append(peakExpiratoryFlowRate)
                
            }
        case .vo2Max:
            do{
                
                let vo2Max = RespiratoryVitalsData(type: VitalsName.vo2Max)
                vo2Max.value = Double(element.harmonized.value)
                vo2Max.startTimeStamp = element.startTimestamp
                self.respiratoryData.respiratoryVital.vO2MaxData.append(vo2Max)
                
            }
        default: break
        }
        
    }
    
    
    //Save Category Vitals data in respiratoryVital model
    func saveCategoryData(categoryType:CategoryType,value:Double,startTimeStamp:Double,endTimeStamp:Double){
        
        switch categoryType {
        case .irregularHeartRhythmEvent:
            do{
                
                let irregularRhymesNotification = RespiratoryVitalsData(type: VitalsName.irregularRhymesNotification)
                irregularRhymesNotification.value = 1
                irregularRhymesNotification.startTimeStamp = startTimeStamp
                irregularRhymesNotification.endTimeStamp = endTimeStamp
                self.respiratoryData.respiratoryVital.irregularRhythmNotificationData.append(irregularRhymesNotification)
                
            }
        case .sleepAnalysis:
            do{
                
                let sleepAnalysis = RespiratoryVitalsData(type: VitalsName.sleep)
                sleepAnalysis.value = value
                sleepAnalysis.startTimeStamp = startTimeStamp
                sleepAnalysis.endTimeStamp = endTimeStamp
                self.respiratoryData.respiratoryVital.sleepData.append(sleepAnalysis)
                //Log.d("Respi sleepAnalysis=======\(sleepAnalysis.value) maxScoreVitals===\(sleepAnalysis.score) ")
            }
        default:
            break
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
    //MARK: save condition data..
    func saveConditionsData(element:ConditionsModel){
        let conditionType = ConditionType(rawValue: element.title!)
        guard let conditionTypeData = conditionType else {
            return
        }
        let conditionData = RespiratoryConditionData(type: conditionTypeData)
        conditionData.value = element.value.rawValue
        conditionData.startTimeStamp = element.startTime
        
        switch conditionType {
        case .asthma:
            RespiratoryManager.sharedManager.respiratoryData.respiratoryCondition.asthmaData.append(conditionData)
        case .pneumonia:
            RespiratoryManager.sharedManager.respiratoryData.respiratoryCondition.pneumoniaData.append(conditionData)
        case .respiratoryInfection:
            RespiratoryManager.sharedManager.respiratoryData.respiratoryCondition.respiratoryInfectionData.append(conditionData)
        case .covid:
            RespiratoryManager.sharedManager.respiratoryData.respiratoryCondition.covidData.append(conditionData)
        case .allergicRhiniitis:
            RespiratoryManager.sharedManager.respiratoryData.respiratoryCondition.allergicRhiniitisData.append(conditionData)
        case .smoking:
            RespiratoryManager.sharedManager.respiratoryData.respiratoryCondition.smokingData.append(conditionData)
        case .sleepApnea:
            RespiratoryManager.sharedManager.respiratoryData.respiratoryCondition.sleepApneaData.append(conditionData)
        case .heartFailure:
            RespiratoryManager.sharedManager.respiratoryData.respiratoryCondition.heartFailureData.append(conditionData)
        case .coronaryArteryDisease:
            RespiratoryManager.sharedManager.respiratoryData.respiratoryCondition.coronaryArteryDiseaseData.append(conditionData)
        default:
            break
        }
        
    }
    //MARK: Save Lab Data
    func saveLabData(code:String,value:Double,timeStamp:Double){
        let labCodeConstant = LabCodeConstant(rawValue: code)
        
        //Create Lab Model Object
        let labData = RespiratoryLabData()
        labData.value = value
        labData.startTimeStamp = timeStamp
        
        switch labCodeConstant {
            //sodium
        case .sodium:
            do{
                labData.type = .sodium
                RespiratoryManager.sharedManager.respiratoryData.respiratoryLab.sodiumData.append(labData)
            }
            //chloride
        case .chloride:
            do{
                labData.type = .chloride
                RespiratoryManager.sharedManager.respiratoryData.respiratoryLab.chlorideData.append(labData)
            }
            //carbonDioxide
        case .carbonDioxide:
            do{
                labData.type = .carbonDioxide
                RespiratoryManager.sharedManager.respiratoryData.respiratoryLab.carbonDioxideData.append(labData)
            }
            //WBC
        case .WBC:
            do{
                labData.type = .WBC
                RespiratoryManager.sharedManager.respiratoryData.respiratoryLab.WBCData.append(labData)
            }
            //neutrophil
        case .neutrophil:
            do{
                labData.type = .neutrophil
                RespiratoryManager.sharedManager.respiratoryData.respiratoryLab.neutrophilData.append(labData)
            }
            
        default:
            break
        }
    }
}

