//
//  GastrointestinalManager.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 03/02/21.
//


import Foundation
import HealthKit
import HealthKitReporter

class GastrointestinalManager: NSObject {
    
    
    static let sharedManager = GastrointestinalManager()
    
    //Initialize  data...
    var gastrointestinalData = GastrointestinalData()
    
    override init() {
        //super.init()
        
    }
    //Reset Gastrointestinal Data
    func resetGastrointestinalData(){
        gastrointestinalData = GastrointestinalData()
    }
    
    //Save Vitals Data in gastrointestinalVital Model
    func saveQuantityInArray(quantityType:QuantityType,element:Quantity) {
        switch quantityType {
        case .bodyMassIndex:
            do{
                let bodyMassIndex = GastrointestinalVitalsData(type: VitalsName.BMI)
                bodyMassIndex.value = Double(element.harmonized.value)
                bodyMassIndex.startTimeStamp = element.startTimestamp
                self.gastrointestinalData.gastrointestinalVital.bodyMassIndexData.append(bodyMassIndex)
                
            }
            
        default:
            break
        }
        
        
        
    }
    
    //Save Symptoms data in gastrointestinalData model
    func saveSymptomsData(category:CategoryType,element:CategoryData){
        
        let symptomsData = GastrointestinalSymptomsPainData(type: category)
        symptomsData.value = Double(element.harmonized.value)
        symptomsData.startTimeStamp = element.startTimestamp
        symptomsData.endTimeStamp = element.endTimestamp
        
        switch category {
        //abdominalCramps
        case .abdominalCramps:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalSymptoms.abdominalCrampsData.append(symptomsData)
        //chestTightnessOrPain
        case .chestTightnessOrPain:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalSymptoms.chestPainData.append(symptomsData)
        //coughing
        case .coughing:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalSymptoms.coughData.append(symptomsData)
            
        //diarrhea
        case .diarrhea:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalSymptoms.diarrheaData.append(symptomsData)
        //constipation
        case .constipation:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalSymptoms.constipationData.append(symptomsData)
        //fatigue
        case .fatigue:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalSymptoms.fatigueData.append(symptomsData)
            
        //bloating
        case .bloating:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalSymptoms.bloatingData.append(symptomsData)
        //nausea
        case .nausea:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalSymptoms.nauseaData.append(symptomsData)
        //vomiting
        case .vomiting:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalSymptoms.vomitingData.append(symptomsData)
        //heartburn
        case .heartburn:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalSymptoms.heartburnData.append(symptomsData)
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
        let conditionData = GastrointestinalConditionData(type: conditionTypeData)
        conditionData.value = element.value.rawValue
        conditionData.startTimeStamp = element.startTime
        /*
         GERD
         Hyperlipidemia
         Ulcerative Colitis
         Crohns disease
         Gastroentritis
         Irritable Bowel disease
         Obesity/overweight
         sleep apnea
         underweight/malnutrition
         Liver DIsease
         diabetes
         */
        switch conditionType {
        //GERD
        case .GERD:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalCondition.GERDData.append(conditionData)
        //hyperlipidemia
        case .hyperlipidemia:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalCondition.hyperlipidemiaData.append(conditionData)
        //ulcerativeColitis
        case .ulcerativeColitis:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalCondition.ulcerativeColitisData.append(conditionData)
        //crohnsDisease
        case .crohnsDisease:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalCondition.crohnsDiseaseData.append(conditionData)
            
        //gastroentritis
        case .gastroentritis:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalCondition.gastroentritisData.append(conditionData)
        //irritableBowelDisease
        case .irritableBowelDisease:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalCondition.irritableBowelDiseaseData.append(conditionData)
        //overweightOrObesity
        case .overweightOrObesity:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalCondition.overweightData.append(conditionData)
        //sleepApnea
        case .sleepApnea:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalCondition.sleepApneaData.append(conditionData)
            
        //underweightOrMalnutrition
        case .underweightOrMalnutrition:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalCondition.underweightMalnutritionData.append(conditionData)
        //liverDisease
        case .liverDisease:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalCondition.liverDiseaseData.append(conditionData)
        //diabetes
        case .diabetes:
            GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalCondition.diabetesData.append(conditionData)
        default:
            break
        }
    }
    //MARK: Save Lab Data
    func saveLabData(code:String,value:Double,timeStamp:Double){
        let labCodeConstant = LabCodeConstant(rawValue: code)
        
        //Create Lab Model Object
        let labData = GastrointestinalLabData()
        labData.value = value
        labData.startTimeStamp = timeStamp
        
        switch labCodeConstant {
        
        //bloodGlucose
        case .bloodGlucose:
            do{
                labData.type = .bloodGlucose
                GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalLab.bloodGlucoseData.append(labData)
            }
        //sodium
        case .sodium:
            do{
                labData.type = .sodium
                GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalLab.sodiumData.append(labData)
            }
        //potassiumLevel
        case .potassiumLevel:
            do{
                labData.type = .potassiumLevel
                GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalLab.potassiumLevelData.append(labData)
            }
        //chloride
        case .chloride:
            do{
                labData.type = .chloride
                GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalLab.chlorideData.append(labData)
            }
        //BUN
        case .BUN:
            do{
                labData.type = .BUN
                GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalLab.BUNData.append(labData)
            }
        //creatinine
        case .creatinine:
            do{
                labData.type = .creatinine
                GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalLab.creatinineData.append(labData)
            }
        //albumin
        case .albumin:
            do{
                labData.type = .albumin
                GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalLab.albuminData.append(labData)
            }
        //AST
        case .AST:
            do{
                labData.type = .AST
                GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalLab.ASTData.append(labData)
            }
        //ALT
        case .ALT:
            do{
                labData.type = .ALT
                GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalLab.ALTData.append(labData)
            }
        default: break
        }
    }
    
}
