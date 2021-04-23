//
//  HKSetupAssistance.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 07/01/21.
//

import UIKit
import HealthKit

enum HealthkitSetupError: Error {
    case notAvailableOnDevice
    case dataTypeNotAvailable
    case noSampleFound
    case noDataFound
    case dataParsingError
}


class HKSetupAssistance {
    
    static let healthKitStore = HKHealthStore()
    
    
    class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
        
        //1. Check to see if HealthKit Is Available on this device
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
        
        //2. Prepare the data types that will interact with HealthKit
        guard   let dateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
                let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType),
                let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
                let bodyMassIndex = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
                let height = HKObjectType.quantityType(forIdentifier: .height),
                let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass),
                let heartRate = HKObjectType.quantityType(forIdentifier: .heartRate),
                let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount),
                let sleepAnalysis = HKObjectType.categoryType(forIdentifier: .sleepAnalysis),
                let restingHearRate = HKObjectType.quantityType(forIdentifier: .restingHeartRate),
                let respiratonRate = HKObjectType.quantityType(forIdentifier: .respiratoryRate),
                
                
                let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
            
            completion(false, HealthkitSetupError.dataTypeNotAvailable)
            return
        }
        
        //3. Prepare a list of types you want HealthKit to read and write
        let healthKitTypesToWrite: Set<HKSampleType> = [bodyMassIndex,
                                                        activeEnergy,
                                                        HKObjectType.workoutType()]
        
        let healthKitTypesToRead: Set<HKObjectType> = [dateOfBirth,
                                                       bloodType,
                                                       biologicalSex,
                                                       bodyMassIndex,
                                                       height,
                                                       bodyMass,
                                                       heartRate,
                                                       stepCount,
                                                       sleepAnalysis,
                                                       restingHearRate,
                                                       respiratonRate,
                                                       HKObjectType.workoutType()]
        
        //4. Request Authorization
        HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite,
                                             read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    class func authorizeCardioDataHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
        //1. Check to see if HealthKit Is Available on this device
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
        
        //2. Prepare the data types that will interact with HealthKit
        guard let heartRate = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            completion(false, HealthkitSetupError.dataTypeNotAvailable)
            return
        }
        
        //3. Prepare a list of types you want HealthKit to read and write
        let healthKitTypesToWrite: Set<HKSampleType> = [heartRate]
        let healthKitTypesToRead: Set<HKObjectType> = [heartRate]
        
        //4. Request Authorization
        healthKitStore.requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    class func authorizeLabDataKit(completion: @escaping ([HKSample],Bool, HealthkitSetupError?) -> Swift.Void) {
        //let healthStore = HKHealthStore()
        
        // Create required Record Type's equivalent HKClinicalType using clinicalType func of HKObjectType
        guard let
                labResultRecord = HKObjectType.clinicalType(forIdentifier: .labResultRecord)
        else {
            // Handle errors here. This could in case the OS on device is < 12.0. You can use @available(iOS 12.0, *) to avoid that
            completion([],false, HealthkitSetupError.dataTypeNotAvailable)
            return
        }
        
        // Pass the Set of required HKClinicalType to get authorization for read only. As Clinical Records as Read only.
        healthKitStore.requestAuthorization(toShare: nil, read: [labResultRecord]) { (success, error) in
            guard success else {
                // Handle errors here.
                completion([],false, HealthkitSetupError.notAvailableOnDevice)
                return
            }
            
            
            let query = HKSampleQuery(sampleType: labResultRecord, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) {(_, samplesOrNil, error) in
                DispatchQueue.main.async {
                    guard let samples = samplesOrNil else {
                        //self.handleError(error)
                        completion([],false, HealthkitSetupError.noDataFound)
                        return
                    }
                    
                    print("samples------>\(samples)")
                    completion(samples,true,nil)
                }
            }
            
            healthKitStore.execute(query)
            
            // Your requested access has been authorized by the user.
        }
    }
    //MARK: check authorization for Add Vitals
    class func authorizeHealthKitForAddVitals(quantityTypeIdentifier:HKQuantityTypeIdentifier,completion: @escaping (Bool, Error?) -> Swift.Void) {
        
        //1. Check to see if HealthKit Is Available on this device
        guard HealthKit.HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
        
        //2. Prepare the data types that will interact with HealthKit
        
        guard  let quantityToWrite  = HKObjectType.quantityType(forIdentifier:quantityTypeIdentifier)     else {
            
            completion(false, HealthkitSetupError.dataTypeNotAvailable)
            return
        }
        let healthKitTypesToWrite: Set<HKSampleType> = [quantityToWrite]
        let healthKitTypesToRead: Set<HKObjectType> = []
        
        //4. Request Authorization
        healthKitStore.requestAuthorization(toShare: healthKitTypesToWrite,
                                            read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
        
    }
    
    //MARK: check authorization for Add Symptoms
    class func authorizeHealthKitForAddSymptoms(caegoryTypeIdentifier:HKCategoryTypeIdentifier,completion: @escaping (Bool, Error?) -> Swift.Void)
    {
        
        //1. Check to see if HealthKit Is Available on this device
        guard HealthKit.HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
        
        //2. Prepare the data types that will interact with HealthKit
        guard  let categoryToWrite  = HKObjectType.categoryType(forIdentifier:caegoryTypeIdentifier)     else {
            
            completion(false, HealthkitSetupError.dataTypeNotAvailable)
            return
        }
        
        let healthKitTypesToWrite: Set<HKSampleType> = [categoryToWrite]
        let healthKitTypesToRead: Set<HKObjectType> = []
        
        //4. Request Authorization
        healthKitStore.requestAuthorization(toShare: healthKitTypesToWrite,
                                            read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    //MARK:
    class func calculateNotificationIsInToday(elementTimeStamp:Double)->Bool {
        let fallsBetween = Date().timeIntervalSince1970 - elementTimeStamp
        if fallsBetween<=86400{
            return true
        }
        return false
    }
}

//For symptoms

/* guard  let abdominalCramps  = HKObjectType.categoryType(forIdentifier: .abdominalCramps),
 let acne = HKObjectType.categoryType(forIdentifier: .acne),
 let bloating = HKObjectType.categoryType(forIdentifier: .bloating),
 let generalizedBodyAche = HKObjectType.categoryType(forIdentifier: .generalizedBodyAche),
 let chestTightnessOrPain = HKObjectType.categoryType(forIdentifier: .chestTightnessOrPain),
 let chills = HKObjectType.categoryType(forIdentifier: .chills),
 let constipation = HKObjectType.categoryType(forIdentifier: .constipation),
 let coughing = HKObjectType.categoryType(forIdentifier: .coughing),
 let diarrhea = HKObjectType.categoryType(forIdentifier: .diarrhea),
 let dizziness = HKObjectType.categoryType(forIdentifier: .dizziness),
 let fainting = HKObjectType.categoryType(forIdentifier: .fainting),
 let fatigue = HKObjectType.categoryType(forIdentifier: .fatigue),
 let fever = HKObjectType.categoryType(forIdentifier: .fever),
 let headache = HKObjectType.categoryType(forIdentifier: .headache),
 let heartburn = HKObjectType.categoryType(forIdentifier: .heartburn),
 let hotFlashes = HKObjectType.categoryType(forIdentifier: .hotFlashes),
 let lossOfSmell = HKObjectType.categoryType(forIdentifier: .lossOfSmell),
 let lowerBackPain = HKObjectType.categoryType(forIdentifier: .lowerBackPain),
 let moodChanges = HKObjectType.categoryType(forIdentifier: .moodChanges),
 let nausea = HKObjectType.categoryType(forIdentifier: .nausea),
 let rapidPoundingOrFlutteringHeartbeat = HKObjectType.categoryType(forIdentifier: .rapidPoundingOrFlutteringHeartbeat),
 let runnyNose = HKObjectType.categoryType(forIdentifier: .runnyNose),
 let skippedHeartbeat = HKObjectType.categoryType(forIdentifier: .skippedHeartbeat),
 let sleepChanges = HKObjectType.categoryType(forIdentifier: .sleepChanges),
 let shortnessOfBreath = HKObjectType.categoryType(forIdentifier: .shortnessOfBreath),
 let soreThroat = HKObjectType.categoryType(forIdentifier: .soreThroat),
 let vomiting = HKObjectType.categoryType(forIdentifier: .vomiting)
 else {
 
 completion(false, HealthkitSetupError.dataTypeNotAvailable)
 return
 }
 
 //let walkingStepLength  = HKObjectType.quantityType(forIdentifier: .walkingStepLength)
 //3. Prepare a list of types you want HealthKit to read and write
 var healthKitTypesToWrite: Set<HKSampleType> = [abdominalCramps,
 acne,
 bloating,
 generalizedBodyAche,
 chestTightnessOrPain,
 chills,
 constipation,
 coughing,
 diarrhea,dizziness,fainting,fatigue,fever,
 headache,heartburn,
 hotFlashes,nausea,rapidPoundingOrFlutteringHeartbeat,runnyNose,skippedHeartbeat,sleepChanges,soreThroat,vomiting,
 lossOfSmell,lowerBackPain,moodChanges,shortnessOfBreath
 ]
 //step length
 if #available(iOS 14.0, *) {
 guard  let bladderIncontinence  = HKObjectType.categoryType(forIdentifier: .bladderIncontinence),
 let drySkin = HKObjectType.categoryType(forIdentifier: .drySkin),
 let hairLoss = HKObjectType.categoryType(forIdentifier: .hairLoss),let memoryLapse = HKObjectType.categoryType(forIdentifier: .memoryLapse) else {
 
 completion(false, HealthkitSetupError.dataTypeNotAvailable)
 return
 }
 healthKitTypesToWrite.insert(bladderIncontinence)
 healthKitTypesToWrite.insert(drySkin)
 healthKitTypesToWrite.insert(hairLoss)
 healthKitTypesToWrite.insert(memoryLapse)
 }
 */
