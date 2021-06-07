//
//  MuscManager.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//


import Foundation
import HealthKit
import HealthKitReporter

class MuscManager: NSObject {
    
    
    static let sharedManager = MuscManager()
    
    //Initialize  data...
    var muscData = MuscData()
    
    override init() {
        //super.init()
        
    }
    //Reset Musc Data
    func resetMuscData(){
        muscData = MuscData()
    }
    
    //Save Vitals Data in muscVital Model
    func saveQuantityInArray(quantityType:QuantityType,element:Quantity) {
        /*
         Step Length
         body mass index
         */
        switch quantityType {
        case .walkingStepLength:
            do{
                let stepLength = MuscVitalsData(type: VitalsName.stepLength)
                stepLength.value = Double(element.harmonized.value)
                stepLength.startTimeStamp = element.startTimestamp
                self.muscData.muscVital.stepLengthData.append(stepLength)
                
            }
        case .bodyMassIndex:
            do{
                let BMI = MuscVitalsData(type: VitalsName.BMI)
                BMI.value = Double(element.harmonized.value)
                BMI.startTimeStamp = element.startTimestamp
                self.muscData.muscVital.BMIData.append(BMI)
            }
            
        default:
            break
        }
        
    }
    
    //Save Symptoms data in muscData model
    func saveSymptomsData(category:CategoryType,element:CategoryData){
        let symptomsData = MuscSymptomsPainData(type: category)
        symptomsData.value = Double(element.harmonized.value)
        symptomsData.startTimeStamp = element.startTimestamp
        symptomsData.endTimeStamp = element.endTimestamp
        
        switch category {
        //chestTightnessOrPain
        case .chestTightnessOrPain:
            MuscManager.sharedManager.muscData.muscSymptoms.chestPainData.append(symptomsData)
        //generalizedBodyAche
        case .generalizedBodyAche:
            MuscManager.sharedManager.muscData.muscSymptoms.bodyAcheData.append(symptomsData)
            
        //fatigue
        case .fatigue:
            MuscManager.sharedManager.muscData.muscSymptoms.fatigueData.append(symptomsData)
        //lowerBackPain
        case .lowerBackPain:
            MuscManager.sharedManager.muscData.muscSymptoms.lowerBackPainData.append(symptomsData)
            
        //moodChanges
        case .moodChanges:
            MuscManager.sharedManager.muscData.muscSymptoms.moodChangeData.append(symptomsData)
        //sleepChanges
        case .sleepChanges:
            MuscManager.sharedManager.muscData.muscSymptoms.sleepChangesData.append(symptomsData)
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
        let conditionData = MuscConditionData(type: conditionTypeData)
        conditionData.value = element.value.rawValue
        
        switch conditionType {
        //muscularSprain
        case .muscularSprain:
            MuscManager.sharedManager.muscData.muscCondition.muscularSprainData.append(conditionData)
        //osteoporosis
        case .osteoporosis:
            MuscManager.sharedManager.muscData.muscCondition.osteoporosisData.append(conditionData)
        //osteoarthritis
        case .osteoarthritis:
            MuscManager.sharedManager.muscData.muscCondition.osteoarthritisData.append(conditionData)
        //rheumatoidArthritis
        case .rheumatoidArthritis:
            MuscManager.sharedManager.muscData.muscCondition.rheumatoidArthritisData.append(conditionData)
        //Gout
        case .Gout:
            MuscManager.sharedManager.muscData.muscCondition.GoutData.append(conditionData)
        //HxOfStroke
        case .HxOfStroke:
            MuscManager.sharedManager.muscData.muscCondition.HxOfStrokeData.append(conditionData)
        //neuropathy
        case .neuropathy:
            MuscManager.sharedManager.muscData.muscCondition.neuropathyData.append(conditionData)
        default:
            break
        }
    }
    //MARK: Save Lab Data
    func saveLabData(code:String,value:Double,timeStamp:Double){
        let labCodeConstant = LabCodeConstant(rawValue: code)
        
        //Create Lab Model Object
        let labData = MuscLabData()
        labData.value = value
        labData.startTimeStamp = timeStamp
        
        switch labCodeConstant {
        /*
         Alkaline Phosphatase
         Potassium level
         chloride
         Calcium
         ESR
         */
        //alkalinePhosphatase
        case .alkalinePhosphatase:
            do{
                labData.type = .alkalinePhosphatase
                MuscManager.sharedManager.muscData.muscLab.alkalinePhosphataseData.append(labData)
            }
        //potassiumLevel
        case .potassiumLevel:
            do{
                labData.type = .potassiumLevel
                MuscManager.sharedManager.muscData.muscLab.potassiumLevelData.append(labData)
            }
        //chloride
        case .chloride:
            do{
                labData.type = .chloride
                MuscManager.sharedManager.muscData.muscLab.chlorideData.append(labData)
            }
        //calcium
        case .calcium:
            do{
                labData.type = .calcium
                MuscManager.sharedManager.muscData.muscLab.calciumData.append(labData)
            }
        //ESR
        case .ESR:
            do{
                labData.type = .ESR
                MuscManager.sharedManager.muscData.muscLab.ESRData.append(labData)
            }
        default: break
        }
    }
    
}
