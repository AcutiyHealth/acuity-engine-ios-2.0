//
//  ReadMetricsList.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 05/04/21.
//

import Foundation
import HealthKitReporter
import HealthKit

func ReadSymptomsValue() -> [CategoryType]{
    [CategoryType.abdominalCramps,
     CategoryType.acne,
     CategoryType.bladderIncontinence,
     CategoryType.bloating,
     CategoryType.generalizedBodyAche,
     CategoryType.chestTightnessOrPain,
     CategoryType.chills,
     CategoryType.constipation,
     CategoryType.coughing,
     CategoryType.diarrhea,
     CategoryType.dizziness,
     CategoryType.drySkin,
     CategoryType.fainting,
     CategoryType.fatigue,
     CategoryType.fever,
     CategoryType.hairLoss,
     CategoryType.headache,
     CategoryType.heartburn,
     CategoryType.hotFlashes,
     CategoryType.lossOfSmell,
     CategoryType.lowerBackPain,
     CategoryType.memoryLapse,
     CategoryType.moodChanges,
     CategoryType.nausea,
     CategoryType.rapidPoundingOrFlutteringHeartbeat,
     CategoryType.runnyNose,
     CategoryType.shortnessOfBreath,
     CategoryType.skippedHeartbeat,
     CategoryType.sleepChanges,
     CategoryType.soreThroat,
     CategoryType.vomiting
    ]
}

func ReadVitalsCategoryType()->[CategoryType]{
    [CategoryType.highHeartRateEvent, CategoryType.lowHeartRateEvent, CategoryType.irregularHeartRhythmEvent]
}
func ReadCharactristicType()->[CharacteristicType]{
    [CharacteristicType.dateOfBirth]
}

func ReadVitalsQuantityType() -> [QuantityType]{
    [QuantityType.bloodPressureSystolic,
     QuantityType.bloodPressureDiastolic,
     QuantityType.vo2Max,
     QuantityType.peakExpiratoryFlowRate,
     QuantityType.inhalerUsage,
     QuantityType.bodyTemperature,
     QuantityType.bodyMassIndex,
     QuantityType.heartRate,
     QuantityType.bloodGlucose,
     QuantityType.bodyMass,
     QuantityType.oxygenSaturation,
     QuantityType.respiratoryRate,
     QuantityType.walkingStepLength,
     QuantityType.headphoneAudioExposure
    ]
}

func ReadLabDataCategoryType() -> [QuantityType]{
    [QuantityType.oxygenSaturation,QuantityType.dietaryPotassium,QuantityType.dietaryMagnesium]
}
