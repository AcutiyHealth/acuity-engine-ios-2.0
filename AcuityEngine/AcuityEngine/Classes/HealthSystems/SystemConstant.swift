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

struct SystemRelativeImportance {
    static let Cardiovascular = 100.00
    static let Respiratory = 100.00
    static let Renal = 100.00
    static let InfectiousDisease = 100.00
    static let Fluids = 100.00
    static let Hematology = 70.00
    static let Endocrine = 70.00
    static let Gastrointestinal = 70.00
    static let Genitourinary = 70.00
    static let Nuerological = 40.00
    static let SocialDeterminantsofHealth = 40.00
    static let Musculatory = 40.00
    static let Integumentary = 40.00
    static let Heent = 40.00
    
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
    case crohnsDisease = "Crohns Disease"
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
    case memoryLoss = "Memory Loss/dementia"
    case muscularSprain = "Muscular Sprain/Strain"
    case neuropathy = "Neuropathy"
    case otitis = "Otitis"
    case overweightOrObesity = "Overweight/Obesity"
    case otherHematoProblem = "Other Heme/Onc Problem"
    case osteoarthritis = "Osteoarthritis"
    case osteoporosis = "Osteoporosis"
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

enum SymptomsName:String {
    case abdominal_Cramps = "Abdominal Cramps"
    case acne = "Acne"
    case bladder_Incontinence = "Bladder Incontinence"
    case bloating = "Bloating"
    case body_Ache = "Body And Muscle Ache"
    case chestPain = "Chest Pain"
    case chills = "Chills"
    case constipation = "Constipation"
    case cough = "Cough"
    case diarrhea = "Diarrhea"
    case dizziness = "Dizziness"
    case drySkin = "Dry Skin"
    case fainting = "Fainting"
    case fatigue = "Fatigue"
    case fever = "Fever"
    case hairLoss = "Hair Loss"
    case headache = "Headache"
    case heartburn = "Heartburn"
    case hotFlashes = "Hot Flashes"
    case lossOfSmell = "Loss Of Smell"
    case lowerBackPain = "Lower Back Pain"
    case memoryLapse = "Memory Lapse"
    case moodChanges = "Mood Changes"
    case nausea = "Nausea"
    case rapidHeartbeat = "Rapid Or Fluttering Heartbeat"
    case runnyNose = "Runny Nose"
    case shortnessOfBreath = "Shortness Of Breath"
    case skippedHeartBeat = "Skipped Heart Beat"
    case sleepChanges = "Sleep Changes"
    case soreThroat = "Sore Throat"
    case vomiting = "Vomiting"
    
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
    case ESR = "ESR"
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
    case vitaminB12 = "Vitamin B12"
}

enum LabCodeConstant:String{
    case anionGap = "10466-1"
    case albumin = "1751-7"
    case alkalinePhosphatase = "6768-6"
    case AST  = "1920-8"
    case ALT  = "1742-6"
    case bPeptide = "30934-4"
    case bloodGlucose = "2345-7"
    case b12Level = "000810"
    case BUN = "3094-0"
    case creatinine = "2160-0"
    case carbonDioxide = "2028-9"
    case chloride = "2075-0"
    case calcium = "17861-6"
    case eGFR = "45066-0"
    case ESR = "ESR" //Need to import
    case hemoglobin = "4546-8"
    case hemoglobinA1C = "55454-3"
    case microalbuminCreatinineRatio = "14959-1"
    case MCV  = "30428-7"
    case neutrophil = "32200-8"
    case platelets = "777-3" //Need to import
    case potassiumLevel = "2823-3"
    case sodium = "2951-2"
    case TSH = "11580-8"
    case urineNitrites = "45066-8"
    case urineBlood  = "5794-3"
    case urineKetone  = "2514-8" //Need to import
    case vitaminB12 = "30904-7" //Need to import
    case WBC = "6690-0"
    
}
