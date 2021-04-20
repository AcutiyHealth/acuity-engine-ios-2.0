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
    case coronaryArteryDisease = "Coronary artery disease"
    case cellulitis = "cellulitis"
    case diabetes = "Diabetes"
    case electrolyteDisorders = "electrolyte disorders"
    case gastroentritis = "Gastroentritis"
    case heartFailure = "Congestive heart failure"
    case hypertension = "hypertension"
    case hyperlipidemia = "Hyperlipidemia"
    case kidneyDiease = "kidney disease"
    case kidneyStones = "kidney stones"
    case otitis = "Otitis"
    case overweightOrObesity = "Overweight/Obesity"
    case pneumonia = "Bronchitis/pneumonia"
    case UTI = "UTI"
    case respiratoryInfection = "Upper respiratory infection"
    case smoking = "Smoking"
    case sleepApnea = "sleep apnea"
    case underweightOrMalnutrition = "underweight/malnutrition"
}

enum LabType:String {
    case anionGap = "Anion gap"
    case albumin = "Albumin"
    case AST  = "AST"
    case ALT  = "ALT"
    case bPeptide = "B-peptide"
    case bloodGlucose = "blood glucose"
    case BUN = "BUN (mg/dL)"
    case chloride = "chloride"
    case carbonDioxidemEqL = "carbon dioxide (CMP) mEq/L"
    case creatinine = "Creatinine"
    case carbonDioxide = "carbon dioxide"
    case calcium = "Calcium"
    case eGFR = "eGFR"
    case hemoglobin = "Hemoglobin"
    case microalbumin = "microalbumin/creat ratio"
    case MCV  = "MCV"
    case neutrophil = "Neutrophil %"
    case potassiumLevel = "Potassium level"
    case sodium = "Sodium"
    case urineNitrites = "Urine nitrites"
    case urineBlood  = "Urine Blood"
    case urineKetone  = "Urine ketone"
    case WBC = "WBC's"
}

