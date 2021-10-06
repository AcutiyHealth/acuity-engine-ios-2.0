//
//  EndocrineManager.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 03/02/21.
//


import Foundation
import HealthKit
import HealthKitReporter

class EndocrineManager: NSObject {
    
    
    static let sharedManager = EndocrineManager()
    
    //Initialize  data...
    var endocrineData = EndocrineData()
    
    override init() {
        //super.init()
        
    }
    //Reset Endocrine Data
    func resetEndocrineData(){
        endocrineData = EndocrineData()
    }
    
    //Save Vitals Data in endocrineVital Model
    func saveQuantityInArray(quantityType:QuantityType,element:Quantity) {
        switch quantityType {
        case .bloodPressureSystolic:
            do{
                let systolicBP = EndocrineVitalsData(type: VitalsName.bloodPressureSystolic)
                systolicBP.value = Double(element.harmonized.value)
                systolicBP.startTimeStamp = element.startTimestamp
                self.endocrineData.endocrineVital.systolicBloodPressureData.append(systolicBP)
                
            }
        case .bloodPressureDiastolic:
            do{
                let diastolicBP = EndocrineVitalsData(type: VitalsName.bloodPressureDiastolic)
                diastolicBP.value = Double(element.harmonized.value)
                diastolicBP.startTimeStamp = element.startTimestamp
                self.endocrineData.endocrineVital.diastolicBloodPressureData.append(diastolicBP)
            }
            
        case .heartRate:
            do{
                let heartRate = EndocrineVitalsData(type: VitalsName.heartRate)
                heartRate.value = Double(element.harmonized.value)
                heartRate.startTimeStamp = element.startTimestamp
                self.endocrineData.endocrineVital.heartRateData.append(heartRate)
            }
        case .bloodGlucose:
            do{
                /*
                 Note: Logic for Blood Sugar is remaining
                 */
                let bloodSugar = EndocrineVitalsData(type: VitalsName.bloodSugar)
                bloodSugar.value = Double(element.harmonized.value)
                bloodSugar.startTimeStamp = element.startTimestamp
                self.endocrineData.endocrineVital.bloodSugarData.append(bloodSugar)
            }
        case .bodyTemperature:
            do{
                let temperature = EndocrineVitalsData(type: VitalsName.temperature)
                temperature.value = Double(element.harmonized.value)
                temperature.startTimeStamp = element.startTimestamp
                self.endocrineData.endocrineVital.tempratureData.append(temperature)
            }
        default:
            break
        }
        
        
        
    }
    
