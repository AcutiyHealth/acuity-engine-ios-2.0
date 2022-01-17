//
//  CardioManager.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 03/02/21.
//


import Foundation
import HealthKit
import HealthKitReporter

class CardioManager: NSObject {
    
    
    static let sharedManager = CardioManager()
    private var reporter: HealthKitReporter?
    
    //Initialize cardio data...
    var cardioData = CardioData()
    var totalSum:Double = 0
    var coun:Int = 0
    private lazy var heartRateType: HKQuantityType? = HKObjectType.quantityType(forIdentifier: .heartRate)
    
    override init() {
        //super.init()
        
    }
    
    func resetCardioData(){
        
        cardioData = CardioData()
    }
    //Save Vitals Data in genitourinaryVital Model
    func saveStatasticsInArray(quantityType:QuantityType,element:Statistics) {
        switch quantityType {
        case .stepCount:
            do{
                guard let value = element.harmonized.summary  else {
                    return
                }
                let stepCount = CardioVitalsData(type: VitalsName.steps)
                let newValue = Double(value)
                stepCount.value = newValue
                stepCount.startTimeStamp = element.startTimestamp
                self.cardioData.cardioVital.stepsData.append(stepCount)
                Log.d("Cardio stepCount=======\(stepCount.value) maxScoreVitals===\(stepCount.score) ")
            }
        case .dietaryWater:
            do{
                guard let value = element.harmonized.summary  else {
                    return
                }
                let waterIntake = CardioVitalsData(type: VitalsName.waterIntake)
                let newValue = Double(value)
                waterIntake.value = newValue
                waterIntake.startTimeStamp = element.startTimestamp
                self.cardioData.cardioVital.waterIntakeData.append(waterIntake)
            }
        default:break
        }
    }
    //MARK: saveVitals
    func saveQuantityInArray(quantityType:QuantityType,element:Quantity) {
        
        switch quantityType {
        case .bloodPressureSystolic:
            do{
                
                let systolicBP = CardioVitalsData(type: VitalsName.bloodPressureSystolic)
                systolicBP.value = Double(element.harmonized.value)
                systolicBP.startTimeStamp = element.startTimestamp
                self.cardioData.cardioVital.systolicBloodPressureData.append(systolicBP)
                
            }
        case .bloodPressureDiastolic:
            do{
                
                let diastolicBP = CardioVitalsData(type: VitalsName.bloodPressureDiastolic)
                diastolicBP.value = Double(element.harmonized.value)
                diastolicBP.startTimeStamp = element.startTimestamp
                //print("diastolicBP date",getDateMediumFormat(time: diastolicBP.startTimeStamp))
                self.cardioData.cardioVital.diastolicBloodPressureData.append(diastolicBP)
                
            }
        case .vo2Max:
            do{
                
                let vo2Max = CardioVitalsData(type: VitalsName.vo2Max)
                vo2Max.value = Double(element.harmonized.value)
                vo2Max.startTimeStamp = element.startTimestamp
                self.cardioData.cardioVital.vO2MaxData.append(vo2Max)
                
            }
        case .heartRate:
            do{
                
                let heartRate = CardioVitalsData(type: VitalsName.heartRate)
                heartRate.value = Double(element.harmonized.value)
                heartRate.startTimeStamp = element.startTimestamp
                self.cardioData.cardioVital.heartRateData.append(heartRate)
                
                //print("---------\n HeartRateData \nValue \(heartRate.value)\n Score \(heartRate.score)\n Max Score\(heartRate.maxScore ?? 0.0) \n---------")
            }
        case .oxygenSaturation:
            do{
                /*
                 Multiply value with 100 because we get oxygen saturation value in Float from health app. Oxygen saturation 1- 100 will get 0.1-1 from health app
                 */
                let oxygenSaturation = CardioVitalsData(type: VitalsName.oxygenSaturation)
                let newValue = Double(element.harmonized.value) * 100
                oxygenSaturation.value = newValue
                oxygenSaturation.startTimeStamp = element.startTimestamp
                self.cardioData.cardioVital.oxygenSaturationData.append(oxygenSaturation)
                
                //print("---------\n HeartRateData \nValue \(heartRate.value)\n Score \(heartRate.score)\n Max Score\(heartRate.maxScore ?? 0.0) \n---------")
            }
        case .stepCount:
            do{
                
                let stepCount = CardioVitalsData(type: VitalsName.steps)
                let newValue = Double(element.harmonized.value)
                stepCount.value = newValue
                stepCount.startTimeStamp = element.startTimestamp
                self.cardioData.cardioVital.stepsData.append(stepCount)
                Log.d("Cardio stepCount=======\(stepCount.value) maxScoreVitals===\(stepCount.score) ")
            }
            
         
        default:
            break;
        }
        
    }
    
