//
//  RenalManager.swift
//  HealthKitDemo
//
//  Created by  Bhoomi Jagani  on 03/02/21.
//


import Foundation
import HealthKit
import HealthKitReporter

class RenalManager: NSObject {
    
    
    static let sharedManager = RenalManager()
    
    //Initialize  data...
    var renalData = RenalData()
    
    override init() {
        //super.init()
        
    }
    //Reset Renal Data
    func resetRenalData(){
        renalData = RenalData()
    }
    
    //Save Vitals Data in renalVital Model
    func saveQuantityInArray(quantityType:QuantityType,element:Quantity) {
        switch quantityType {
        case .bloodPressureSystolic:
            do{
                
                let systolicBP = RenalVitalsData(type: VitalsName.bloodPressureSystolic)
                systolicBP.value = Double(element.harmonized.value)
                systolicBP.startTimeStamp = element.startTimestamp
                self.renalData.renalVital.systolicBloodPressureData.append(systolicBP)
                
            }
        case .bloodPressureDiastolic:
            do{
                
                let diastolicBP = RenalVitalsData(type: VitalsName.bloodPressureDiastolic)
                diastolicBP.value = Double(element.harmonized.value)
                diastolicBP.startTimeStamp = element.startTimestamp
                self.renalData.renalVital.diastolicBloodPressureData.append(diastolicBP)
                
            }
        case .dietaryWater:
            do{
                
                let waterIntake = RenalVitalsData(type: VitalsName.waterIntake)
                waterIntake.value = Double(element.harmonized.value)
                waterIntake.startTimeStamp = element.startTimestamp
                self.renalData.renalVital.waterIntakeData.append(waterIntake)
                Log.d("Renal=======\(waterIntake.value) maxScoreVitals===\(waterIntake.score) ")
            }
        default:
            break
        }
        
    }
    
    
    //Save Symptoms data in renalData model
    func saveSymptomsData(category:CategoryType,element:CategoryData){
        
        let symptomsData = RenalSymptomsPainData(type: category)
        symptomsData.value = Double(element.harmonized.value)
        symptomsData.startTimeStamp = element.startTimestamp
        symptomsData.endTimeStamp = element.endTimestamp
        
        switch category {
        case .rapidPoundingOrFlutteringHeartbeat:
            RenalManager.sharedManager.renalData.renalSymptoms.rapidHeartBeatData.append(symptomsData)
        case .lowerBackPain:
            RenalManager.sharedManager.renalData.renalSymptoms.lowerBackPainData.append(symptomsData)
        case .dizziness:
            RenalManager.sharedManager.renalData.renalSymptoms.dizzinessData.append(symptomsData)
        case .fainting:
            RenalManager.sharedManager.renalData.renalSymptoms.faintingData.append(symptomsData)
        case .fatigue:
            RenalManager.sharedManager.renalData.renalSymptoms.fatigueData.append(symptomsData)
        case .nausea:
            RenalManager.sharedManager.renalData.renalSymptoms.nauseaData.append(symptomsData)
        case .vomiting:
            RenalManager.sharedManager.renalData.renalSymptoms.vomitingData.append(symptomsData)
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
        let conditionData = RenalConditionData(type: conditionTypeData)
        conditionData.value = element.value.rawValue
        conditionData.startTimeStamp = element.startTime
        
        switch conditionType {
        case .kidneyDiease:
            RenalManager.sharedManager.renalData.renalCondition.kidneyDieaseData.append(conditionData)
        case .kidneyStones:
            RenalManager.sharedManager.renalData.renalCondition.kidneyStonesData.append(conditionData)
        case .hypertension:
            RenalManager.sharedManager.renalData.renalCondition.hypertensionData.append(conditionData)
        case .electrolyteDisorders:
            RenalManager.sharedManager.renalData.renalCondition.electrolyteDisordersData.append(conditionData)
        case .underweightOrMalnutrition:
            RenalManager.sharedManager.renalData.renalCondition.underweightMalnutritionData.append(conditionData)
        case .diabetes:
            RenalManager.sharedManager.renalData.renalCondition.diabetesData.append(conditionData)
        case .UTI:
            RenalManager.sharedManager.renalData.renalCondition.UTIData.append(conditionData)
            
        default:
            break
        }
    }
    //MARK: Save Lab Data
    func saveLabData(code:String,value:Double,timeStamp:Double){
        let labCodeConstant = LabCodeConstant(rawValue: code)
        
        //Create Lab Model Object
        let labData = RenalLabData()
        labData.value = value
        labData.startTimeStamp = timeStamp
        
        switch labCodeConstant {
            
            //BUN
        case .BUN:
            do{
                labData.type = .BUN
                RenalManager.sharedManager.renalData.renalLab.bunData.append(labData)
            }
            //creatinine
        case .creatinine:
            do{
                labData.type = .creatinine
                RenalManager.sharedManager.renalData.renalLab.creatinineData.append(labData)
            }
            //bloodGlucose
        case .bloodGlucose:
            do{
                labData.type = .bloodGlucose
                RenalManager.sharedManager.renalData.renalLab.bloodGlucoseData.append(labData)
            }
            //carbonDioxide
        case .carbonDioxide:
            do{
                labData.type = .carbonDioxide
                RenalManager.sharedManager.renalData.renalLab.carbonDioxideData.append(labData)
            }
            //potassiumLevel
        case .potassiumLevel:
            do{
                labData.type = .potassiumLevel
                RenalManager.sharedManager.renalData.renalLab.potassiumLevelData.append(labData)
            }
            //calcium
        case .calcium:
            do{
                labData.type = .calcium
                RenalManager.sharedManager.renalData.renalLab.calciumData.append(labData)
            }
            //chloride
        case .chloride:
            do{
                labData.type = .chloride
                RenalManager.sharedManager.renalData.renalLab.chlorideData.append(labData)
            }
            //albumin
        case .albumin:
            do{
                labData.type = .albumin
                RenalManager.sharedManager.renalData.renalLab.albuminData.append(labData)
            }
            //anionGap
        case .anionGap:
            do{
                labData.type = .anionGap
                RenalManager.sharedManager.renalData.renalLab.anionGapData.append(labData)
            }
            //hemoglobin
        case .hemoglobin:
            do{
                labData.type = .hemoglobin
                RenalManager.sharedManager.renalData.renalLab.hemaglobinData.append(labData)
            }
            //microalbuminCreatinineRatio
        case .microalbuminCreatinineRatio:
            do{
                labData.type = .microalbuminCreatinineRatio
                RenalManager.sharedManager.renalData.renalLab.microalbuminData.append(labData)
            }
            //eGFR
        case .eGFR:
            do{
                labData.type = .eGFR
                RenalManager.sharedManager.renalData.renalLab.eGFRData.append(labData)
            }
            
        default:
            break
        }
    }
}