    //Save Symptoms data in endocrineData model
    func saveSymptomsData(category:CategoryType,element:CategoryData){
        
        let symptomsData = EndocrineSymptomsPainData(type: category)
        symptomsData.value = Double(element.harmonized.value)
        symptomsData.startTimeStamp = element.startTimestamp
        symptomsData.endTimeStamp = element.endTimestamp
        
        switch category {
        //dizziness
        case .dizziness:
            EndocrineManager.sharedManager.endocrineData.endocrineSymptoms.dizzinessData.append(symptomsData)
        //fatigue
        case .fatigue:
            EndocrineManager.sharedManager.endocrineData.endocrineSymptoms.fatigueData.append(symptomsData)
        //rapidPoundingOrFlutteringHeartbeat
        case .rapidPoundingOrFlutteringHeartbeat:
            EndocrineManager.sharedManager.endocrineData.endocrineSymptoms.rapidHeartBeatData.append(symptomsData)
            
        //hotFlashes
        case .hotFlashes:
            EndocrineManager.sharedManager.endocrineData.endocrineSymptoms.hotFlashesData.append(symptomsData)
        //fainting
        case .fainting:
            EndocrineManager.sharedManager.endocrineData.endocrineSymptoms.faintingData.append(symptomsData)
        //hairLoss
        case .hairLoss:
            EndocrineManager.sharedManager.endocrineData.endocrineSymptoms.hairLossData.append(symptomsData)
            
        //nausea
        case .nausea:
            EndocrineManager.sharedManager.endocrineData.endocrineSymptoms.nauseaData.append(symptomsData)
        //vomiting
        case .vomiting:
            EndocrineManager.sharedManager.endocrineData.endocrineSymptoms.vomitingData.append(symptomsData)
        //drySkin
        case .drySkin:
            EndocrineManager.sharedManager.endocrineData.endocrineSymptoms.drySkinData.append(symptomsData)
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
        let conditionData = EndocrineConditionData(type: conditionTypeData)
        conditionData.value = element.value.rawValue
        conditionData.startTimeStamp = element.startTime
        
        switch conditionType {
        //diabetes
        case .diabetes:
            EndocrineManager.sharedManager.endocrineData.endocrineCondition.diabetesData.append(conditionData)
        //thyroidDisorder
        case .thyroidDisorder:
            EndocrineManager.sharedManager.endocrineData.endocrineCondition.thyroidDisorderData.append(conditionData)
        //polycysticOvarianDisease
        case .polycysticOvarianDisease:
            EndocrineManager.sharedManager.endocrineData.endocrineCondition.polycysticOvarianDiseaseData.append(conditionData)
        //hormoneProblems
        case .hormoneProblems:
            EndocrineManager.sharedManager.endocrineData.endocrineCondition.hormoneProblemsData.append(conditionData)
        default:
            break
        }
    }
    
    //MARK: Save Lab Data
    func saveLabData(code:String,value:Double,timeStamp:Double){
        let labCodeConstant = LabCodeConstant(rawValue: code)
        
        //Create Lab Model Object
        let labData = EndocrineLabData()
        labData.value = value
        labData.startTimeStamp = timeStamp
        
        switch labCodeConstant {
        
        //hemoglobinA1C
        case .hemoglobinA1C:
            do{
                labData.type = .hemoglobinA1C
                EndocrineManager.sharedManager.endocrineData.endocrineLab.hemaglobinA1cData.append(labData)
            }
        //TSH
        case .TSH:
            do{
                labData.type = .TSH
                EndocrineManager.sharedManager.endocrineData.endocrineLab.TSHData.append(labData)
            }
        //microalbuminCreatinineRatio
        case .microalbuminCreatinineRatio:
            do{
                labData.type = .microalbuminCreatinineRatio
                EndocrineManager.sharedManager.endocrineData.endocrineLab.microalbuminCreatinineRatioData.append(labData)
            }
        //sodium
        case .sodium:
            do{
                labData.type = .sodium
                EndocrineManager.sharedManager.endocrineData.endocrineLab.sodiumData.append(labData)
            }
        //potassiumLevel
        case .potassiumLevel:
            do{
                labData.type = .potassiumLevel
                EndocrineManager.sharedManager.endocrineData.endocrineLab.potassiumLevelData.append(labData)
            }
        //BUN
        case .BUN:
            do{
                labData.type = .BUN
                EndocrineManager.sharedManager.endocrineData.endocrineLab.BUNData.append(labData)
            }
        //creatinine
        case .creatinine:
            do{
                labData.type = .creatinine
                EndocrineManager.sharedManager.endocrineData.endocrineLab.creatinineData.append(labData)
            }
        //chloride
        case .chloride:
            do{
                labData.type = .chloride
                EndocrineManager.sharedManager.endocrineData.endocrineLab.chlorideData.append(labData)
            }
            
        //calcium
        case .calcium:
            do{
                labData.type = .calcium
                EndocrineManager.sharedManager.endocrineData.endocrineLab.calciumData.append(labData)
            }
            
        //albumin
        case .albumin:
            do{
                labData.type = .albumin
                EndocrineManager.sharedManager.endocrineData.endocrineLab.albuminData.append(labData)
            }
        //anionGap
        case .anionGap:
            do{
                labData.type = .anionGap
                EndocrineManager.sharedManager.endocrineData.endocrineLab.anionGapData.append(labData)
            }
        //bloodGlucose
        case .bloodGlucose:
            do{
                labData.type = .bloodGlucose
                EndocrineManager.sharedManager.endocrineData.endocrineLab.bloodGlucoseData.append(labData)
            }
            
        default:
            break
        }
    }
}




