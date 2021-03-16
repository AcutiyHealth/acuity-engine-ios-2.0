//
//  CardioValue.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
import HealthKit

enum CardioSymptomsSleepChangeValue:Double {
    case Present = 1
    case Not_Present = 0
}

enum CardioLabsType:String {
    case bloodOxygenLevel = "Blood oxygen level"
    case potassiumLevel = "Potassium level"
    case magnesiumLevel = "Magnesium level"
    case bPeptide = "B-peptide"
    case troponinLevel = "Troponin Level"
    case hemoglobin = "Hemoglobin"
    
}

enum CardioConditionType:String {
    case hypertension = "hypertension"
    case arrhythmia  = "Arrhythmia "
    case heartFailure = "heartFailure"
    case arteryDisease = "arteryDisease"
}


enum CardioVitalsType:String {
    case heartRate = "heartRate"
    case systolicBP = "systolicBP"
    case diastolicBP = "diastolicBP"
    case highHeartRate = "highHeartRate"
    case lowHeartRate = "lowHeartRate"
    case vo2Max = "vo2Max"
    case irregularRhymesNotification = "irregularRhymesNotification"
}

func CardioSymptomsReadValue() -> [CategoryType]{
    [CategoryType.chestTightnessOrPain,CategoryType.skippedHeartbeat,
     CategoryType.dizziness,CategoryType.fatigue,
     CategoryType.rapidPoundingOrFlutteringHeartbeat,CategoryType.fainting,
     CategoryType.nausea,CategoryType.vomiting,
     CategoryType.memoryLapse,CategoryType.shortnessOfBreath,
     CategoryType.headache,CategoryType.heartburn, CategoryType.sleepChanges
    ]
}

func CardioHeartCategoryType()->[CategoryType]{
    [CategoryType.highHeartRateEvent, CategoryType.lowHeartRateEvent, CategoryType.irregularHeartRhythmEvent]
}

func CardioBloodPressureCategoryType() -> [QuantityType]{
    [QuantityType.bloodPressureSystolic, QuantityType.bloodPressureDiastolic, QuantityType.vo2Max, QuantityType.heartRate]
}

func CardioLabDataeCategoryType() -> [QuantityType]{
    [QuantityType.oxygenSaturation,QuantityType.dietaryPotassium,QuantityType.dietaryMagnesium]
}
func CardioLabDataSampleType()->[HKSampleType]{
    [
        
        HKObjectType.clinicalType(forIdentifier: .labResultRecord)!,
        
    ]
}