    func saveCategoryData(categoryType:CategoryType,value:Double,startTimeStamp:Double,endTimeStamp:Double){
        
        /*if categoryType == CategoryType.highHeartRateEvent {
         
         let highHeartRate = CardioVitalsData(type: VitalsName.highHeartRate)
         highHeartRate.value = 1
         highHeartRate.startTimeStamp = startTimeStamp
         highHeartRate.endTimeStamp = endTimeStamp
         self.cardioData.cardioVital.highHeartRateData.append(highHeartRate)
         
         
         } else  if categoryType == CategoryType.lowHeartRateEvent {
         
         let lowHeartRate = CardioVitalsData(type: VitalsName.lowHeartRate)
         lowHeartRate.value = 1
         lowHeartRate.startTimeStamp = startTimeStamp
         lowHeartRate.endTimeStamp = endTimeStamp
         self.cardioData.cardioVital.lowHeartRateData.append(lowHeartRate)
         
         
         } else*/
        switch categoryType {
        case .irregularHeartRhythmEvent:
            do{
                
                let irregularRhymesNotification = CardioVitalsData(type: VitalsName.irregularRhymesNotification)
                irregularRhymesNotification.value = 1
                irregularRhymesNotification.startTimeStamp = startTimeStamp
                irregularRhymesNotification.endTimeStamp = endTimeStamp
                self.cardioData.cardioVital.irregularRhythmNotificationData.append(irregularRhymesNotification)
                
            }
        case .sleepAnalysis:
            do{
                
                let sleep = CardioVitalsData(type: VitalsName.sleep)
                sleep.value = value
                sleep.startTimeStamp = startTimeStamp
                sleep.endTimeStamp = endTimeStamp
                self.cardioData.cardioVital.sleepData.append(sleep)
                Log.d("Cardio sleep=======\(sleep.value) sleep===\(sleep.score) ")
            }
        default:
            break
        }
        
    }
    //MARK: saveSymptomsData
    func saveSymptomsData(category:CategoryType,element:CategoryData){
        
        let chestPainData = CardioSymptomsPainData(type: category)
        chestPainData.value = Double(element.harmonized.value)
        chestPainData.startTimeStamp = element.startTimestamp
        chestPainData.endTimeStamp = element.endTimestamp
        
        switch category {
        case .chestTightnessOrPain:
            CardioManager.sharedManager.cardioData.cardioSymptoms.chestPainData.append(chestPainData)
        case .skippedHeartbeat:
            CardioManager.sharedManager.cardioData.cardioSymptoms.skippedHeartBeatData.append(chestPainData)
        case .dizziness:
            CardioManager.sharedManager.cardioData.cardioSymptoms.dizzinessData.append(chestPainData)
        case .fatigue:
            CardioManager.sharedManager.cardioData.cardioSymptoms.fatigueData.append(chestPainData)
        case .rapidPoundingOrFlutteringHeartbeat:
            CardioManager.sharedManager.cardioData.cardioSymptoms.rapidHeartBeatData.append(chestPainData)
        case .fainting:
            CardioManager.sharedManager.cardioData.cardioSymptoms.faintingData.append(chestPainData)
        case .nausea:
            CardioManager.sharedManager.cardioData.cardioSymptoms.nauseaData.append(chestPainData)
        case .vomiting:
            CardioManager.sharedManager.cardioData.cardioSymptoms.vomitingData.append(chestPainData)
        case .memoryLapse:
            CardioManager.sharedManager.cardioData.cardioSymptoms.memoryLapseData.append(chestPainData)
        case .shortnessOfBreath:
            CardioManager.sharedManager.cardioData.cardioSymptoms.shortBreathData.append(chestPainData)
        case .headache:
            CardioManager.sharedManager.cardioData.cardioSymptoms.headacheData.append(chestPainData)
        case .heartburn:
            CardioManager.sharedManager.cardioData.cardioSymptoms.heartBurnData.append(chestPainData)
        case .sleepChanges:
            CardioManager.sharedManager.cardioData.cardioSymptoms.sleepChangesData.append(chestPainData)
        default:
            break
        }
        
        //print("---------\n CardioChestPainData element.harmonized \(element)")
        
        print("---------\n CardioChestPainData \n category \(category) \n Value \(chestPainData.value)\n Score \(chestPainData.score)\n Max Score\(chestPainData.maxScore ) \n---------")
        
        
    }
    
