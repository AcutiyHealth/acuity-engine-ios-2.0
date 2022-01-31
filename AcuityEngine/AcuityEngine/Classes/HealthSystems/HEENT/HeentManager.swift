//
//  HeentManager.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//


import Foundation
import HealthKit
import HealthKitReporter

class HeentManager: NSObject {
    
    
    static let sharedManager = HeentManager()
    
    //Initialize  data...
    var heentData = HeentData()
    
    override init() {
        //super.init()
        
    }
    //Reset Heent Data
    func resetHeentData(){
        heentData = HeentData()
    }
    
    //Save Vitals Data in heentVital Model
    func saveQuantityInArray(quantityType:QuantityType,value:Double,startTimestamp:Double,unit:String) {
        /*
         bodyTemperature
         */
        switch quantityType {
        case .headphoneAudioExposure:
            do{
                let headPhoneAudioLevel = HeentVitalsData(type: VitalsName.headPhoneAudioLevel)
                headPhoneAudioLevel.value = Double(value)
                headPhoneAudioLevel.startTimeStamp = startTimestamp
                self.heentData.heentVital.headphoneAudioLevelsData.append(headPhoneAudioLevel)
                
            }
        case .bodyTemperature:
            do{
                let temperature = HeentVitalsData(type: VitalsName.temperature)
                var value = Double(value)
                if unit == "degC"{
                    //convert value to fahrenheit
                    value = convertDegCelciusToDahrenheit(temprature: value)
                }
                temperature.value = value
                temperature.startTimeStamp = startTimestamp
                self.heentData.heentVital.temperatureData.append(temperature)
                
            }
        case .oxygenSaturation:
            do{
                /*
                 Multiply value with 100 because we get oxygen saturation value in Float from health app. Oxygen saturation 1- 100 will get 0.1-1 from health app
                 */
                let oxygenSaturation = HeentVitalsData(type: VitalsName.oxygenSaturation)
                let newValue = Double(value) * 100
                oxygenSaturation.value = newValue
                oxygenSaturation.startTimeStamp = startTimestamp
                self.heentData.heentVital.oxygenSaturationData.append(oxygenSaturation)
                
            }
       
        default:
            break
        }
        
    }
    
    //Save Symptoms data in heentData model
    func saveSymptomsData(category:CategoryType,element:CategoryData){
        
        let symptomsData = HeentSymptomsPainData(type: category)
        symptomsData.value = Double(element.harmonized.value)
        symptomsData.startTimeStamp = element.startTimestamp
        symptomsData.endTimeStamp = element.endTimestamp
        
        switch category {
        //fever
        case .fever:
            HeentManager.sharedManager.heentData.heentSymptoms.feverData.append(symptomsData)
        //chills
        case .chills:
            HeentManager.sharedManager.heentData.heentSymptoms.chillsData.append(symptomsData)
            
        //dizziness
        case .dizziness:
            HeentManager.sharedManager.heentData.heentSymptoms.dizzinessData.append(symptomsData)
        //fatigue
        case .fatigue:
            HeentManager.sharedManager.heentData.heentSymptoms.fatigueData.append(symptomsData)
            
        //lossOfSmell
        case .lossOfSmell:
            HeentManager.sharedManager.heentData.heentSymptoms.lossOfSmellData.append(symptomsData)
        //runnyNose
        case .runnyNose:
            HeentManager.sharedManager.heentData.heentSymptoms.runnyNoseData.append(symptomsData)
        //soreThroat
        case .soreThroat:
            HeentManager.sharedManager.heentData.heentSymptoms.soreThroatData.append(symptomsData)
        //sleepChanges
        case .sleepChanges:
            HeentManager.sharedManager.heentData.heentSymptoms.sleepChangesData.append(symptomsData)
            
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
        let conditionData = HeentConditionData(type: conditionTypeData)
        conditionData.value = element.value.rawValue
        conditionData.startTimeStamp = element.startTime
        
        switch conditionType {
        //allergicRhiniitis
        case .allergicRhiniitis:
            HeentManager.sharedManager.heentData.heentCondition.allergicRhiniitisData.append(conditionData)
        //respiratoryInfection
        case .respiratoryInfection:
            HeentManager.sharedManager.heentData.heentCondition.respiratoryInfectionData.append(conditionData)
        //covid
        case .covid:
            HeentManager.sharedManager.heentData.heentCondition.covidData.append(conditionData)
        //decreasedVision
        case .decreasedVision:
            HeentManager.sharedManager.heentData.heentCondition.decreasedVisionData.append(conditionData)
        //hearingLoss
        case .hearingLoss:
            HeentManager.sharedManager.heentData.heentCondition.hearingLossData.append(conditionData)
        //otitis
        case .otitis:
            HeentManager.sharedManager.heentData.heentCondition.otitisData.append(conditionData)
        //diabetes
        case .diabetes:
            HeentManager.sharedManager.heentData.heentCondition.diabetesData.append(conditionData)
            
        default:
            break
        }
    }
    //MARK: Save Lab Data
    func saveLabData(code:String,value:Double,timeStamp:Double){
        let labCodeConstant = LabCodeConstant(rawValue: code)
        
        //Create Lab Model Object
        let labData = HeentLabData()
        labData.value = value
        labData.startTimeStamp = timeStamp
        
        switch labCodeConstant {
        
        //alkalinePhosphatase
        case .WBC:
            do{
                labData.type = .WBC
                HeentManager.sharedManager.heentData.heentLab.WBCData.append(labData)
            }
        //neutrophil
        case .neutrophil:
            do{
                labData.type = .neutrophil
                HeentManager.sharedManager.heentData.heentLab.neutrophilData.append(labData)
            }
        //platelets
        case .platelets:
            do{
                labData.type = .platelets
                HeentManager.sharedManager.heentData.heentLab.plateletsData.append(labData)
            }
        default: break
        }
    }
    
}
