//
//  HKManagerReadSymptoms.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 23/03/21.
//

import Foundation
import HealthKit
import HealthKitReporter

class HKManagerReadSymptoms: NSObject
{
    static let sharedManager = HKManagerReadSymptoms()
    private var reporter: HealthKitReporter?
   
    private lazy var heartRateType: HKQuantityType? = HKObjectType.quantityType(forIdentifier: .heartRate)
    
    override init() {
        super.init()
        
    }
    
    func readSymptomsData(days: SegmentValueForGraph,completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void) {
        
        
        do {
            print("start")
            let dispatchGroup = DispatchGroup()
            reporter = try HealthKitReporter()
            let types = ReadSymptomsValue()
            reporter?.manager.requestAuthorization(
                toRead: types,
                toWrite: types
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
                        
                        do {
                            
                            let query = try self.reporter?.reader.categoryQuery(type: category,predicate: mostRecentPredicate, sortDescriptors: [sortDescriptor], resultsHandler: {  (results, error) in
                                
                                dispatchGroup.enter()
                                DispatchQueue.main.async {
                                    
                                    if error == nil {
                                        for element in results {
                                            
                                            let element:CategoryData = element
                                            
                                            //Save data for Cardio...
                                            CardioManager.sharedManager.saveSymptomsData(category: category, element: element)
                                            
                                            //Save data for Respiratory...
                                            RespiratoryManager.sharedManager.saveSymptomsData(category: category, element: element)
                                            
                                            //Save data for Renal...
                                            RenalManager.sharedManager.saveSymptomsData(category: category, element: element)
                                        }
                                        dispatchGroup.leave()
                                        
                                        
                                        // completion(success, nil)
                                    } else {
                                        //print("Error in quabtyt query")
                                        //print(error as Any)
                                    }
                                }
                            })
                            self.reporter?.manager.executeQuery(query!)
                        } catch {
                            print("Quantity query issue")
                            //print(error)
                            
                        }
                    }
                    dispatchGroup.notify(queue: .main) {
                        
                        DispatchQueue.main.async {
                            completion(success, nil)
                        }
                    }
                    
                }
                else {
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
