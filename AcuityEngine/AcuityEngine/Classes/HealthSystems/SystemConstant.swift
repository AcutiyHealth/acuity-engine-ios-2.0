//
//  CardioValue.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/02/21.
//

import Foundation
import HealthKitReporter
import HealthKit

enum SymptomsSleepChangeValue:Double {
    case Present = 1
    case Not_Present = 0
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

func CardioLabDataSampleType()->[HKSampleType]{
    [
        
        HKObjectType.clinicalType(forIdentifier: .labResultRecord)!,
        
    ]
}

enum ConditionType:String {
    case allergicRhiniitis = "Allergic Rhiniitis"
    case asthma = "COPD/Asthma"
    case anemia = "Anemia"
    case arteryDisease = "Coronary Artery Disease/Peripheral Vascular Disease"
    case arrhythmia  = "Arrhythmia"
    case covid = "Covid"
    case coronaryArteryDisease = "Coronary Artery Disease"
    case cellulitis = "Cellulitis"
    case cancer = "Cancer"
    case diabetes = "Diabetes"
    case electrolyteDisorders = "Electrolyte Disorders"
    case gastroentritis = "Gastroentritis"
    case heartFailure = "Congestive Heart Failure"
    case hypertension = "Hypertension"
    case hyperlipidemia = "Hyperlipidemia"
    case hormoneProblems = "Hormone Problems"
    case kidneyDiease = "Kidney Disease"
    case kidneyStones = "Kidney Stones"
    case otitis = "Otitis"
    case overweightOrObesity = "Overweight/Obesity"
    case otherHematoProblem = "Other Heme/Onc Problem"
    case pneumonia = "Bronchitis/pneumonia"
    case polycysticOvarianDisease = "Polycystic Ovarian Disease"
    case UTI = "UTI"
    case respiratoryInfection = "Upper Respiratory Infection"
    case smoking = "Smoking"
    case thyroidDisorder = "Thyroid Disorder"
    case sleepApnea = "Sleep Apnea"
    case underweightOrMalnutrition = "Underweight/Malnutrition"
}

enum LabType:String {
    case anionGap = "Anion gap"
    case albumin = "Albumin"
    case alkalinePhosphatase = "Alkaline Phosphatase"
    case AST  = "AST"
    case ALT  = "ALT"
    case bPeptide = "B-peptide"
    case bloodGlucose = "Blood Glucose"
    case b12Level = "B12 Level"
    case BUN = "BUN (mg/dL)"
    case carbonDioxidemEqL = "Carbon Dioxide (CMP) mEq/L"
    case creatinine = "Creatinine"
    case carbonDioxide = "Carbon Dioxide"
    case chloride = "Chloride"
    case calcium = "Calcium"
    case eGFR = "eGFR"
    case hemoglobin = "Hemoglobin"
    case hemoglobinA1C = "Hemoglobin A1c"
    case microalbuminCreatinineRatio = "Microalbumin/Creatinine ratio"
    case MCV  = "MCV"
    case neutrophil = "Neutrophil %"
    case platelets = "Platelets"
    case potassiumLevel = "Potassium Level"
    case sodium = "Sodium"
    case TSH = "TSH"
    case urineNitrites = "Urine Nitrites"
    case urineBlood  = "Urine Blood"
    case urineKetone  = "Urine Ketone"
    case WBC = "WBC's"
}

