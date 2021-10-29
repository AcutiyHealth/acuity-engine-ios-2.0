//
//  CardioManager.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 15/03/21.
//


import Foundation
import HealthKit
import HealthKitReporter

class HKManagerReadVitals: NSObject {
    
    static let sharedManager = HKManagerReadVitals()
    private var reporter: HealthKitReporter?
    
    
    //Listner initialization
    var readIrregularHeartDataDone: (() -> Void)?
    var readBloodPressureDone: (() -> Void)?
    
    private lazy var heartRateType: HKQuantityType? = HKObjectType.quantityType(forIdentifier: .heartRate)
    
    override init() {
        super.init()
        
    }
    
    func resetData(){
        CardioManager.sharedManager.resetCardioData()
        RespiratoryManager.sharedManager.resetRespiratoryData()
        RenalManager.sharedManager.resetRenalData()
        IDiseaseManager.sharedManager.resetIDiseaseData()
        FNEManager.sharedManager.resetFNEData()
        HematoManager.sharedManager.resetHematoData()
        EndocrineManager.sharedManager.resetEndocrineData()
        GastrointestinalManager.sharedManager.resetGastrointestinalData()
        GenitourinaryManager.sharedManager.resetGenitourinaryData()
        NeuroManager.sharedManager.resetNeuroData()
        SDHManager.sharedManager.resetSDHData()
        MuscManager.sharedManager.resetMuscData()
        SkinManager.sharedManager.resetSkinData()
        HeentManager.sharedManager.resetHeentData()
    }
    
