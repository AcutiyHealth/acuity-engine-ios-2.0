//
//  RespiratoryManager.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 03/02/21.
//


import Foundation
import HealthKit
import HealthKitReporter

class RespiratoryManager: NSObject {
    
    static let sharedManager = RespiratoryManager()
    private var reporter: HealthKitReporter?
    
    //Initialize Respiratory data...
    var respiratoryData = RespiratoryData()
    
    //Listner initialization
    var readIMPQuantityDataDone: (() -> Void)?
    var readIMPCategoryDataDone: (() -> Void)?
    var readSymptomsDataDone: (() -> Void)?
    var readLabDataDone: (() -> Void)?
    var readProblemDataDone: (() -> Void)?
    
    private lazy var heartRateType: HKQuantityType? = HKObjectType.quantityType(forIdentifier: .heartRate)
    
    
    
    func resetRespiratoryData(){
        respiratoryData = RespiratoryData()
    }
    
    func readIMPCategoryData(completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void) {
        do {
            reporter = try HealthKitReporter()
            let types = RespiratoryIMPCategoryType()
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
                                        
                                        let isTimeStampInToday = HKSetupAssistance.calculateNotificationIsInToday(elementTimeStamp: element.endTimestamp)
                                        //calculate that notification falls in today
                                        
                                        if isTimeStampInToday{
                                            let highHeartRate = RespiratoryIMPData(type: RespiratoryIMPDataType.highHeartRate)
                                            highHeartRate.value = 1
                                            self?.respiratoryData.respiratoryIMP.highHeartRateData = highHeartRate
                                            
                                        }
                                        //print("---------\n HighHeartRateData \nValue \(highHeartRate.value)\n Score \(highHeartRate.score)\n Max Score\(highHeartRate.maxScore ?? 0.0) \n---------")
                                        
                                        else  if category == CategoryType.lowHeartRateEvent {
                                            
                                            let isTimeStampInToday = HKSetupAssistance.calculateNotificationIsInToday(elementTimeStamp: element.endTimestamp)
                                            //calculate that notification falls in today
                                            
                                            if isTimeStampInToday{
                                                let lowHeartRate = RespiratoryIMPData(type: RespiratoryIMPDataType.lowHeartRate)
                                                lowHeartRate.value = 1
                                                self?.respiratoryData.respiratoryIMP.lowHeartRateData = lowHeartRate
                                            }
                                            //print("---------\n LowHeartRateData \nValue \(lowHeartRate.value)\n Score \(lowHeartRate.score)\n Max Score\(lowHeartRate.maxScore ?? 0.0) \n---------")
                                            
                                        } else  if category == CategoryType.irregularHeartRhythmEvent {
                                            
                                            let isTimeStampInToday = HKSetupAssistance.calculateNotificationIsInToday(elementTimeStamp: element.endTimestamp)
                                            //calculate that notification falls in today
                                            
                                            if isTimeStampInToday{
                                                let irregularRhymesNotification = RespiratoryIMPData(type: RespiratoryIMPDataType.irregularRhymesNotification)
                                                irregularRhymesNotification.value = 1
                                                self?.respiratoryData.respiratoryIMP.irregularRhymesNotificationData = irregularRhymesNotification
                                            }
                                            //print("---------\n IrregularRhythmNotificationData \nValue \(irregularRhymesNotification.value)\n Score \(irregularRhymesNotification.score)\n Max Score\(irregularRhymesNotification.maxScore ?? 0.0) \n---------")
                                        }
                                        
                                    }
                                    self?.readIMPCategoryDataDone?()
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
    
    func readIMPQuantityData(completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void) {
        readQuantityTypeData(quantityType: RespiratoryIMPQuantityType()){ (success, error) in
            completion(success,error)
        }
    }
    
    func readQuantityTypeData(quantityType:[QuantityType],completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void) {
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
                                                    
                                                    if try QuantityType.make(from: preferredUnit.identifier) == QuantityType.respiratoryRate {
                                                        
                                                        let respiratoryRate = RespiratoryIMPData(type: RespiratoryIMPDataType.respiratoryRate)
                                                        respiratoryRate.value = Double(element.harmonized.value)
                                                        self?.respiratoryData.respiratoryIMP.respiratoryRateData = respiratoryRate
                                                        
                                                        
                                                        //print("---------\n bloodPressureSystolic \nValue \(systolicBP.value)\n Score \(systolicBP.score)\n Max Score\(systolicBP.maxScore ?? 0.0) \n---------")
                                                        
                                                    } else  if try QuantityType.make(from: preferredUnit.identifier) == QuantityType.peakExpiratoryFlowRate {
                                                        
                                                        let peakFlowRate = RespiratoryIMPData(type: RespiratoryIMPDataType.peakFlowRate)
                                                        peakFlowRate.value = Double(element.harmonized.value)
                                                        self?.respiratoryData.respiratoryIMP.peakFlowRateData = peakFlowRate
                                                        
                                                        
                                                        //print("---------\n bloodPressureDiastolic \nValue \(diastolicBP.value)\n Score \(diastolicBP.score)\n Max Score\(diastolicBP.maxScore ?? 0.0) \n---------")
                                                        
                                                    } else  if try QuantityType.make(from: preferredUnit.identifier) == QuantityType.vo2Max {
                                                        
                                                        let vo2Max = RespiratoryIMPData(type: RespiratoryIMPDataType.vo2Max)
                                                        vo2Max.value = Double(element.harmonized.value)
                                                        self?.respiratoryData.respiratoryIMP.vO2MaxData = vo2Max
                                                        
                                                        
                                                        //print("---------\n VO2MaxData \nValue \(vo2Max.value)\n Score \(vo2Max.score)\n Max Score\(vo2Max.maxScore ?? 0.0) \n---------")
                                                        
                                                    } else  if try QuantityType.make(from: preferredUnit.identifier) == QuantityType.heartRate {
                                                        
                                                        let heartRate = RespiratoryIMPData(type: RespiratoryIMPDataType.heartRate)
                                                        heartRate.value = Double(element.harmonized.value)
                                                        self?.respiratoryData.respiratoryIMP.heartRateData = heartRate
                                                        
                                                        
                                                        //print("---------\n HeartRateData \nValue \(heartRate.value)\n Score \(heartRate.score)\n Max Score\(heartRate.maxScore ?? 0.0) \n---------")
                                                    }
                                                    else  if try QuantityType.make(from: preferredUnit.identifier) == QuantityType.sixMinuteWalkTestDistance {
                                                        
                                                        let sixMinWalk = RespiratoryIMPData(type: RespiratoryIMPDataType.sixMinWalk)
                                                        sixMinWalk.value = Double(element.harmonized.value)
                                                        self?.respiratoryData.respiratoryIMP.sixMinWalkData = sixMinWalk
                                                        
                                                        
                                                        //print("---------\n HeartRateData \nValue \(heartRate.value)\n Score \(heartRate.score)\n Max Score\(heartRate.maxScore ?? 0.0) \n---------")
                                                    }
                                                    else  if try QuantityType.make(from: preferredUnit.identifier) == QuantityType.forcedExpiratoryVolume1 {
                                                        
                                                        let fev1 = RespiratoryIMPData(type: RespiratoryIMPDataType.fev1)
                                                        fev1.value = Double(element.harmonized.value)
                                                        self?.respiratoryData.respiratoryIMP.FEV1Data = fev1
                                                        
                                                        
                                                        //print("---------\n HeartRateData \nValue \(heartRate.value)\n Score \(heartRate.score)\n Max Score\(heartRate.maxScore ?? 0.0) \n---------")
                                                    }
                                                    else  if try QuantityType.make(from: preferredUnit.identifier) == QuantityType.inhalerUsage {
                                                        
                                                        let inhalerUsage = RespiratoryIMPData(type: RespiratoryIMPDataType.inhalerUsage)
                                                        inhalerUsage.value = Double(element.harmonized.value)
                                                        self?.respiratoryData.respiratoryIMP.inhalerUsageData = inhalerUsage
                                                        
                                                        
                                                        //print("---------\n HeartRateData \nValue \(heartRate.value)\n Score \(heartRate.score)\n Max Score\(heartRate.maxScore ?? 0.0) \n---------")
                                                    }
                                                    //======== LAB Data ===========//
                                                    if try QuantityType.make(from: preferredUnit.identifier) == QuantityType.oxygenSaturation {
                                                        
                                                        let bloodOxygenLevelData = RespiratoryLabData(type: RespiratoryLabsType.bloodOxygenLevel)
                                                        bloodOxygenLevelData.value = Double(element.harmonized.value) * 100
                                                        self?.respiratoryData.respiratoryLab.bloodOxygenLevelData = bloodOxygenLevelData
                                                        
                                                        //print("---------\n oxygenSaturation \nValue \(element.harmonized.value) \n---------")
                                                        
                                                    }
                                                    
                                                    
                                                } catch {
                                                    //print(error)
                                                }
                                            }
                                            self?.readIMPQuantityDataDone?()
                                            completion(success, nil)
                                        } else {
                                            //print("Error in quabtyt query")
                                            //print(error as Any)
                                        }
                                    }
                                    reporter.manager.executeQuery(query)
                                } catch {
                                    print("Quantity query issue")
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
            let types = RespiratorySymptomsReadValue()
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
                                        
                                        let chestPainData = RespiratorySymptomsPainData(type: category)
                                        chestPainData.value = Double(element.harmonized.value)
                                        chestPainData.startTime = element.startTimestamp
                                        chestPainData.endTime = element.endTimestamp
                                        switch category {
                                        case .chestTightnessOrPain:
                                            self?.respiratoryData.respiratorySymptoms.chestPainData = chestPainData
                                        case .skippedHeartbeat:
                                            self?.respiratoryData.respiratorySymptoms.skippedHeartBeatData = chestPainData
                                        case .coughing:
                                            self?.respiratoryData.respiratorySymptoms.coughData = chestPainData
                                        case .wheezing:
                                            self?.respiratoryData.respiratorySymptoms.wheezeData = chestPainData
                                        case .rapidPoundingOrFlutteringHeartbeat:
                                            self?.respiratoryData.respiratorySymptoms.rapidHeartBeatData = chestPainData
                                        case .fainting:
                                            self?.respiratoryData.respiratorySymptoms.faintingData = chestPainData
                                        case .shortnessOfBreath:
                                            self?.respiratoryData.respiratorySymptoms.shortBreathData = chestPainData
                                        default:
                                            self?.respiratoryData.respiratorySymptoms.chestPainData = chestPainData
                                        }
                                        //print("---------\n RespiratoryChestPainData element.harmonized \(element)")
                                        
                                        //print("---------\n RespiratoryChestPainData \n category \(category) \n Value \(chestPainData.value)\n Score \(chestPainData.score)\n Max Score\(chestPainData.maxScore ?? 0.0) \n---------")
                                        
                                        
                                    }
                                    self?.readSymptomsDataDone?()
                                } else {
                                    //print("Error in quabtyt query")
                                    //print(error as Any)
                                }
                            })
                            self.reporter?.manager.executeQuery(query!)
                        } catch {
                            //print("Quantity query issue")
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
    
    func readLabData(completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void){
        //static data
        readQuantityTypeData(quantityType: RespiratoryLabDataeCategoryType()){ (success, error) in
            completion(success,error)
        }
        respiratoryData.respiratoryLab.HCO3Data = RespiratoryLabData(type: RespiratoryLabsType.HCO3)
        respiratoryData.respiratoryLab.HCO3Data?.value = 26
        
        respiratoryData.respiratoryLab.O2SatData = RespiratoryLabData(type: RespiratoryLabsType.O2)
        respiratoryData.respiratoryLab.O2SatData?.value = 95
        
        respiratoryData.respiratoryLab.PaCO2Data = RespiratoryLabData(type: RespiratoryLabsType.PaCO2)
        respiratoryData.respiratoryLab.PaCO2Data?.value = 40
        
        respiratoryData.respiratoryLab.PaO2Data = RespiratoryLabData(type: RespiratoryLabsType.PaO2)
        respiratoryData.respiratoryLab.PaO2Data?.value = 80
        
        respiratoryData.respiratoryLab.bicarbonateData = RespiratoryLabData(type: RespiratoryLabsType.bicarbonate)
        respiratoryData.respiratoryLab.bicarbonateData?.value = 27
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            self.readLabDataDone?()
        }
        
    }
    
    func readProblemData(completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void){
        respiratoryData.respiratoryProblem.COPDData = RespiratoryProblemData(type: RespiratoryProblemType.COPD)
        respiratoryData.respiratoryProblem.COPDData?.value = 1
        respiratoryData.respiratoryProblem.allergicRhiniitisData = RespiratoryProblemData(type: RespiratoryProblemType.allergicRhiniitis)
        respiratoryData.respiratoryProblem.allergicRhiniitisData?.value = 0
        respiratoryData.respiratoryProblem.asthmaData = RespiratoryProblemData(type: RespiratoryProblemType.asthma)
        respiratoryData.respiratoryProblem.asthmaData?.value = 0
        respiratoryData.respiratoryProblem.pneumoniaData = RespiratoryProblemData(type: RespiratoryProblemType.pneumonia)
        respiratoryData.respiratoryProblem.pneumoniaData?.value = 0
        respiratoryData.respiratoryProblem.pulmonaryEmbolismData = RespiratoryProblemData(type: RespiratoryProblemType.pulmonaryEmbolism)
        respiratoryData.respiratoryProblem.pulmonaryEmbolismData?.value = 0
        respiratoryData.respiratoryProblem.smoking = RespiratoryProblemData(type: RespiratoryProblemType.smoking)
        respiratoryData.respiratoryProblem.smoking?.value = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            self.readProblemDataDone?()
        }
    }
    
    func setDefaultValueRespiratoryData(){
        
        //set IMP data
        respiratoryData.respiratoryIMP.heartRateData = RespiratoryIMPData(type: RespiratoryIMPDataType.heartRate)
        respiratoryData.respiratoryIMP.heartRateData?.value = 40
        
        respiratoryData.respiratoryIMP.highHeartRateData = RespiratoryIMPData(type: RespiratoryIMPDataType.highHeartRate)
        respiratoryData.respiratoryIMP.highHeartRateData?.value = 0
        
        respiratoryData.respiratoryIMP.lowHeartRateData = RespiratoryIMPData(type: RespiratoryIMPDataType.lowHeartRate)
        respiratoryData.respiratoryIMP.lowHeartRateData?.value = 0
        
        respiratoryData.respiratoryIMP.irregularRhymesNotificationData = RespiratoryIMPData(type: RespiratoryIMPDataType.irregularRhymesNotification)
        respiratoryData.respiratoryIMP.irregularRhymesNotificationData?.value = 0
        
        respiratoryData.respiratoryIMP.vO2MaxData = RespiratoryIMPData(type: RespiratoryIMPDataType.vo2Max)
        respiratoryData.respiratoryIMP.vO2MaxData?.value = 30
        
        respiratoryData.respiratoryIMP.FEV1Data = RespiratoryIMPData(type: RespiratoryIMPDataType.fev1)
        respiratoryData.respiratoryIMP.FEV1Data?.value = 2.5
        
        respiratoryData.respiratoryIMP.inhalerUsageData = RespiratoryIMPData(type: RespiratoryIMPDataType.inhalerUsage)
        respiratoryData.respiratoryIMP.inhalerUsageData?.value = 0
        
        //set Symptom data
        respiratoryData.respiratorySymptoms.chestPainData = RespiratorySymptomsPainData(type: CategoryType.chestTightnessOrPain)
        respiratoryData.respiratorySymptoms.chestPainData?.value = 1
        
        respiratoryData.respiratorySymptoms.skippedHeartBeatData = RespiratorySymptomsPainData(type: CategoryType.skippedHeartbeat)
        respiratoryData.respiratorySymptoms.skippedHeartBeatData?.value = 2
        
        respiratoryData.respiratorySymptoms.rapidHeartBeatData = RespiratorySymptomsPainData(type: CategoryType.rapidPoundingOrFlutteringHeartbeat)
        respiratoryData.respiratorySymptoms.rapidHeartBeatData?.value = 2
        
        respiratoryData.respiratorySymptoms.faintingData = RespiratorySymptomsPainData(type: CategoryType.fainting)
        respiratoryData.respiratorySymptoms.faintingData?.value = 1
        
        respiratoryData.respiratorySymptoms.coughData = RespiratorySymptomsPainData(type: CategoryType.coughing)
        respiratoryData.respiratorySymptoms.coughData?.value = 3
        
        respiratoryData.respiratorySymptoms.wheezeData = RespiratorySymptomsPainData(type: CategoryType.wheezing)
        respiratoryData.respiratorySymptoms.wheezeData?.value = 1
        
        respiratoryData.respiratorySymptoms.shortBreathData = RespiratorySymptomsPainData(type: CategoryType.shortnessOfBreath)
        respiratoryData.respiratorySymptoms.shortBreathData?.value = 1
        
        readLabData { (success, error) in
            
        }
        readProblemData{ (success, error) in
            
        }
        print("getMaxIMPDataScore respiratoryIMP---\n \(respiratoryData.respiratoryIMP.getMaxIMPDataScore())")
        print("totalIMPDataScore respiratoryIMP---\n \(respiratoryData.respiratoryIMP.totalIMPDataScore())")
        print("getMaxSymptomDataScore respiratorySymptoms---\n \(respiratoryData.respiratorySymptoms.getMaxSymptomDataScore())")
        print("totalSymptomDataScore respiratorySymptoms---\n \(respiratoryData.respiratorySymptoms.totalSymptomDataScore())")
        
        print("getMaxProblemDataScore respiratoryProblem---\n \(respiratoryData.respiratoryProblem.getMaxProblemDataScore())")
        print("totalProblemDataScore respiratoryProblem---\n \(respiratoryData.respiratoryProblem.totalProblemDataScore())")
        
        print("getMaxLabDataScore respiratoryLab---\n \(respiratoryData.respiratoryLab.getMaxLabDataScore())")
        print("totalLabDataScore respiratoryLab---\n \(respiratoryData.respiratoryLab.totalLabDataScore())")
        
    }
}