    //MARK: saveConditions
    
    func saveConditionsData(element:ConditionsModel){
        let conditionType = ConditionType(rawValue: element.title!)
        guard let conditionTypeData = conditionType else {
            return
        }
        let conditionData = CardioConditionData(type: conditionTypeData)
        conditionData.value = element.value.rawValue
        conditionData.startTimeStamp = element.startTime
        
        switch conditionType {
        case .hypertension:
            CardioManager.sharedManager.cardioData.cardioCondition.hyperTenstionData.append(conditionData)
        case .arrhythmia:
            CardioManager.sharedManager.cardioData.cardioCondition.arrhythmiaData.append(conditionData)
        case .heartFailure:
            CardioManager.sharedManager.cardioData.cardioCondition.heartFailureData.append(conditionData)
        case .hyperlipidemia:
            CardioManager.sharedManager.cardioData.cardioCondition.hyperLipidemiaData.append(conditionData)
        case .anemia:
            CardioManager.sharedManager.cardioData.cardioCondition.anemiaData.append(conditionData)
        case .diabetes:
            CardioManager.sharedManager.cardioData.cardioCondition.diabetesData.append(conditionData)
        case .coronaryArteryDisease:
            CardioManager.sharedManager.cardioData.cardioCondition.arteryDieseaseData.append(conditionData)
        default:
            break
        }
        
    }
    
    //MARK: Save Lab Data
    func saveLabData(code:String,value:Double,timeStamp:Double){
        let labCodeConstant = LabCodeConstant(rawValue: code)
        
        //Create Lab Model Object
        let labData = CardioLabData()
        labData.value = value
        labData.startTimeStamp = timeStamp
        
        switch labCodeConstant {
        case .potassiumLevel:
            do{
                labData.type = .potassiumLevel
                CardioManager.sharedManager.cardioData.cardioLab.potassiumLevelData.append(labData)
            }
        case .sodium:
            do{
                labData.type = .sodium
                CardioManager.sharedManager.cardioData.cardioLab.sodiumData.append(labData)
            }
        case .chloride:
            do{
                labData.type = .chloride
                CardioManager.sharedManager.cardioData.cardioLab.chlorideData.append(labData)
            }
        case .albumin:
            do{
                labData.type = .albumin
                CardioManager.sharedManager.cardioData.cardioLab.albuminData.append(labData)
            }
        case .microalbuminCreatinineRatio:
            do{
                labData.type = .microalbuminCreatinineRatio
                CardioManager.sharedManager.cardioData.cardioLab.microalbuminData.append(labData)
            }
        case .bPeptide:
            do{
                labData.type = .bPeptide
                CardioManager.sharedManager.cardioData.cardioLab.bPeptideData.append(labData)
            }
        case .hemoglobin:
            do{
                labData.type = .hemoglobin
                CardioManager.sharedManager.cardioData.cardioLab.hemoglobinData.append(labData)
            }
        default:
            break
        }
    }
}


