//
//  SDHManager.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//


import Foundation
import HealthKit
import HealthKitReporter

class SDHManager: NSObject {
    
    
    static let sharedManager = SDHManager()
    
    //Initialize  data...
    var sdhData = SDHData()
    
    override init() {
        //super.init()
        
    }
    //Reset SDH Data
    func resetSDHData(){
        sdhData = SDHData()
    }
    
    //Save Vitals Data in sdhVital Model
    func saveQuantityInArray(quantityType:QuantityType,element:Quantity) {
        /*
         S Blood pressure
         D Blood pressure
         Age
         body mass index
         Oxygen saturation
         */
        switch quantityType {
        case .bloodPressureSystolic:
            do{
                let systolicBP = SDHVitalsData(type: VitalsName.bloodPressureSystolic)
                systolicBP.value = Double(element.harmonized.value)
                systolicBP.startTimeStamp = element.startTimestamp
                self.sdhData.sdhVital.systolicBloodPressureData.append(systolicBP)
                
            }
        case .bloodPressureDiastolic:
            do{
                let diastolicBP = SDHVitalsData(type: VitalsName.bloodPressureDiastolic)
                diastolicBP.value = Double(element.harmonized.value)
                diastolicBP.startTimeStamp = element.startTimestamp
                self.sdhData.sdhVital.diastolicBloodPressureData.append(diastolicBP)
            }
            
        case .oxygenSaturation:
            do{
               
                /*
                 Multiply value with 100 because we get oxygen saturation value in Float from health app. Oxygen saturation 1- 100 will get 0.1-1 from health app
                 */
                let oxygenSaturation = SDHVitalsData(type: VitalsName.oxygenSaturation)
                let newValue = Double(element.harmonized.value) * 100
                oxygenSaturation.value = newValue
                oxygenSaturation.startTimeStamp = element.startTimestamp
                self.sdhData.sdhVital.oxygenSaturationData.append(oxygenSaturation)
            }
        case .bodyMassIndex:
            do{
                let BMI = SDHVitalsData(type: VitalsName.BMI)
                BMI.value = Double(element.harmonized.value)
                BMI.startTimeStamp = element.startTimestamp
                self.sdhData.sdhVital.BMIData.append(BMI)
            }
        case .stepCount:
            do{
                let steps = SDHVitalsData(type: VitalsName.steps)
                steps.value = Double(element.harmonized.value)
                steps.startTimeStamp = element.startTimestamp
                self.sdhData.sdhVital.stepsData.append(steps)
            }
        case .dietaryWater:
            do{
                let waterIntake = SDHVitalsData(type: VitalsName.waterIntake)
                waterIntake.value = Double(element.harmonized.value)
                waterIntake.startTimeStamp = element.startTimestamp
                self.sdhData.sdhVital.waterIntakeData.append(waterIntake)
            }
        default:
            break
        }
        
    }
    
