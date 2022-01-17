//
//  CardioManager.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 15/03/21.
//


import Foundation
import HealthKit
import HealthKitReporter

var cArrayOfVitalList:[VitalQuantityOrCategoryModel] = []
class VitalQuantityOrCategoryModel {
    
    var quantity: Quantity?
    var quantityType: QuantityType?
    var vitalName:VitalsName?
    var category: CategoryData?
    var categoryType: CategoryType?
    var categoryValue:Float = 0
    
    init(quantityType:QuantityType,quantity:Quantity) {
        self.quantity = quantity
        self.quantityType = quantityType
        vitalName = getVitalName(quantityType: quantityType)
    }
    init(categoryType:CategoryType,categoryValue:Float,category:CategoryData) {
        self.categoryType = categoryType
        self.category = category
        self.categoryValue = categoryValue
        vitalName = getVitalName(categoryType: categoryType)
    }
    func getVitalName(categoryType:CategoryType)->VitalsName{
        switch categoryType {
        case .irregularHeartRhythmEvent:
            return .irregularRhymesNotification
        case .sleepAnalysis:
            return .sleep
        default:
            break
        }
        return VitalsName(rawValue: "")!
    }
    func getVitalName(quantityType:QuantityType)->VitalsName?{
        switch quantityType {
        case .bloodPressureSystolic:
            return .bloodPressureSystolic
        case .heartRate:
            return .heartRate
        case .bloodPressureDiastolic:
            return .bloodPressureDiastolic
        case .vo2Max:
            return .vo2Max
        case .peakExpiratoryFlowRate:
            return .peakflowRate
        case .bodyTemperature:
            return .temperature
        case .bloodGlucose:
            return .bloodSugar
        case .bodyMass:
            return .weight
        case .oxygenSaturation:
            return .oxygenSaturation
        case .respiratoryRate:
            return .respiratoryRate
        case .bodyMassIndex:
            return .BMI
        case .stepCount:
            return .steps
        case .dietaryWater:
            return .waterIntake
        default:
            break
        }
        return VitalsName(rawValue: "")
    }
}

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
    /*
     https://docs.google.com/spreadsheets/d/1XDGg4u6Nvzrbv-BZLzwWlRcGAf6FsAecC_I2yKozHIE/edit#gid=946627644
     */
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
        cArrayOfVitalList = []
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
                                        
                                        //Bfeore there was use of highHeartRateEvent in cardio calculation.....Now client has removed it from  calculation....
                                        //category == CategoryType.highHeartRateEvent || category == CategoryType.lowHeartRateEvent  ||
                                        if  category == CategoryType.irregularHeartRhythmEvent {
                                            
                                            //save data For Cardio
                                            //let model = VitalQuantityOrCategoryModel(categoryType: category,categoryValue:1, category: element)
                                            //cArrayOfVitalList.append(model)
                                            
                                            CardioManager.sharedManager.saveCategoryData(categoryType: category, value: 1, startTimeStamp: element.startTimestamp,endTimeStamp: element.endTimestamp)
                                            
                                            //Save data for Respiratory
                                            RespiratoryManager.sharedManager.saveCategoryData(categoryType: category, value: 1, startTimeStamp: element.startTimestamp,endTimeStamp: element.endTimestamp)
                                            
                                            //Save data for FNE
                                            FNEManager.sharedManager.saveCategoryData(categoryType: category, value: 1, startTimeStamp: element.startTimestamp,endTimeStamp: element.endTimestamp)
                                            
                                        }
                                        else if category == CategoryType.sleepAnalysis{
                                            //save data For Cardio
                                            
                                            let sleepTimeForOneDay = element.endTimestamp-element.startTimestamp
                                            let hours = sleepTimeForOneDay/60/60
                                            let minutes = sleepTimeForOneDay/60
                                            if minutes > 10{
                                                //If minutes > 10 then only save hours....
                                                //let model = VitalQuantityOrCategoryModel(categoryType: category,categoryValue:Float(hours), category: element)
                                                //cArrayOfVitalList.append(model)
                                                print("sleep hours",hours)
                                                CardioManager.sharedManager.saveCategoryData(categoryType: category, value: hours, startTimeStamp: element.startTimestamp,endTimeStamp: element.endTimestamp)
                                                //Save data for Respiratory
                                                RespiratoryManager.sharedManager.saveCategoryData(categoryType: category, value: hours, startTimeStamp: element.startTimestamp,endTimeStamp: element.endTimestamp)
                                                //Save data for Respiratory
                                                NeuroManager.sharedManager.saveCategoryData(categoryType: category, value: hours, startTimeStamp: element.startTimestamp,endTimeStamp: element.endTimestamp)
                                                SDHManager.sharedManager.saveCategoryData(categoryType: category, value: hours, startTimeStamp: element.startTimestamp,endTimeStamp: element.endTimestamp)
                                            }
                                            
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
                    /*let characteristic = self.reporter?.reader.characteristics()
                    let birthdate = characteristic?.birthday?.asDate(format: Date.yyyyMMdd)
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
                    print("age",age)*/
                    ProfileSharedData.shared.readBasicDetails()
                    let age = ProfileSharedData.shared.age
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
                            
                            
                            for preferredUnit in preferredUnits {
                                dispatchGroup.enter()
                                if preferredUnit.identifier == QuantityType.stepCount.identifier || preferredUnit.identifier == QuantityType.dietaryWater.identifier {
                                    self.callForStatasticsTypeWithAllSampleData(reporter: reporter,preferredUnit: preferredUnit) { success, error in
                                        if success && error==nil{
                                            completion(success, nil)
                                        }
                                        else{
                                            completion(success, error)
                                        }
                                    }
                                    
                                }
                                else{
                                    do{
                                        self.callForQunatityTypeWithAllSampleData(reporter: reporter,preferredUnit: preferredUnit) { success, error in
                                            if success && error==nil{
                                                completion(success, nil)
                                            }
                                            else{
                                                completion(success, error)
                                            }
                                        }
                                    }
                                }
                                dispatchGroup.leave()
                            }
                            dispatchGroup.notify(queue: .main) {
                                
                                DispatchQueue.main.async {
                                    completion(success, nil)
                                }
                            }
                            
                            
                        } else {
                            //print("Preffered unit issue")
                            //print(error as Any)
                            completion(success, HealthkitSetupError.invalidType((
                                "Type Conversion issue in prefered units"
                            )))
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
    
    func callForQunatityTypeWithAllSampleData(reporter:HealthKitReporter,preferredUnit:PreferredUnit,completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void){
        do{
            let dispatchGroup = DispatchGroup()
            
            dispatchGroup.enter()
            do {
                
                let now = MyWellScore.sharedManager.todaysDate
                var component = Calendar.Component.day
                var beforeDaysOrWeekOrMonth = 1
                
                component = .month
                beforeDaysOrWeekOrMonth = 3
                let daysAgo = Calendar.current.date(byAdding: component, value: -beforeDaysOrWeekOrMonth, to: now)!
                
                //print("daysAgo",daysAgo)
                let startOfDaysAgo = Calendar.current.startOfDay(for: daysAgo)
                let mostRecentPredicate = HKQuery.predicateForSamples(withStart: startOfDaysAgo, end: now, options: [])
                
                
                let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                                      ascending: false)
                //print("preferredUnit.identifier",preferredUnit.identifier)
                //print("preferredUnit.unit",preferredUnit.unit)
                let query = try reporter.reader.quantityQuery(
                    type: try QuantityType.make(from: preferredUnit.identifier),
                    unit: preferredUnit.unit,
                    predicate: mostRecentPredicate, sortDescriptors: [sortDescriptor]
                    
                ) {  (results, error) in
                    if error == nil {
                        DispatchQueue.main.async {
                            for element in results {
                                
                                do {
                                    
                                    let identifier =  try QuantityType.make(from: preferredUnit.identifier)
                                    //print("element value",Double(element.harmonized.value))
                                    //print("element unit",(element.harmonized.unit))
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
                                    
                                    //                                                        }
                                } catch {
                                    //print(error)
                                }
                                //dispatchSemaphore.wait()
                            }
                            dispatchGroup.leave()
                        }
                    } else {
                        completion(true, HealthkitSetupError.dataParsingError)
                    }
                    
                }
                
                reporter.manager.executeQuery(query)
                
            } catch {
                completion(true, HealthkitSetupError.dataParsingError)
            }
            
            //dispatchGroup.leave()
        }
    }
    
    func callForStatasticsTypeWithAllSampleData(reporter:HealthKitReporter,preferredUnit:PreferredUnit,completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void){
        do{
            let dispatchGroup = DispatchGroup()
            
            let now = Date()
            let component = Calendar.Component.month
            let beforeDaysOrWeekOrMonth = 3
            let daysAgo = Calendar.current.date(byAdding: component, value: -beforeDaysOrWeekOrMonth, to: now)!
            
            var interval = DateComponents()
            interval.day = 1
            let startOfDaysAgo = Calendar.current.startOfDay(for: daysAgo)
            
            var anchorComponents = Calendar.current.dateComponents([.day, .month, .year], from: now)
            anchorComponents.hour = 0
            let anchorDate = Calendar.current.date(from: anchorComponents)!
            
            let identifier  = try QuantityType.make(from: preferredUnit.identifier)
            
            //dispatchGroup.enter()
            
            if let statisticsQuery1 = try self.reporter?.reader.statisticsCollectionQuery(type: identifier, unit: preferredUnit.unit, anchorDate: anchorDate, enumerateFrom: startOfDaysAgo, enumerateTo: now, intervalComponents: interval, enumerationBlock: { statistics, error in
                if error == nil {
                    do {
                        
                        guard let statistics = statistics else { return  completion(true, HealthkitSetupError.dataParsingError) }
                        /*if identifier == QuantityType.stepCount && statistics.harmonized.summary != nil{
                         print(identifier,"------",statistics.harmonized.summary!)
                         }
                         else if statistics.harmonized.average != nil{
                         print(identifier,"------",statistics.harmonized.average!)
                         }*/
                        //Save data for Cardio System...
                        CardioManager.sharedManager.saveStatasticsInArray(quantityType: identifier, element: statistics)
                        //Save data for Respiratory System...
                        RespiratoryManager.sharedManager.saveStatasticsInArray(quantityType: identifier, element: statistics)
                        //Save data for Gastrointestinal System...
                        RenalManager.sharedManager.saveStatasticsInArray(quantityType: identifier, element: statistics)
                        //Save data for Gastrointestinal System...
                        FNEManager.sharedManager.saveStatasticsInArray(quantityType: identifier, element: statistics)
                        //Save data for Gastrointestinal System...
                        GastrointestinalManager.sharedManager.saveStatasticsInArray(quantityType: identifier, element: statistics)
                        //Save data for Gastrointestinal System...
                        GenitourinaryManager.sharedManager.saveStatasticsInArray(quantityType: identifier, element: statistics)
                        //Save data for Neuro System...
                        NeuroManager.sharedManager.saveStatasticsInArray(quantityType: identifier, element: statistics)
                        //Save data for SDH System...
                        SDHManager.sharedManager.saveStatasticsInArray(quantityType: identifier, element: statistics)
                        //Save data for Musc System...
                        MuscManager.sharedManager.saveStatasticsInArray(quantityType: identifier, element: statistics)
                        //Save data for Gastrointestinal System...
                        SkinManager.sharedManager.saveStatasticsInArray(quantityType: identifier, element: statistics)
                      
                    }
                    //dispatchGroup.leave()
                } else {
                    completion(true, HealthkitSetupError.dataParsingError)
                }
                
            }
            ) {
                reporter.manager.executeQuery(statisticsQuery1)
            }
            
        } catch {
            completion(true, HealthkitSetupError.dataParsingError)
        }
        
        //dispatchGroup.leave()
    }
    
}
