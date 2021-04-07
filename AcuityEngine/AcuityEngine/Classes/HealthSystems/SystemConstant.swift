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

enum CardioConditionType:String {
    case hypertension = "hypertension"
    case arrhythmia  = "Arrhythmia "
    case heartFailure = "Congestive Heart Failure"
    case hyperlipidemia = "Hyperlipidemia"
    case anemia = "Anemia"
    case diabetes = "Diabetes"
    case arteryDisease = "Coronary Artery Disease/Peripheral Vascular Disease"
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

enum RespiratoryConditionType:String {
    case asthma = "COPD/Asthma"
    case respiratoryInfection = "Upper respiratory infection"
    case pneumonia = "Bronchitis/pneumonia"
    case covid = "Covid"
    case allergicRhiniitis = "Allergic Rhiniitis"
    case smoking = "Smoking"
    case sleepApnea = "sleep apnea"
    case heartFailure = "Congestive heart failure"
    case coronaryArteryDisease = "Coronary artery disease"
}

enum LabType:String {
    case sodium = "Sodium"
    case carbonDioxide = "carbon dioxide (CMP) mEq/L"
    case chloride = "chloride"
    case WBC = "WBC's"
    case neutrophil = "Neutrophil %"
    case potassiumLevel = "Potassium level"
    case albumin = "Albumin"
    case microalbumin = "microalbumin/creat ratio"
    case bPeptide = "B-peptide"
    case hemoglobin = "Hemoglobin"
}

