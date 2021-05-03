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

enum ConditionType:String,CaseIterable {
    case allergicRhiniitis = "Allergic Rhnitis"
    case asthma = "COPD/Asthma"
    case anemia = "Anemia"
    case arrhythmia  = "Arrhythmia"
    case bipolarDisorder = "Bipolar Disorder"
    case covid = "Covid"
    case coronaryArteryDisease = "Coronary Artery Disease/Peripheral Vascular Disease"
    case cellulitis = "Cellulitis"
    case cancer = "Cancer"
    case diabetes = "Diabetes"
    case decreasedVision = "Decreased Vision"
    case depressionAnxiety = "Depression/Anxiety"
    case electrolyteDisorders = "Electrolyte Disorders"
    case gastroentritis = "Gastroentritis"
    case GERD = "GERD"
    case Gout = "Gout"
    case heartFailure = "Congestive Heart Failure"
    case hypertension = "Hypertension"
    case hyperlipidemia = "Hyperlipidemia"
    case HxOfStroke = "Hx Of Stroke"
    case hormoneProblems = "Hormone Problems"
    case hearingLoss = "Hearing Loss"
    case irritableBowelDisease = "Irritable Bowel Disease"
    case kidneyDiease = "Kidney Disease"
    case kidneyStones = "Kidney Stones"
    case liverDisease = "Liver Disease"
    case neuropathy = "Neuropathy"
    case otitis = "Otitis"
    case overweightOrObesity = "Overweight/Obesity"
    case otherHematoProblem = "Other Heme/Onc Problem"
    case pneumonia = "Bronchitis/pneumonia"
    case psoriasisEczema = "Psoriasis/Eczema"
    case polycysticOvarianDisease = "Polycystic Ovarian Disease"
    case rheumatoidArthritis = "Rheumatoid Arthritis"
    case respiratoryInfection = "Upper Respiratory Infection"
    case smoking = "Smoking"
    case single = "Single"
    case sedintaryLifestyle = "Sedintary Lifestyle"
    case thyroidDisorder = "Thyroid Disorder"
    case sleepApnea = "Sleep Apnea"
    case underweightOrMalnutrition = "Underweight/Malnutrition"
    case ulcerativeColitis = "Ulcerative Colitis"
    case unemployed = "Unemployed"
    case unsafeHousing = "Unsafe Housing"
    case urinaryProblems = "Urinary Problems"
    case UTI = "UTI"
    
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

