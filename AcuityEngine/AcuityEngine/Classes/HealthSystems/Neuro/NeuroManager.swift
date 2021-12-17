//
//  NeuroManager.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//


import Foundation
import HealthKit
import HealthKitReporter

class NeuroManager: NSObject {
    
    
    static let sharedManager = NeuroManager()
    
    //Initialize  data...
    var neuroData = NeuroData()
    
    override init() {
        //super.init()
        
    }
    //Reset Neuro Data
    func resetNeuroData(){
        neuroData = NeuroData()
    }
    
    //Save Vitals Data in neuroVital Model
    func saveQuantityInArray(quantityType:QuantityType,element:Quantity) {
        switch quantityType {
        case .bloodPressureSystolic:
            do{
                let systolicBP = NeuroVitalsData(type: VitalsName.bloodPressureSystolic)
                systolicBP.value = Double(element.harmonized.value)
                systolicBP.startTimeStamp = element.startTimestamp
                self.neuroData.neuroVital.systolicBloodPressureData.append(systolicBP)
                
            }
        case .bloodPressureDiastolic:
            do{
                let diastolicBP = NeuroVitalsData(type: VitalsName.bloodPressureDiastolic)
                diastolicBP.value = Double(element.harmonized.value)
                diastolicBP.startTimeStamp = element.startTimestamp
                self.neuroData.neuroVital.diastolicBloodPressureData.append(diastolicBP)
            }
            
        case .oxygenSaturation:
            do{
                /*
                 Multiply value with 100 because we get oxygen saturation value in Float from health app. Oxygen saturation 1- 100 will get 0.1-1 from health app
                 */
                let oxygenSaturation = NeuroVitalsData(type: VitalsName.oxygenSaturation)
                let newValue = Double(element.harmonized.value) * 100
                oxygenSaturation.value = newValue
                oxygenSaturation.startTimeStamp = element.startTimestamp
                self.neuroData.neuroVital.bloodOxygenLevelData.append(oxygenSaturation)
            }
        case .vo2Max:
            do{
                let vo2Max = NeuroVitalsData(type: VitalsName.vo2Max)
                vo2Max.value = Double(element.harmonized.value)
                vo2Max.startTimeStamp = element.startTimestamp
                self.neuroData.neuroVital.vo2MaxData.append(vo2Max)
            }
        case .stepCount:
            do{
                let steps = NeuroVitalsData(type: VitalsName.steps)
                steps.value = Double(element.harmonized.value)
                steps.startTimeStamp = element.startTimestamp
                self.neuroData.neuroVital.stepsData.append(steps)
            }
        default:
            break
        }
        
    }
    func saveCategoryData(categoryType:CategoryType,value:Double,startTimeStamp:Double,endTimeStamp:Double){
        
        if categoryType == CategoryType.sleepAnalysis {
            
            let sleep = NeuroVitalsData(type: VitalsName.sleep)
            sleep.value = value
            sleep.startTimeStamp = startTimeStamp
            sleep.endTimeStamp = endTimeStamp
            self.neuroData.neuroVital.sleepData.append(sleep)
         
        }
    }
    //Save Symptoms data in neuroData model
    func saveSymptomsData(category:CategoryType,element:CategoryData){
        
        let symptomsData = NeuroSymptomsPainData(type: category)
        symptomsData.value = Double(element.harmonized.value)
        symptomsData.startTimeStamp = element.startTimestamp
        symptomsData.endTimeStamp = element.endTimestamp
        
        switch category {
        //moodChanges
        case .moodChanges:
            NeuroManager.sharedManager.neuroData.neuroSymptoms.moodChangesData.append(symptomsData)
        //dizziness
        case .dizziness:
            NeuroManager.sharedManager.neuroData.neuroSymptoms.dizzinessData.append(symptomsData)
        //bodyAndMuscleAche
        case .generalizedBodyAche:
            NeuroManager.sharedManager.neuroData.neuroSymptoms.bodyAndMuscleAche.append(symptomsData)
        //fatigue
        case .fatigue:
            NeuroManager.sharedManager.neuroData.neuroSymptoms.fatigueData.append(symptomsData)
        //fainting
        case .fainting:
            NeuroManager.sharedManager.neuroData.neuroSymptoms.faintingData.append(symptomsData)
        //nausea
        case .nausea:
            NeuroManager.sharedManager.neuroData.neuroSymptoms.nauseaData.append(symptomsData)
        //vomiting
        case .vomiting:
            NeuroManager.sharedManager.neuroData.neuroSymptoms.vomitingData.append(symptomsData)
        //memoryLapse
        case .memoryLapse:
            NeuroManager.sharedManager.neuroData.neuroSymptoms.memoryLapseData.append(symptomsData)
        //headache
        case .headache:
            NeuroManager.sharedManager.neuroData.neuroSymptoms.headacheData.append(symptomsData)
        //sleepChanges
        case .sleepChanges:
            NeuroManager.sharedManager.neuroData.neuroSymptoms.sleepChangesData.append(symptomsData)
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
        let conditionData = NeuroConditionData(type: conditionTypeData)
        conditionData.value = element.value.rawValue
        conditionData.startTimeStamp = element.startTime
        
        switch conditionType {
        //depressionAnxiety
        case .depressionAnxiety:
            NeuroManager.sharedManager.neuroData.neuroCondition.depressionData.append(conditionData)
        //bipolarDisorder
        case .bipolarDisorder:
            NeuroManager.sharedManager.neuroData.neuroCondition.bipolarDisorderData.append(conditionData)
        //HxOfStroke
        case .HxOfStroke:
            NeuroManager.sharedManager.neuroData.neuroCondition.hxOfStrokeData.append(conditionData)
        //memoryLoss
        case .memoryLoss:
            NeuroManager.sharedManager.neuroData.neuroCondition.memoryLossData.append(conditionData)
        //neuropathy
        case .neuropathy:
            NeuroManager.sharedManager.neuroData.neuroCondition.neuropathyData.append(conditionData)
        //diabetes
        case .diabetes:
            NeuroManager.sharedManager.neuroData.neuroCondition.diabetesData.append(conditionData)
        //hypertension
        case .hypertension:
            NeuroManager.sharedManager.neuroData.neuroCondition.hypertensionData.append(conditionData)
        //arrhythmia
        case .arrhythmia:
            NeuroManager.sharedManager.neuroData.neuroCondition.arrhythmiaData.append(conditionData)
        //coronaryArteryDisease
        case .coronaryArteryDisease:
            NeuroManager.sharedManager.neuroData.neuroCondition.coronaryArteryDiseaseData.append(conditionData)
        default:
            break
        }
    }
    //MARK: Save Lab Data
    func saveLabData(code:String,value:Double,timeStamp:Double){
        let labCodeConstant = LabCodeConstant(rawValue: code)
        
        //Create Lab Model Object
        let labData = NeuroLabData()
        labData.value = value
        labData.startTimeStamp = timeStamp
        
        switch labCodeConstant {
        
        //vitaminB12
        case .vitaminB12:
            do{
                labData.type = .vitaminB12
                NeuroManager.sharedManager.neuroData.neuroLab.vitaminB12Data.append(labData)
            }
        //sodium
        case .sodium:
            do{
                labData.type = .sodium
                NeuroManager.sharedManager.neuroData.neuroLab.sodiumData.append(labData)
            }
        //carbonDioxide
        case .carbonDioxide:
            do{
                labData.type = .carbonDioxide
                NeuroManager.sharedManager.neuroData.neuroLab.carbonDioxideData.append(labData)
            }
            
        default: break
        }
    }
    
}
