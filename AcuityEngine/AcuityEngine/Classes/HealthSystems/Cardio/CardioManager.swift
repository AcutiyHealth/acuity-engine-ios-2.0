//
//  CardioManager.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 03/02/21.
//


import Foundation
import HealthKit
import HealthKitReporter

class CardioManager: CardioManagerProtocol {
    
    
    
    
    static let sharedManager = CardioManager()
    private var reporter: HealthKitReporter?
    
    //Initialize cardio data...
    var cardioData = CardioData()
    
    //Listner initialization
    var readIrregularHeartDataDone: (() -> Void)?
    var readBloodPressureDone: (() -> Void)?
    var readSymptomsDataDone: (() -> Void)?
    var readLabDataDone: (() -> Void)?
    var readConditionDataDone: (() -> Void)?
    
    private lazy var heartRateType: HKQuantityType? = HKObjectType.quantityType(forIdentifier: .heartRate)
    
    init() {
        //super.init()
        
    }
    
    func resetCardioData(){
        cardioData = CardioData()
    }
    
    func readIrregularHeartData(completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void) {
        do {
            reporter = try HealthKitReporter()
            let types = CardioHeartCategoryType()
            reporter?.manager.requestAuthorization(
                toRead: types,
                toWrite: []
            ){ (success, error) in
                if success && error == nil {
                    
                    for category in types {
                        do {
                            let query = try self.reporter?.reader.categoryQuery(type: category, limit: 1, resultsHandler: { [weak self] (results, error) in
                                if error == nil {
                                    for element in results {
                                        
                                        if category == CategoryType.highHeartRateEvent {
                                            
                                          let isTimeStampInToday = HKSetupAssistance.calculateNotificationIsInToday(elementTimeStamp: element.endTimestamp)
                                            //calculate that notification falls in today
                                            
                                            if isTimeStampInToday{
                                                let highHeartRate = CardioVitals(type: CardioVitalsType.highHeartRate)
                                                highHeartRate.value = 1
                                                self?.cardioData.cardioIMP.highHeartRateData = highHeartRate
                                            }
                                            
                                            //print("---------\n HighHeartRateData \nValue \(highHeartRate.value)\n Score \(highHeartRate.score)\n Max Score\(highHeartRate.maxScore ?? 0.0) \n---------")
                                            
                                        } else  if category == CategoryType.lowHeartRateEvent {
                                            
                                            //calculate that notification falls in today
                                            let isTimeStampInToday = HKSetupAssistance.calculateNotificationIsInToday(elementTimeStamp: element.endTimestamp)
                                              
                                              if isTimeStampInToday{
                                                let lowHeartRate = CardioVitals(type: CardioVitalsType.lowHeartRate)
                                                lowHeartRate.value = 1
                                                self?.cardioData.cardioIMP.lowHeartRateData = lowHeartRate
                                            }
                                            
                                            
                                            //print("---------\n LowHeartRateData \nValue \(lowHeartRate.value)\n Score \(lowHeartRate.score)\n Max Score\(lowHeartRate.maxScore ?? 0.0) \n---------")
                                            
                                        } else  if category == CategoryType.irregularHeartRhythmEvent {
                                            
                                            let isTimeStampInToday = HKSetupAssistance.calculateNotificationIsInToday(elementTimeStamp: element.endTimestamp)
                                              //calculate that notification falls in today
                                              
                                              if isTimeStampInToday{
                                                let irregularRhymesNotification = CardioVitals(type: CardioVitalsType.irregularRhymesNotification)
                                                irregularRhymesNotification.value = 1
                                                self?.cardioData.cardioIMP.irregularRhythmNotificationData = irregularRhymesNotification
                                            }
                                            
                                        }
                                        
                                    }
                                    self?.readIrregularHeartDataDone?()
                                    completion(success, nil)
                                } else {
                                    //print("Error in quabtyt query")
                                    //print(error as Any)
                                }
                            })
                            self.reporter?.manager.executeQuery(query!)
                        } catch {
                            print("Quantity query issue")
                            //print(error)
                            completion(false, HealthkitSetupError.dataTypeNotAvailable)
                        }
                    }
                    
                }
            }
        } catch {
            //print("Health Kit not initialize")
            //print(error)
            completion(false, HealthkitSetupError.notAvailableOnDevice)
        }
    }
    
