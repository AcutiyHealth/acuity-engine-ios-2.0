//
//  RespiratoryValue.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter


enum RespiratoryLabsType:String {
    case bloodOxygenLevel = "Blood oxygen level"
    case bicarbonate = "Bicarbonate"
    case PaO2 = "PaO2"
    case PaCO2 = "PaCO2"
    case HCO3 = "HCO3"
    case O2 = "O2"
}
enum RespiratoryConditionType:String {
    case COPD = "COPD"
    case asthma = "Asthma"
    case pneumonia = "pneumonia"
    case pulmonaryEmbolism = "pulmonary embolism"
    case allergicRhiniitis = "Allergic Rhiniitis"
    case smoking = "Smoking"
}

enum RespiratoryVitalsType:String {
    
    case respiratoryRate = "respiratoryRate"
    case supplementOxygen = "supplementOxygen"
    case biPAPOrcPAP = "biPAPOrcPAP"
    case heartRate = "heartRate"
    case irregularRhymesNotification = "irregularRhymesNotification"
    case highHeartRate = "highHeartRate"
    case lowHeartRate = "lowHeartRate"
    case peakFlowRate = "peakFlowRate"
    case sixMinWalk = "sixMinWalk"
    case fev1 = "fev1"
    case vo2Max = "vo2Max"
    case inhalerUsage = "inhalerUsage"
}

func RespiratorySymptomsReadValue() -> [CategoryType]{
    [CategoryType.chestTightnessOrPain,CategoryType.skippedHeartbeat,
     CategoryType.coughing,CategoryType.wheezing,
     CategoryType.rapidPoundingOrFlutteringHeartbeat,CategoryType.fainting,CategoryType.shortnessOfBreath
    ]
}

func RespiratoryIMPCategoryType()->[CategoryType]{
    [CategoryType.highHeartRateEvent, CategoryType.lowHeartRateEvent, CategoryType.irregularHeartRhythmEvent]
}

func RespiratoryIMPQuantityType() -> [QuantityType]{
    [QuantityType.vo2Max, QuantityType.heartRate, QuantityType.respiratoryRate,QuantityType.peakExpiratoryFlowRate,QuantityType.sixMinuteWalkTestDistance,QuantityType.forcedExpiratoryVolume1,QuantityType.inhalerUsage]
}

func RespiratoryLabDataeCategoryType() -> [QuantityType]{
    [QuantityType.oxygenSaturation,QuantityType.dietaryPotassium,QuantityType.dietaryMagnesium]
}
