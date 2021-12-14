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
        switch quantityType {
        case .bloodPressureSystolic:
            do{
                
                let systolicBP = FNEVitalsData(type: VitalsName.bloodPressureSystolic)
                systolicBP.value = Double(element.harmonized.value)
                systolicBP.startTimeStamp = element.startTimestamp
                self.fneData.fneVital.systolicBloodPressureData.append(systolicBP)
                
                //print("---------\n bloodPressureSystolic \nValue \(systolicBP.value)\n Score \(systolicBP.score)\n Max Score\(systolicBP.maxScore ?? 0.0) \n---------")
            }
        case .bloodPressureDiastolic:
            do{
                
                let diastolicBP = FNEVitalsData(type: VitalsName.bloodPressureDiastolic)
                diastolicBP.value = Double(element.harmonized.value)
                diastolicBP.startTimeStamp = element.startTimestamp
                self.fneData.fneVital.diastolicBloodPressureData.append(diastolicBP)
            }
        case .heartRate:
            do{
                
                let heartRate = FNEVitalsData(type: VitalsName.heartRate)
                heartRate.value = Double(element.harmonized.value)
                heartRate.startTimeStamp = element.startTimestamp
                self.fneData.fneVital.heartRateData.append(heartRate)
            }
        case .bodyMassIndex:
            do{
                
                let bodyMassIndex = FNEVitalsData(type: VitalsName.BMI)
                bodyMassIndex.value = Double(element.harmonized.value)
                bodyMassIndex.startTimeStamp = element.startTimestamp
                self.fneData.fneVital.BMIData.append(bodyMassIndex)
            }
        case .dietaryWater:
            do{
                let waterIntake = FNEVitalsData(type: VitalsName.waterIntake)
                waterIntake.value = Double(element.harmonized.value)
                waterIntake.startTimeStamp = element.startTimestamp
                self.fneData.fneVital.waterIntakeData.append(waterIntake)
            }
            
        default:
            break
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
        conditionData.startTimeStamp = element.startTime
        
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
    
    //MARK: Save Lab Data
    func saveLabData(code:String,value:Double,timeStamp:Double){
        let labCodeConstant = LabCodeConstant(rawValue: code)
        
        //Create Lab Model Object
        let labData = FNELabData()
        labData.value = value
        labData.startTimeStamp = timeStamp
        
        switch labCodeConstant {
            
            //bloodGlucose
        case .bloodGlucose:
            do{
                labData.type = .bloodGlucose
                FNEManager.sharedManager.fneData.fneLab.bloddGlucoseData.append(labData)
            }
            //sodium
        case .sodium:
            do{
                labData.type = .sodium
                FNEManager.sharedManager.fneData.fneLab.sodiumData.append(labData)
            }
            //potassiumLevel
        case .potassiumLevel:
            do{
                labData.type = .potassiumLevel
                FNEManager.sharedManager.fneData.fneLab.potassiumData.append(labData)
            }
            //BUN
        case .BUN:
            do{
                labData.type = .BUN
                FNEManager.sharedManager.fneData.fneLab.BUNData.append(labData)
            }
            //creatinine
        case .creatinine:
            do{
                labData.type = .creatinine
                FNEManager.sharedManager.fneData.fneLab.creatinieData.append(labData)
            }
            //eGFR
        case .eGFR:
            do{
                labData.type = .eGFR
                FNEManager.sharedManager.fneData.fneLab.eGFRData.append(labData)
            }
            //albumin
        case .albumin:
            do{
                labData.type = .albumin
                FNEManager.sharedManager.fneData.fneLab.albuminData.append(labData)
            }
            //microalbuminCreatinineRatio
        case .microalbuminCreatinineRatio:
            do{
                labData.type = .microalbuminCreatinineRatio
                FNEManager.sharedManager.fneData.fneLab.microAlbuminData.append(labData)
            }
            //carbonDioxide
        case .carbonDioxide:
            do{
                labData.type = .carbonDioxide
                FNEManager.sharedManager.fneData.fneLab.carbonDioxideData.append(labData)
            }
            //anionGap
        case .anionGap:
            do{
                labData.type = .anionGap
                FNEManager.sharedManager.fneData.fneLab.anionGapData.append(labData)
            }
            //calcium
        case .calcium:
            do{
                labData.type = .calcium
                FNEManager.sharedManager.fneData.fneLab.calciumData.append(labData)
            }
            //chloride
        case .chloride:
            do{
                labData.type = .chloride
                FNEManager.sharedManager.fneData.fneLab.chlorideData.append(labData)
            }
            
            //urineKetone
        case .urineKetone:
            do{
                labData.type = .urineKetone
                FNEManager.sharedManager.fneData.fneLab.urineKenoteData.append(labData)
            }
            //MCV
        case .MCV:
            do{
                labData.type = .MCV
                FNEManager.sharedManager.fneData.fneLab.MCVData.append(labData)
            }
            //AST
        case .AST:
            do{
                labData.type = .AST
                FNEManager.sharedManager.fneData.fneLab.ASTData.append(labData)
            }
            //ALT
        case .ALT:
            do{
                labData.type = .ALT
                FNEManager.sharedManager.fneData.fneLab.ALTData.append(labData)
            }
            
            
        default:
            break
        }
    }
}