    func readVitalsData(days:SegmentValueForGraph,completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void) {
        
        do {
            let dispatchGroup = DispatchGroup()
            
            reporter = try HealthKitReporter()
            let types = ReadVitalsCategoryType()
            reporter?.manager.requestAuthorization(
                toRead: types,
                toWrite: []
            ){ (success, error) in
                if success && error == nil {
                    
                    let now = MyWellScore.sharedManager.todaysDate
                    var component = Calendar.Component.day
                    var beforeDaysOrWeekOrMonth = 1
                    
                    /*switch days {
                     case .SevenDays:
                     component = .day
                     beforeDaysOrWeekOrMonth = 7
                     case .ThirtyDays:
                     component = .weekOfMonth
                     beforeDaysOrWeekOrMonth = 4
                     case .ThreeMonths:
                     component = .month
                     beforeDaysOrWeekOrMonth = 3
                     
                     }*/
                    component = .month
                    beforeDaysOrWeekOrMonth = 3
                    let daysAgo = Calendar.current.date(byAdding: component, value: -beforeDaysOrWeekOrMonth, to: now)!
                    
                    let startOfDaysAgo = Calendar.current.startOfDay(for: daysAgo)
                    let mostRecentPredicate = HKQuery.predicateForSamples(withStart: startOfDaysAgo, end: now, options: [])
                    
                    
                    let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                                          ascending: false)
                    
                    for category in types {
                        dispatchGroup.enter()
                        do {
                            
                            let query = try self.reporter?.reader.categoryQuery(type: category,predicate: mostRecentPredicate, sortDescriptors: [sortDescriptor], resultsHandler: {  (results, error) in
                                if error == nil {
                                    for element in results {
                                        
                                        
                                        if category == CategoryType.highHeartRateEvent || category == CategoryType.lowHeartRateEvent  || category == CategoryType.irregularHeartRhythmEvent {
                                            
                                            //save data For Cardio
                                            CardioManager.sharedManager.saveCategoryData(categoryType: category, value: 1, startTimeStamp: element.startTimestamp,endTimeStamp: element.endTimestamp)
                                            
                                            //Save data for Respiratory
                                            RespiratoryManager.sharedManager.saveCategoryData(categoryType: category, value: 1, startTimeStamp: element.startTimestamp,endTimeStamp: element.endTimestamp)
                                            
                                            //Save data for FNE
                                            FNEManager.sharedManager.saveCategoryData(categoryType: category, value: 1, startTimeStamp: element.startTimestamp,endTimeStamp: element.endTimestamp)
                                            
                                        }
                                    }
                                    dispatchGroup.leave()
                                } else {
                                    //print("Error in quabtyt query")
                                    //print(error as Any)
                                }
                            })
                            self.reporter?.manager.executeQuery(query!)
                        } catch {
                            Log.d("Quantity query issue")
                            //print(error)
                            completion(false, HealthkitSetupError.dataTypeNotAvailable)
                        }
                    }
                    dispatchGroup.notify(queue: .main) {
                        
                        DispatchQueue.main.async {
                            self.readCharactristicTypeVitalsData(days: days, characteristicType:  ReadCharactristicType(), completion: { (success, error) in
                                if success && error==nil{
                                    completion(success, nil)
                                }
                                else{
                                    completion(success, error)
                                }
                            })
                            
                        }
                    }
                    
                }
                // }
            }
        } catch {
            //print("Health Kit not initialize")
            //print(error)
            completion(false, HealthkitSetupError.notAvailableOnDevice)
        }
    }
    
    func readCharactristicTypeVitalsData(days:SegmentValueForGraph,characteristicType:[CharacteristicType],completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void){
        
        do {
            //let dispatchGroup = DispatchGroup()
            
            reporter = try HealthKitReporter()
            let types = ReadCharactristicType()
            reporter?.manager.requestAuthorization(
                toRead: types,
                toWrite: []
            ){ (success, error) in
                if success && error == nil {
                    //dispatchGroup.enter()
                    let characteristic = self.reporter?.reader.characteristics()
                    let birthdate = characteristic?.birthday?.asDate(format: Date.iso8601)
                    var age = 0;
                    
                    //2 - get today date
                    if let date = birthdate{
                        let today = Date()
                        
                        //3 - create an instance of the user's current calendar
                        let calendar = Calendar.current
                        
                        //4 - use calendar to get difference between two dates
                        let components = calendar.dateComponents([.year], from: date, to: today)
                        
                        age = components.year ?? 0
                    }
                    print("age",age)
                    //save data For SDH
                    SDHManager.sharedManager.saveAgeCharactesticInArray(element: Double(age))
                    
                    DispatchQueue.main.async {
                        self.readQuantityTypeVitalsData(days: days, quantityType:  ReadVitalsQuantityType(), completion: { (success, error) in
                            if success && error==nil{
                                completion(success, nil)
                            }
                            else{
                                completion(success, error)
                            }
                        })
                        
                  
                    }
                    
                }
                // }
            }
        } catch {
            //print("Health Kit not initialize")
            //print(error)
            completion(false, HealthkitSetupError.notAvailableOnDevice)
        }
    }
    func readQuantityTypeVitalsData(days:SegmentValueForGraph,quantityType:[QuantityType],completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void) {
        do {
            let dispatchGroup = DispatchGroup()
            
            let reporter = try HealthKitReporter()
            let types = quantityType
            reporter.manager.requestAuthorization(
                toRead: types,
                toWrite: types
            ){ (success, error) in
                if success && error == nil {
                    //dispatchGroup.enter()
                    reporter.manager.preferredUnits(for: types) { (preferredUnits, error) in
                        
                        if error == nil {
                            
                            let now = MyWellScore.sharedManager.todaysDate
                            var component = Calendar.Component.day
                            var beforeDaysOrWeekOrMonth = 1
                            
                            /*switch days {
                             case .SevenDays:
                             component = .day
                             beforeDaysOrWeekOrMonth = 7
                             case .ThirtyDays:
                             component = .weekOfMonth
                             beforeDaysOrWeekOrMonth = 4
                             case .ThreeMonths:
                             component = .month
                             beforeDaysOrWeekOrMonth = 3
                             
                             }*/
                            
                            component = .month
                            beforeDaysOrWeekOrMonth = 3
                            let daysAgo = Calendar.current.date(byAdding: component, value: -beforeDaysOrWeekOrMonth, to: now)!
                            
                            print("daysAgo",daysAgo)
                            let startOfDaysAgo = Calendar.current.startOfDay(for: daysAgo)
                            let mostRecentPredicate = HKQuery.predicateForSamples(withStart: startOfDaysAgo, end: now, options: [])
                            
                            
                            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                                                  ascending: false)
                            
                            
                            for preferredUnit in preferredUnits {
                                dispatchGroup.enter()
                                do {
                                    let query = try reporter.reader.quantityQuery(
                                        type: try QuantityType.make(from: preferredUnit.identifier),
                                        unit: preferredUnit.unit,
                                        predicate: mostRecentPredicate, sortDescriptors: [sortDescriptor]
                                        
                                    ) { [weak self] (results, error) in
                                        if error == nil {
                                            DispatchQueue.main.async {
                                                for element in results {
                                                    //
                                                    //CardioManager.sharedManager.saveElementInArray(unit: preferredUnit, element: element)
                                                    //dispatchGroup.enter()
                                                    do {
                                                        
                                                        let identifier =  try QuantityType.make(from: preferredUnit.identifier)
                                                        
                                                        //save data For Cardio
                                                        CardioManager.sharedManager.saveQuantityInArray(quantityType: identifier, element: element)
                                                        
                                                        //save data For Respiratory
                                                        RespiratoryManager.sharedManager.saveQuantityInArray(quantityType: identifier, element: element)
                                                        
                                                        //save data For Renal
                                                        RenalManager.sharedManager.saveQuantityInArray(quantityType: identifier, element: element)
                                                        
                                                        //Save data for ID...
                                                        IDiseaseManager.sharedManager.saveQuantityInArray(quantityType: identifier, element: element)
                                                        
                                                        //Save data for FNE...
                                                        FNEManager.sharedManager.saveQuantityInArray(quantityType: identifier, element: element)
                                                        
                                                        //Save data for Hemato...
                                                        HematoManager.sharedManager.saveQuantityInArray(quantityType: identifier, element: element)
                                                        
                                                        //Save data for Endocrine...
                                                        EndocrineManager.sharedManager.saveQuantityInArray(quantityType: identifier, element: element)
                                                        
                                                        //Save data for Gastrointestinal...
                                                        GastrointestinalManager.sharedManager.saveQuantityInArray(quantityType: identifier, element: element)
                                                        
                                                        //Save data for Genitourinary...
                                                        GenitourinaryManager.sharedManager.saveQuantityInArray(quantityType: identifier, element: element)
                                                        
                                                        //Save data for Neuro System...
                                                        NeuroManager.sharedManager.saveQuantityInArray(quantityType: identifier, element: element)
                                                        
                                                        //Save data for SDH System...
                                                        SDHManager.sharedManager.saveQuantityInArray(quantityType: identifier, element: element)
                                                        
                                                        //Save data for Musc System...
                                                        MuscManager.sharedManager.saveQuantityInArray(quantityType: identifier, element: element)
                                                        
                                                        //Save data for Skin System...
                                                        SkinManager.sharedManager.saveQuantityInArray(quantityType: identifier, element: element)
                                                        
                                                        //Save data for Heent System...
                                                        HeentManager.sharedManager.saveQuantityInArray(quantityType: identifier, element: element)
                                                        
                                                    } catch {
                                                        //print(error)
                                                    }
                                                    //dispatchSemaphore.wait()
                                                }
                                                dispatchGroup.leave()
                                            }
                                        } else {
                                            //print("Error in quabtyt query")
                                            //print(error as Any)
                                            self?.readBloodPressureDone?()
                                            completion(success, HealthkitSetupError.dataParsingError)
                                        }
                                        
                                    }
                                    
                                    reporter.manager.executeQuery(query)
                                    
                                } catch {
                                    //print("Quantity query issue")
                                    //print(error)
                                    completion(success, HealthkitSetupError.dataParsingError)
                                }
                                
                                //dispatchGroup.leave()
                            }
                            dispatchGroup.notify(queue: .main) {
                                
                                DispatchQueue.main.async {
                                    completion(success, nil)
                                }
                            }
                            
                            
                        } else {
                            //print("Preffered unit issue")
                            //print(error as Any)
                            completion(success, HealthkitSetupError.dataTypeNotAvailable)
                        }
                    }
                    
                    
                } else {
                    //print("Types not available")
                    //print(error as Any)
                    completion(false, HealthkitSetupError.dataTypeNotAvailable)
                }
            }
        } catch {
            //print("Health Kit not initialize")
            //print(error)
            completion(false, HealthkitSetupError.notAvailableOnDevice)
        }
    }
    
    
    
}

