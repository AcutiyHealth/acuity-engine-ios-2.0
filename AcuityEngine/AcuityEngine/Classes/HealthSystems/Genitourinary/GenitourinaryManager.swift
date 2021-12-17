//
//  GenitourinaryManager.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//


import Foundation
import HealthKit
import HealthKitReporter

class GenitourinaryManager: NSObject {
    
    
    static let sharedManager = GenitourinaryManager()
    
    //Initialize  data...
    var genitourinaryData = GenitourinaryData()
    
    override init() {
        //super.init()
        
    }
    //Reset Genitourinary Data
    func resetGenitourinaryData(){
        genitourinaryData = GenitourinaryData()
    }
    
    //Save Vitals Data in genitourinaryVital Model
    func saveQuantityInArray(quantityType:QuantityType,element:Quantity) {
        switch quantityType {
        case .bloodPressureSystolic:
            do{
                let systolicBP = GenitourinaryVitalsData(type: VitalsName.bloodPressureSystolic)
                systolicBP.value = Double(element.harmonized.value)
                systolicBP.startTimeStamp = element.startTimestamp
                self.genitourinaryData.genitourinaryVital.systolicBloodPressureData.append(systolicBP)
                
            }
        case .bloodPressureDiastolic:
            do{
                let diastolicBP = GenitourinaryVitalsData(type: VitalsName.bloodPressureDiastolic)
                diastolicBP.value = Double(element.harmonized.value)
                diastolicBP.startTimeStamp = element.startTimestamp
                self.genitourinaryData.genitourinaryVital.diastolicBloodPressureData.append(diastolicBP)
            }
            
        case .heartRate:
            do{
                let heartRate = GenitourinaryVitalsData(type: VitalsName.heartRate)
                heartRate.value = Double(element.harmonized.value)
                heartRate.startTimeStamp = element.startTimestamp
                self.genitourinaryData.genitourinaryVital.heartRateData.append(heartRate)
            }
        case .bodyTemperature:
            do{
                let temperature = GenitourinaryVitalsData(type: VitalsName.temperature)
                temperature.value = Double(element.harmonized.value)
                temperature.startTimeStamp = element.startTimestamp
                self.genitourinaryData.genitourinaryVital.tempratureData.append(temperature)
            }
        case .dietaryWater:
            do{
                let waterIntake = GenitourinaryVitalsData(type: VitalsName.waterIntake)
                waterIntake.value = Double(element.harmonized.value)
                waterIntake.startTimeStamp = element.startTimestamp
                self.genitourinaryData.genitourinaryVital.waterIntakeData.append(waterIntake)
            }
        default:
            break
        }
        
    }
    
    //Save Symptoms data in genitourinaryData model
    func saveSymptomsData(category:CategoryType,element:CategoryData){
        
        let symptomsData = GenitourinarySymptomsPainData(type: category)
        symptomsData.value = Double(element.harmonized.value)
        symptomsData.startTimeStamp = element.startTimestamp
        symptomsData.endTimeStamp = element.endTimestamp
        
        switch category {
        //fever
        case .fever:
            GenitourinaryManager.sharedManager.genitourinaryData.genitourinarySymptoms.feverData.append(symptomsData)
        //bladderIncontinence
        case .bladderIncontinence:
            GenitourinaryManager.sharedManager.genitourinaryData.genitourinarySymptoms.bladderIncontinenceData.append(symptomsData)
        //abdominalCramps
        case .abdominalCramps:
            GenitourinaryManager.sharedManager.genitourinaryData.genitourinarySymptoms.abdominalCrampsData.append(symptomsData)
        //dizziness
        case .dizziness:
            GenitourinaryManager.sharedManager.genitourinaryData.genitourinarySymptoms.dizzinessData.append(symptomsData)
        //fatigue
        case .fatigue:
            GenitourinaryManager.sharedManager.genitourinaryData.genitourinarySymptoms.fatigueData.append(symptomsData)
        //nausea
        case .nausea:
            GenitourinaryManager.sharedManager.genitourinaryData.genitourinarySymptoms.nauseaData.append(symptomsData)
        //vomiting
        case .vomiting:
            GenitourinaryManager.sharedManager.genitourinaryData.genitourinarySymptoms.vomitingData.append(symptomsData)
        //chills
        case .chills:
            GenitourinaryManager.sharedManager.genitourinaryData.genitourinarySymptoms.chillsData.append(symptomsData)
        //bloating
        case .bloating:
            GenitourinaryManager.sharedManager.genitourinaryData.genitourinarySymptoms.bloatingData.append(symptomsData)
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
        let conditionData = GenitourinaryConditionData(type: conditionTypeData)
        conditionData.value = element.value.rawValue
        conditionData.startTimeStamp = element.startTime
        
        switch conditionType {
        //UTI
        case .UTI:
            GenitourinaryManager.sharedManager.genitourinaryData.genitourinaryCondition.UTIData.append(conditionData)
        //urinaryProblems
        case .urinaryProblems:
            GenitourinaryManager.sharedManager.genitourinaryData.genitourinaryCondition.urinaryProblemsData.append(conditionData)
        //kidneyStones
        case .kidneyStones:
            GenitourinaryManager.sharedManager.genitourinaryData.genitourinaryCondition.kidneyStonesData.append(conditionData)
        //kidneyDiease
        case .kidneyDiease:
            GenitourinaryManager.sharedManager.genitourinaryData.genitourinaryCondition.kidneyDiseaseData.append(conditionData)
        //diabetes
        case .diabetes:
            GenitourinaryManager.sharedManager.genitourinaryData.genitourinaryCondition.diabetesData.append(conditionData)
        default:
            break
        }
    }
    //MARK: Save Lab Data
    func saveLabData(code:String,value:Double,timeStamp:Double){
        let labCodeConstant = LabCodeConstant(rawValue: code)
        
        //Create Lab Model Object
        let labData = GenitourinaryLabData()
        labData.value = value
        labData.startTimeStamp = timeStamp
        
        switch labCodeConstant {
        
        //WBC
        case .WBC:
            do{
                labData.type = .WBC
                GenitourinaryManager.sharedManager.genitourinaryData.genitourinaryLab.WBCData.append(labData)
            }
        //neutrophil
        case .neutrophil:
            do{
                labData.type = .neutrophil
                GenitourinaryManager.sharedManager.genitourinaryData.genitourinaryLab.neutrophilData.append(labData)
            }
        //urineNitrites
        case .urineNitrites:
            do{
                labData.type = .urineNitrites
                GenitourinaryManager.sharedManager.genitourinaryData.genitourinaryLab.urineNitritesData.append(labData)
            }
        //urineKetone
        case .urineKetone:
            do{
                labData.type = .urineKetone
                GenitourinaryManager.sharedManager.genitourinaryData.genitourinaryLab.urineKetoneData.append(labData)
            }
        //urineBlood
        case .urineBlood:
            do{
                labData.type = .urineBlood
                GenitourinaryManager.sharedManager.genitourinaryData.genitourinaryLab.urineBloodData.append(labData)
            }
            
        default: break
        }
    }
    
}