    func readBloodPressure(completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void) {
        readQuantityTypeData(quantityType: CardioBloodPressureCategoryType()) { (success, error) in
            completion(success,error as? HealthkitSetupError)
        }
    }
    func readQuantityTypeData(quantityType:[QuantityType],completion: @escaping (Bool, Error?) -> Swift.Void) {
        do {
            let reporter = try HealthKitReporter()
            let types = quantityType
            reporter.manager.requestAuthorization(
                toRead: types,
                toWrite: types
            ){ (success, error) in
                if success && error == nil {
                    reporter.manager.preferredUnits(for: types) { (preferredUnits, error) in
                        if error == nil {
                            for preferredUnit in preferredUnits {
                                do {
                                    let query = try reporter.reader.quantityQuery(
                                        type: try QuantityType.make(from: preferredUnit.identifier),
                                        unit: preferredUnit.unit,
                                        limit: 1
                                    ) { [weak self] (results, error) in
                                        if error == nil {
                                            for element in results {
                                                //                                               
                                                do {
                                                    
                                                    if try QuantityType.make(from: preferredUnit.identifier) == QuantityType.bloodPressureSystolic {
                                                        
                                                        let systolicBP = CardioVitals(type: CardioVitalsType.systolicBP)
                                                        systolicBP.value = Double(element.harmonized.value)
                                                        self?.cardioData.cardioIMP.systolicBloodPressureData = systolicBP
                                                        
                                                        
                                                        //print("---------\n bloodPressureSystolic \nValue \(systolicBP.value)\n Score \(systolicBP.score)\n Max Score\(systolicBP.maxScore ?? 0.0) \n---------")
                                                        
                                                    } else  if try QuantityType.make(from: preferredUnit.identifier) == QuantityType.bloodPressureDiastolic {
                                                        
                                                        let diastolicBP = CardioVitals(type: CardioVitalsType.diastolicBP)
                                                        diastolicBP.value = Double(element.harmonized.value)
                                                        self?.cardioData.cardioIMP.diastolicBloodPressureData = diastolicBP
                                                        
                                                        
                                                        //print("---------\n bloodPressureDiastolic \nValue \(diastolicBP.value)\n Score \(diastolicBP.score)\n Max Score\(diastolicBP.maxScore ?? 0.0) \n---------")
                                                        
                                                    } else  if try QuantityType.make(from: preferredUnit.identifier) == QuantityType.vo2Max {
                                                        
                                                        let vo2Max = CardioVitals(type: CardioVitalsType.vo2Max)
                                                        vo2Max.value = Double(element.harmonized.value)
                                                        self?.cardioData.cardioIMP.vO2MaxData = vo2Max
                                                        
                                                        
                                                        //print("---------\n VO2MaxData \nValue \(vo2Max.value)\n Score \(vo2Max.score)\n Max Score\(vo2Max.maxScore ?? 0.0) \n---------")
                                                        
                                                    } else  if try QuantityType.make(from: preferredUnit.identifier) == QuantityType.heartRate {
                                                        
                                                        let heartRate = CardioVitals(type: CardioVitalsType.heartRate)
                                                        heartRate.value = Double(element.harmonized.value)
                                                        self?.cardioData.cardioIMP.heartRateData = heartRate
                                                        
                                                        
                                                        //print("---------\n HeartRateData \nValue \(heartRate.value)\n Score \(heartRate.score)\n Max Score\(heartRate.maxScore ?? 0.0) \n---------")
                                                    }
                                                    if try QuantityType.make(from: preferredUnit.identifier) == QuantityType.oxygenSaturation {
                                                        
                                                        let bloodOxygenLevelData = CardioLabData(type: CardioLabsType.bloodOxygenLevel)
                                                        bloodOxygenLevelData.value = Double(element.harmonized.value) * 100
                                                        self?.cardioData.cardioLab.bloodOxygenLevelData = bloodOxygenLevelData
                                                        
                                                        //print("---------\n oxygenSaturation \nValue \(element.harmonized.value) \n---------")
                                                        
                                                    }
                                                    if try QuantityType.make(from: preferredUnit.identifier) == QuantityType.dietaryPotassium {
                                                        
                                                        let potassiumLevelData = CardioLabData(type: CardioLabsType.potassiumLevel)
                                                        potassiumLevelData.value = Double(element.harmonized.value)
                                                        self?.cardioData.cardioLab.potassiumLevelData = potassiumLevelData
                                                        
                                                        //print("---------\n dietaryPotassium \nValue \(element.harmonized.value) \n---------")
                                                        
                                                    }
                                                    if try QuantityType.make(from: preferredUnit.identifier) == QuantityType.dietaryMagnesium {
                                                        
                                                        let magnesiumLevelData = CardioLabData(type: CardioLabsType.magnesiumLevel)
                                                        magnesiumLevelData.value = Double(element.harmonized.value)
                                                        self?.cardioData.cardioLab.magnesiumLevelData = magnesiumLevelData
                                                        
                                                        
                                                        //print("---------\n dietaryMagnesium \nValue \(element.harmonized.value) \n---------")
                                                        
                                                    }
                                                } catch {
                                                    //print(error)
                                                }
                                            }
                                            self?.readBloodPressureDone?()
                                            completion(success, nil)
                                        } else {
                                            //print("Error in quabtyt query")
                                            //print(error as Any)
                                        }
                                    }
                                    reporter.manager.executeQuery(query)
                                } catch {
                                    //print("Quantity query issue")
                                    //print(error)
                                   
                                }
                            }
                            
                        } else {
                            //print("Preffered unit issue")
                            //print(error as Any)
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
    
    
    
    func readSymptomsData(completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void){
        do {
            reporter = try HealthKitReporter()
            let types = CardioSymptomsReadValue()
            reporter?.manager.requestAuthorization(
                toRead: types,
                toWrite: []
            ){ (success, error) in
                if success && error == nil {
                    
                    for category in types {
                        do {
                            let query = try self.reporter?.reader.categoryQuery(type: category, limit: 1, resultsHandler: { [weak self] (results, error) in
                                if error == nil {
                                    for element in results {
                                        
                                        let chestPainData = CardioSymptomsPainData(type: category)
                                        chestPainData.value = Double(element.harmonized.value)
                                        chestPainData.startTime = element.startTimestamp
                                        chestPainData.endTime = element.endTimestamp
                                        switch category {
                                        case .chestTightnessOrPain:
                                            self?.cardioData.cardioSymptoms.chestPainData = chestPainData
                                        case .skippedHeartbeat:
                                            self?.cardioData.cardioSymptoms.skippedHeartBeatData = chestPainData
                                        case .dizziness:
                                            self?.cardioData.cardioSymptoms.dizzinessData = chestPainData
                                        case .fatigue:
                                            self?.cardioData.cardioSymptoms.fatigueData = chestPainData
                                        case .rapidPoundingOrFlutteringHeartbeat:
                                            self?.cardioData.cardioSymptoms.rapidHeartBeatData = chestPainData
                                        case .fainting:
                                            self?.cardioData.cardioSymptoms.faintingData = chestPainData
                                        case .nausea:
                                            self?.cardioData.cardioSymptoms.nauseaData = chestPainData
                                        case .vomiting:
                                            self?.cardioData.cardioSymptoms.vomitingData = chestPainData
                                        case .memoryLapse:
                                            self?.cardioData.cardioSymptoms.memoryLapseData = chestPainData
                                        case .shortnessOfBreath:
                                            self?.cardioData.cardioSymptoms.shortBreathData = chestPainData
                                        case .headache:
                                            self?.cardioData.cardioSymptoms.headacheData = chestPainData
                                        case .heartburn:
                                            self?.cardioData.cardioSymptoms.heartBurnData = chestPainData
                                        case .sleepChanges:
                                            self?.cardioData.cardioSymptoms.sleepChangesData = chestPainData
                                        default:
                                            self?.cardioData.cardioSymptoms.chestPainData = chestPainData
                                        }
                                        //print("---------\n CardioChestPainData element.harmonized \(element)")
                                        
                                        //print("---------\n CardioChestPainData \n category \(category) \n Value \(chestPainData.value)\n Score \(chestPainData.score)\n Max Score\(chestPainData.maxScore ?? 0.0) \n---------")
                                        
                                        
                                    }
                                    
                                    self?.readSymptomsDataDone?()
                                    completion(success, nil)
                                } else {
                                    //print("Error in quabtyt query")
                                    //print(error as Any)
                                }
                            })
                            self.reporter?.manager.executeQuery(query!)
                        } catch {
                            print("Quantity query issue")
                            //print(error)
                            
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
    func readLabDataTemp(completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void){
        HKSetupAssistance.authorizeLabDataKit { (samples, success, error) in
            if(success){
                
                print("samples------>\(samples)")
                for sample in samples{
                    guard let clinicalRecord = sample as? HKClinicalRecord, let fhirResource = clinicalRecord.fhirResource else {
                        return
                    }
                    do {
                        let sourceObject = try JSONSerialization.jsonObject(with: fhirResource.data, options: [])
                        let prettyPrintedSourceData = try JSONSerialization.data(withJSONObject: sourceObject, options: [.prettyPrinted])
                        
                        let sourceString = String(data: prettyPrintedSourceData, encoding: .utf8) ?? "Unable to display FHIR source."
                        
                        print(unescapeJSONString(sourceString))
                        if let dictionary = sourceObject as? [String: AnyObject] {
                            let valueQuantity = dictionary["valueQuantity"] as? [String: AnyObject]
                            let code = dictionary["code"] as? [String: AnyObject]
                            if let value = (valueQuantity?["value"] as? Double)  ,let codeKey = (code?["text"])  {
                                // access individual value in dictionary
                                print("\(codeKey)----->\(value)")
                                
                            }
                        }
                        
                        
                    } catch {
                        
                        completion(false, HealthkitSetupError.dataParsingError)
                    }
                    
                }
            }else{
                completion(success, error)
            }
        }
        
    }
    
    
    
    
    
    func readLabData(completion: @escaping (Bool, HealthkitSetupError?) -> Void){
        
        
        //Read bloodOxygenLevelData,potassiumLevelData,magnesiumLevelData from health kit
        readQuantityTypeData(quantityType: CardioLabDataeCategoryType()) { (success, error) in
            completion(success,error as? HealthkitSetupError)
        }
        
        //static data
        cardioData.cardioLab.bPeptideData = CardioLabData(type: CardioLabsType.bPeptide)
        cardioData.cardioLab.bPeptideData?.value = 0
        
        cardioData.cardioLab.troponinLevelData = CardioLabData(type: CardioLabsType.troponinLevel)
        cardioData.cardioLab.troponinLevelData?.value = 0.03
        
        cardioData.cardioLab.hemoglobinLevelData = CardioLabData(type: CardioLabsType.hemoglobin)
        cardioData.cardioLab.hemoglobinLevelData?.value = 17.6
        
        //Uncomment below code when use statci data.....
        //        cardioData.cardioLab.potassiumLevelData = CardioLabData(type: CardioLabsType.potassiumLevel)
        //        cardioData.cardioLab.potassiumLevelData?.value = 3
        //
        //        cardioData.cardioLab.magnesiumLevelData = CardioLabData(type: CardioLabsType.magnesiumLevel)
        //        cardioData.cardioLab.magnesiumLevelData?.value = 2
        //
        //        cardioData.cardioLab.bloodOxygenLevelData = CardioLabData(type: CardioLabsType.bloodOxygenLevel)
        //        cardioData.cardioLab.bloodOxygenLevelData?.value = 96
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            self.readLabDataDone?()
        }
        
    }
    
    func readConditionData(completion: @escaping (Bool, HealthkitSetupError?) -> Void){
        cardioData.cardioCondition.arrhythmiaData = CardioConditionData(type: .arrhythmia)
        cardioData.cardioCondition.arrhythmiaData?.value = 0
        cardioData.cardioCondition.hyperTenstionData = CardioConditionData(type: .hypertension)
        cardioData.cardioCondition.hyperTenstionData?.value = 0
        cardioData.cardioCondition.heartFailureData = CardioConditionData(type: .heartFailure)
        cardioData.cardioCondition.heartFailureData?.value = 0
        cardioData.cardioCondition.arteryDieseaseData = CardioConditionData(type: .arteryDisease)
        cardioData.cardioCondition.arteryDieseaseData?.value = 0
        completion(true,nil)
    }
    
    func setDefaultValueCardioData(){
        
        //set IMP data
        cardioData.cardioIMP.heartRateData = CardioVitals(type: CardioVitalsType.heartRate)
        cardioData.cardioIMP.heartRateData?.value = 80
        //print("(cardioData.cardioIMP.heartRateData?.maxScore)---\n \(String(describing: cardioData.cardioIMP.heartRateData?.maxScore))")
        //High heart rate
        cardioData.cardioIMP.highHeartRateData = CardioVitals(type: CardioVitalsType.highHeartRate)
        cardioData.cardioIMP.highHeartRateData?.value = 1
        //print("(cardioData.cardioIMP.highHeartRateData?.maxScore)---\n \(String(describing: cardioData.cardioIMP.highHeartRateData?.maxScore))")
        //low heart rate
        cardioData.cardioIMP.lowHeartRateData = CardioVitals(type: CardioVitalsType.lowHeartRate)
        cardioData.cardioIMP.lowHeartRateData?.value = 0
        //print("(cardioData.cardioIMP.lowHeartRateData?.maxScore)---\n \(String(describing: cardioData.cardioIMP.lowHeartRateData?.maxScore))")
        //High heart rate
        cardioData.cardioIMP.irregularRhythmNotificationData = CardioVitals(type: CardioVitalsType.irregularRhymesNotification)
        cardioData.cardioIMP.irregularRhythmNotificationData?.value = 0
        //print("(cardioData.cardioIMP.irregularRhythmNotificationData?.maxScore)---\n \(String(describing: cardioData.cardioIMP.irregularRhythmNotificationData?.maxScore))")
        //High heart rate
        cardioData.cardioIMP.vO2MaxData = CardioVitals(type: CardioVitalsType.vo2Max)
        cardioData.cardioIMP.vO2MaxData?.value = 35
        //print("(cardioData.cardioIMP.vO2MaxData?.maxScore)---\n \(String(describing: cardioData.cardioIMP.vO2MaxData?.maxScore))")
        //High heart rate
        cardioData.cardioIMP.systolicBloodPressureData = CardioVitals(type: CardioVitalsType.systolicBP)
        cardioData.cardioIMP.systolicBloodPressureData?.value = 90
        //print("(cardioData.cardioIMP.systolicBloodPressureData?.maxScore)---\n \(String(describing: cardioData.cardioIMP.systolicBloodPressureData?.maxScore))")
        //High heart rate
        cardioData.cardioIMP.diastolicBloodPressureData = CardioVitals(type: CardioVitalsType.diastolicBP)
        cardioData.cardioIMP.diastolicBloodPressureData?.value = 84
        //print("(cardioData.cardioIMP.diastolicBloodPressureData?.maxScore)---\n \(String(describing: cardioData.cardioIMP.diastolicBloodPressureData?.maxScore))")
        
        //set IMP data
        cardioData.cardioSymptoms.chestPainData = CardioSymptomsPainData(type: CategoryType.chestTightnessOrPain)
        cardioData.cardioSymptoms.chestPainData?.value = 1
        
        cardioData.cardioSymptoms.skippedHeartBeatData = CardioSymptomsPainData(type: CategoryType.skippedHeartbeat)
        cardioData.cardioSymptoms.skippedHeartBeatData?.value = 1
        
        cardioData.cardioSymptoms.dizzinessData = CardioSymptomsPainData(type: CategoryType.dizziness)
        cardioData.cardioSymptoms.dizzinessData?.value = 1
        
        cardioData.cardioSymptoms.fatigueData = CardioSymptomsPainData(type: CategoryType.fatigue)
        cardioData.cardioSymptoms.fatigueData?.value = 1
        
        cardioData.cardioSymptoms.rapidHeartBeatData = CardioSymptomsPainData(type: CategoryType.rapidPoundingOrFlutteringHeartbeat)
        cardioData.cardioSymptoms.rapidHeartBeatData?.value = 1
        
        cardioData.cardioSymptoms.faintingData = CardioSymptomsPainData(type: CategoryType.fainting)
        cardioData.cardioSymptoms.faintingData?.value = 1
        
        cardioData.cardioSymptoms.nauseaData = CardioSymptomsPainData(type: CategoryType.nausea)
        cardioData.cardioSymptoms.nauseaData?.value = 1
        
        cardioData.cardioSymptoms.vomitingData = CardioSymptomsPainData(type: CategoryType.vomiting)
        cardioData.cardioSymptoms.vomitingData?.value = 1
        
        cardioData.cardioSymptoms.memoryLapseData = CardioSymptomsPainData(type: CategoryType.memoryLapse)
        cardioData.cardioSymptoms.memoryLapseData?.value = 1
        
        cardioData.cardioSymptoms.shortBreathData = CardioSymptomsPainData(type: CategoryType.shortnessOfBreath)
        cardioData.cardioSymptoms.shortBreathData?.value = 1
        
        cardioData.cardioSymptoms.headacheData = CardioSymptomsPainData(type: CategoryType.headache)
        cardioData.cardioSymptoms.headacheData?.value = 1
        
        cardioData.cardioSymptoms.heartBurnData = CardioSymptomsPainData(type: CategoryType.heartburn)
        cardioData.cardioSymptoms.heartBurnData?.value = 1
        
        cardioData.cardioSymptoms.sleepChangesData = CardioSymptomsPainData(type: CategoryType.sleepChanges)
        cardioData.cardioSymptoms.sleepChangesData?.value = 1
        
        readLabData { (success, error) in
            
        }
        readConditionData{ (success, error) in
            
        }
        
        //print("getMaxVitalsScore cardioIMP---\n \(cardioData.cardioIMP.getMaxVitalsScore())")
        //print("totalVitalsScore cardioIMP---\n \(cardioData.cardioIMP.totalVitalsScore())")
        //print("getMaxSymptomDataScore cardioSymptoms---\n \(cardioData.cardioSymptoms.getMaxSymptomDataScore())")
        //print("totalSymptomDataScore cardioSymptoms---\n \(cardioData.cardioSymptoms.totalSymptomDataScore())")
        
        //print("getMaxConditionDataScore cardioCondition---\n \(cardioData.cardioCondition.getMaxConditionDataScore())")
        //print("totalConditionDataScore cardioCondition---\n \(cardioData.cardioCondition.totalConditionDataScore())")
        
        //print("getMaxLabDataScore cardioLab---\n \(cardioData.cardioLab.getMaxLabDataScore())")
        //print("totalLabDataScore cardioLab---\n \(cardioData.cardioLab.totalLabDataScore())")
        
    }
}

