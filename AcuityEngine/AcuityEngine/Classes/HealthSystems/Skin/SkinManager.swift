//
//  SkinManager.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//


import Foundation
import HealthKit
import HealthKitReporter

class SkinManager: NSObject {
    
    
    static let sharedManager = SkinManager()
    
    //Initialize  data...
    var skinData = SkinData()
    
    override init() {
        //super.init()
        
    }
    //Reset Skin Data
    func resetSkinData(){
        skinData = SkinData()
    }
    
    //Save Vitals Data in skinVital Model
    func saveQuantityInArray(quantityType:QuantityType,element:Quantity) {
        /*
         bodyTemperature
         */
        switch quantityType {
        case .bodyTemperature:
            do{
                let temperature = SkinVitalsData(type: VitalsName.temperature)
                temperature.value = Double(element.harmonized.value)
                temperature.startTimeStamp = element.startTimestamp
                self.skinData.skinVital.temperatureData.append(temperature)
                
            }
        case .dietaryWater:
            do{
                let waterIntake = SkinVitalsData(type: VitalsName.waterIntake)
                waterIntake.value = Double(element.harmonized.value)
                waterIntake.startTimeStamp = element.startTimestamp
                self.skinData.skinVital.waterIntakeData.append(waterIntake)
                
            }
        default:
            break
        }
        
    }
    
    //Save Symptoms data in skinData model
    func saveSymptomsData(category:CategoryType,element:CategoryData){
        
        let symptomsData = SkinSymptomsPainData(type: category)
        symptomsData.value = Double(element.harmonized.value)
        symptomsData.startTimeStamp = element.startTimestamp
        symptomsData.endTimeStamp = element.endTimestamp
        
        switch category {
        //acne
        case .acne:
            SkinManager.sharedManager.skinData.skinSymptoms.acneData.append(symptomsData)
        //drySkin
        case .drySkin:
            SkinManager.sharedManager.skinData.skinSymptoms.drySkinData.append(symptomsData)
            
        //hairLoss
        case .hairLoss:
            SkinManager.sharedManager.skinData.skinSymptoms.hairLossData.append(symptomsData)
        //chills
        case .chills:
            SkinManager.sharedManager.skinData.skinSymptoms.chillsData.append(symptomsData)
            
        //fever
        case .fever:
            SkinManager.sharedManager.skinData.skinSymptoms.feverData.append(symptomsData)
            
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
        let conditionData = SkinConditionData(type: conditionTypeData)
        conditionData.value = element.value.rawValue
        conditionData.startTimeStamp = element.startTime
        
        switch conditionType {
        //rashOrAcne
        case .rashOrAcne:
            SkinManager.sharedManager.skinData.skinCondition.rashOrAcneData.append(conditionData)
        //psoriasisEczema
        case .psoriasisEczema:
            SkinManager.sharedManager.skinData.skinCondition.psoriasisEczemaData.append(conditionData)
        //cellulitis
        case .cellulitis:
            SkinManager.sharedManager.skinData.skinCondition.cellulitisData.append(conditionData)
        //diabetes
        case .diabetes:
            SkinManager.sharedManager.skinData.skinCondition.diabetesData.append(conditionData)
            
        default:
            break
        }
    }
    //MARK: Save Lab Data
    func saveLabData(code:String,value:Double,timeStamp:Double){
        let labCodeConstant = LabCodeConstant(rawValue: code)
        
        //Create Lab Model Object
        let labData = SkinLabData()
        labData.value = value
        labData.startTimeStamp = timeStamp
        
        switch labCodeConstant {
        
        //alkalinePhosphatase
        case .WBC:
            do{
                labData.type = .WBC
                SkinManager.sharedManager.skinData.skinLab.WBCData.append(labData)
            }
        //neutrophil
        case .neutrophil:
            do{
                labData.type = .neutrophil
                SkinManager.sharedManager.skinData.skinLab.neutrophilData.append(labData)
            }
        //ESR
        case .ESR:
            do{
                labData.type = .ESR
                SkinManager.sharedManager.skinData.skinLab.ESRData.append(labData)
            }
        default: break
        }
    }
    
}