    func saveCategoryData(categoryType:CategoryType,value:Double,startTimeStamp:Double,endTimeStamp:Double){
        
        if categoryType == CategoryType.sleepAnalysis {
            
            let sleep = SDHVitalsData(type: VitalsName.sleep)
            sleep.value = value
            sleep.startTimeStamp = startTimeStamp
            sleep.endTimeStamp = endTimeStamp
            self.sdhData.sdhVital.sleepData.append(sleep)
         
        }
    }
    //Save Vitals Data in sdhVital Model
    func saveAgeCharactesticInArray(element:Double) {
        let age = SDHVitalsData(type: VitalsName.age)
        age.value = element
        age.startTimeStamp = MyWellScore.sharedManager.todaysDate.timeIntervalSince1970
        self.sdhData.sdhVital.ageData.append(age)
    }
    //Save Symptoms data in sdhData model
    func saveSymptomsData(category:CategoryType,element:CategoryData){
        let symptomsData = SDHSymptomsPainData(type: category)
        symptomsData.value = Double(element.harmonized.value)
        symptomsData.startTimeStamp = element.startTimestamp
        symptomsData.endTimeStamp = element.endTimestamp
        
        switch category {
        //chestTightnessOrPain
        case .chestTightnessOrPain:
            SDHManager.sharedManager.sdhData.sdhSymptoms.chestPainData.append(symptomsData)
        //dizziness
        case .dizziness:
            SDHManager.sharedManager.sdhData.sdhSymptoms.dizzinessData.append(symptomsData)
            
        //fatigue
        case .fatigue:
            SDHManager.sharedManager.sdhData.sdhSymptoms.fatigueData.append(symptomsData)
        //rapidHeartBeat
        case .rapidPoundingOrFlutteringHeartbeat:
            SDHManager.sharedManager.sdhData.sdhSymptoms.rapidHeartBeatData.append(symptomsData)
            
        //memoryLapse
        case .memoryLapse:
            SDHManager.sharedManager.sdhData.sdhSymptoms.memoryLapseData.append(symptomsData)
        //shortnessOfBreath
        case .shortnessOfBreath:
            SDHManager.sharedManager.sdhData.sdhSymptoms.shortnessOfBreathData.append(symptomsData)
            
        //headache
        case .headache:
            SDHManager.sharedManager.sdhData.sdhSymptoms.headacheData.append(symptomsData)
        //sleepChanges
        case .sleepChanges:
            SDHManager.sharedManager.sdhData.sdhSymptoms.sleepChangesData.append(symptomsData)
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
        let conditionData = SDHConditionData(type: conditionTypeData)
        conditionData.value = element.value.rawValue
        conditionData.startTimeStamp = element.startTime
        
        switch conditionType {
        //single
        case .single:
            SDHManager.sharedManager.sdhData.sdhCondition.singleData.append(conditionData)
        //sedintaryLifestyle
        case .sedintaryLifestyle:
            SDHManager.sharedManager.sdhData.sdhCondition.sedintaryLifestyleData.append(conditionData)
        //unsafeHousing
        case .unsafeHousing:
            SDHManager.sharedManager.sdhData.sdhCondition.unsafeHousingData.append(conditionData)
        //overweightOrObesity
        case .overweightOrObesity:
            SDHManager.sharedManager.sdhData.sdhCondition.overweightData.append(conditionData)
        //unemployed
        case .unemployed:
            SDHManager.sharedManager.sdhData.sdhCondition.unemployedData.append(conditionData)
        //smoking
        case .smoking:
            SDHManager.sharedManager.sdhData.sdhCondition.smokingData.append(conditionData)
        //diabetes
        case .diabetes:
            SDHManager.sharedManager.sdhData.sdhCondition.diabetesData.append(conditionData)
        default:
            break
        }
    }
    //MARK: Save Lab Data
    func saveLabData(code:String,value:Double,timeStamp:Double){
        let labCodeConstant = LabCodeConstant(rawValue: code)
        
        //Create Lab Model Object
        let labData = SDHLabData()
        labData.value = value
        labData.startTimeStamp = timeStamp
        
        switch labCodeConstant {
        /*
         Albumin Level
         BUN
         creatinine
         Hemaglobin
         */
        //albumin
        case .albumin:
            do{
                labData.type = .albumin
                SDHManager.sharedManager.sdhData.sdhLab.albuminLevelData.append(labData)
            }
        //BUN
        case .BUN:
            do{
                labData.type = .BUN
                SDHManager.sharedManager.sdhData.sdhLab.BUNData.append(labData)
            }
        //creatinine
        case .creatinine:
            do{
                labData.type = .creatinine
                SDHManager.sharedManager.sdhData.sdhLab.creatinineData.append(labData)
            }
        //hemoglobin
        case .hemoglobin:
            do{
                labData.type = .hemoglobin
                SDHManager.sharedManager.sdhData.sdhLab.hemaglobinData.append(labData)
            }
        default: break
        }
    }
    
}
