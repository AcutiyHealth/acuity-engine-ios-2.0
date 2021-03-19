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
        HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    class func authorizeLabDataKit(completion: @escaping ([HKSample],Bool, HealthkitSetupError?) -> Swift.Void) {
        let healthStore = HKHealthStore()
        
        // Create required Record Type's equivalent HKClinicalType using clinicalType func of HKObjectType
        guard let
                labResultRecord = HKObjectType.clinicalType(forIdentifier: .labResultRecord)
        else {
            // Handle errors here. This could in case the OS on device is < 12.0. You can use @available(iOS 12.0, *) to avoid that
            completion([],false, HealthkitSetupError.dataTypeNotAvailable)
            return
        }
        
        // Pass the Set of required HKClinicalType to get authorization for read only. As Clinical Records as Read only.
        healthStore.requestAuthorization(toShare: nil, read: [labResultRecord]) { (success, error) in
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
            
            healthStore.execute(query)
            
            
            
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
    
    class func calculateNotificationIsInToday(elementTimeStamp:Double)->Bool {
        let fallsBetween = Date().timeIntervalSince1970 - elementTimeStamp
        if fallsBetween<=86400{
            return true
        }
        return false
    }
}
