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
    [CategoryType.chestTightnessOrPain,
     CategoryType.skippedHeartbeat,
     CategoryType.coughing,
     CategoryType.chills,
     CategoryType.dizziness,
     CategoryType.fatigue,
     CategoryType.rapidPoundingOrFlutteringHeartbeat,
     CategoryType.fainting,
     CategoryType.nausea,
     CategoryType.vomiting,
     CategoryType.memoryLapse,
     CategoryType.shortnessOfBreath,
     CategoryType.runnyNose,
     CategoryType.soreThroat,
     CategoryType.fever,
     CategoryType.headache,
     CategoryType.heartburn,
     CategoryType.sleepChanges
    ]
}

func ReadVitalsCategoryType()->[CategoryType]{
    [CategoryType.highHeartRateEvent, CategoryType.lowHeartRateEvent, CategoryType.irregularHeartRhythmEvent]
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
]
}

func ReadLabDataCategoryType() -> [QuantityType]{
    [QuantityType.oxygenSaturation,QuantityType.dietaryPotassium,QuantityType.dietaryMagnesium]
}
