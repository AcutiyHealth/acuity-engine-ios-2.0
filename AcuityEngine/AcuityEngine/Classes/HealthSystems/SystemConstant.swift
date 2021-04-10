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


enum ConditionType:String {
    case asthma = "COPD/Asthma"
    case respiratoryInfection = "Upper respiratory infection"
    case pneumonia = "Bronchitis/pneumonia"
    case covid = "Covid"
    case allergicRhiniitis = "Allergic Rhiniitis"
    case smoking = "Smoking"
    case sleepApnea = "sleep apnea"
    case heartFailure = "Congestive heart failure"
    case coronaryArteryDisease = "Coronary artery disease"
    case hypertension = "hypertension"
    case arrhythmia  = "Arrhythmia"
    case hyperlipidemia = "Hyperlipidemia"
    case anemia = "Anemia"
    case diabetes = "Diabetes"
    case arteryDisease = "Coronary Artery Disease/Peripheral Vascular Disease"
    case kidneyDiease = "kidney diease"
    case kidneyStones = "kidney stones"
    case electrolyteDisorders = "electrolyte disorders"
    case underweightOrMalnutrition = "underweight/malnutrition"
    case UTI = "UTI"
}

enum LabType:String {
    case sodium = "Sodium"
    case carbonDioxidemEqL = "carbon dioxide (CMP) mEq/L"
    case chloride = "chloride"
    case WBC = "WBC's"
    case neutrophil = "Neutrophil %"
    case potassiumLevel = "Potassium level"
    case albumin = "Albumin"
    case microalbumin = "microalbumin/creat ratio"
    case bPeptide = "B-peptide"
    case hemoglobin = "Hemoglobin"
    case BUN = "BUN (mg/dL)"
    case creatinine = "Creatinine"
    case bloodGlucose = "blood glucose"
    case carbonDioxide = "carbon dioxide"
    case calcium = "Calcium"
    case anionGap = "Anion gap"
    case eGFR = "eGFR"
   
}

