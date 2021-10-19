//
//  ConditionsModel.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 04/03/21.
//

import Foundation
import HealthKit

class ConditionsModel {
    
    var id:Int = 0
    var title: String?
    var isOn: Bool?
    var value:ConditionValue = .No
    var color: UIColor = ChartColor.GREENCOLOR
    var startTime: Double = 0
    var endTime: Double = 0
    var textValue: String = ConditionValueText.No.rawValue
    init(title:String,value:ConditionValue,conditionId:Int) {
        self.title = title
        self.value = value
        isOn = value.rawValue == 1 ? true : false
        self.id = conditionId
    }
    init(title:String,value:ConditionValue) {
        self.title = title
        self.value = value
        if value == ConditionValue.Yes{
            color = ChartColor.REDCOLOR
            textValue = ConditionValueText.Yes.rawValue
        }
    }
}

class SymptomsModel {
    
    var title: String?
    var value: SymptomsValue?
    var textValue: SymptomsTextValue?
    var startTime: Double = 0
    var endTime: Double = 0
    var color: UIColor = ChartColor.GREENCOLOR
    init(title:String,textValue:SymptomsTextValue,startTime:Double,endTime:Double) {
        self.title = title
        self.textValue = textValue
        self.startTime = startTime
        self.endTime = endTime
    }
    init(title:String,value:SymptomsValue) {
        self.title = title
        self.value = value
        switch value {
        case .Mild:
            do {
                self.textValue = SymptomsTextValue.Mild
                color = ChartColor.YELLOWCOLOR
            }
        case .Severe:
            do{
                self.textValue = SymptomsTextValue.Severe
                color = ChartColor.REDCOLOR
            }
        case .Present:
            do{
                self.textValue = SymptomsTextValue.Present
                color = ChartColor.YELLOWCOLOR
            }
        case .Not_Present:
            do{
                self.textValue = SymptomsTextValue.Not_Present
                color = ChartColor.GREENCOLOR
            }
        case .Moderate:
            do{
                self.textValue = SymptomsTextValue.Moderate
                color = ChartColor.REDCOLOR
            }
        }
    }
}
class LabModel {
    
    var title: String?
    var value: String?
    var startTime: Double = 0
    var endTime: Double = 0
    var color: UIColor = ChartColor.GREENCOLOR
    
    init(title:String,value:String) {
        self.title = title
        self.value = value
        
    }
    
}
class VitalsModel {
    
    var title: String?
    var value: String?
    var startTime: Double = 0
    var endTime: Double = 0
    var color: UIColor = ChartColor.GREENCOLOR
    
    //For BP model
    var isBPModel:Bool = false
    var colorForDiastolic: UIColor = ChartColor.GREENCOLOR
    var valueForDiastolic: String?
    init() {
        
    }
    init(title:String,value:String) {
        self.title = title
        self.value = value
        
    }
    init(title:String,value:String,isBPModel:Bool,valueForDiastolic:String,colorForDiastolic:UIColor) {
        self.title = title
        self.value = value
        self.isBPModel = isBPModel
        self.valueForDiastolic = valueForDiastolic
        self.colorForDiastolic = colorForDiastolic
    }
}
class Symptoms {
    
    var title: SymptomsName?
    var healthCategoryType: HKCategoryTypeIdentifier?
    init(title:SymptomsName) {
        self.title = title
        getObjectType(name: (self.title ?? SymptomsName(rawValue: ""))!)
    }
    func getObjectType(name:SymptomsName){
        
        switch name {
        case .abdominal_Cramps: do {
            healthCategoryType =  .abdominalCramps
        }
        case .acne: do {
            healthCategoryType = .acne
        }
        case .bladder_Incontinence: do {
            if #available(iOS 14.0, *) {
                healthCategoryType = .bladderIncontinence
            }
            break
        }
        case .bloating: do {
            healthCategoryType = .bloating
        }
        case .body_Ache: do {
            healthCategoryType = .generalizedBodyAche
        }
        case .chestPain: do {
            healthCategoryType = .chestTightnessOrPain
        }
        case .chills: do {
            healthCategoryType = .chills
        }
        case .constipation:
            healthCategoryType = .constipation
        case .cough:
            healthCategoryType = .coughing
            
        case .diarrhea:
            healthCategoryType = .diarrhea
            
        case .dizziness:
            healthCategoryType = .dizziness
            
        case .drySkin:
            if #available(iOS 14.0, *) {
                healthCategoryType = .drySkin
            }
            break
        case .fainting:
            healthCategoryType = .fainting
        case .fever:
            healthCategoryType = .fever
        case .hairLoss:
            if #available(iOS 14.0, *) {
                healthCategoryType = .hairLoss
            }
            break
        case .headache:
            healthCategoryType = .headache
        case .heartburn:
            healthCategoryType = .heartburn
        case .hotFlashes:
            healthCategoryType = .hotFlashes
        case .lossOfSmell:
            healthCategoryType = .lossOfSmell
        case .lowerBackPain:
            healthCategoryType = .lowerBackPain
        case .memoryLapse:
            if #available(iOS 14.0, *) {
                healthCategoryType = .memoryLapse
            }
            break
        case .moodChanges:
            healthCategoryType = .moodChanges
        case .nausea:
            healthCategoryType = .nausea
        case .rapidHeartbeat:
            healthCategoryType = .rapidPoundingOrFlutteringHeartbeat
        case .runnyNose:
            healthCategoryType = .runnyNose
        case .shortnessOfBreath:
            healthCategoryType = .shortnessOfBreath
        case .skippedHeartBeat:
            healthCategoryType = .skippedHeartbeat
        case .sleepChanges:
            healthCategoryType = .sleepChanges
        case .soreThroat:
            healthCategoryType = .soreThroat
        case .vomiting:
            healthCategoryType = .vomiting
        case .fatigue:
            healthCategoryType = .fatigue
            
        }
        
    }
}
func getSymptomsArray()->[SymptomsName]{
    var arrayOfSymptoms = [SymptomsName.abdominal_Cramps,
                           SymptomsName.acne,
                           SymptomsName.bloating,
                           SymptomsName.body_Ache,
                           SymptomsName.chestPain,
                           SymptomsName.chills,
                           SymptomsName.constipation,
                           SymptomsName.cough,
                           SymptomsName.diarrhea,
                           SymptomsName.dizziness,
                           SymptomsName.fainting,
                           SymptomsName.fatigue,
                           SymptomsName.fever,
                           SymptomsName.headache,
                           SymptomsName.heartburn,
                           SymptomsName.hotFlashes,
                           SymptomsName.lossOfSmell,
                           SymptomsName.lowerBackPain,
                           SymptomsName.moodChanges,
                           SymptomsName.nausea,
                           SymptomsName.rapidHeartbeat,
                           SymptomsName.runnyNose,
                           SymptomsName.shortnessOfBreath,
                           SymptomsName.skippedHeartBeat,
                           SymptomsName.sleepChanges,
                           SymptomsName.soreThroat,
                           SymptomsName.vomiting]
    
    if #available(iOS 14.0, *) {
        arrayOfSymptoms.append(SymptomsName.bladder_Incontinence)
        arrayOfSymptoms.append(SymptomsName.drySkin)
        arrayOfSymptoms.append(SymptomsName.hairLoss)
        arrayOfSymptoms.append(SymptomsName.memoryLapse)
    }
    
    return arrayOfSymptoms.sorted{ $0.rawValue < $1.rawValue }
}





