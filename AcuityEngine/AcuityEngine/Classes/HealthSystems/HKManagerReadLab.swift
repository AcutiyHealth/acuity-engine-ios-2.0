//
//  HKManagerReadSymptoms.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 23/03/21.
//

import Foundation
import HealthKit
import HealthKitReporter

class HKManagerReadLab: NSObject
{
    static let sharedManager = HKManagerReadLab()
    private var reporter: HealthKitReporter?
    
    override init() {
        super.init()
        
    }
    
    func readLabDataTemp(completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void){
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        HKSetupAssistance.authorizeLabDataKit { (samples, success, error) in
            
            if(success){
                
                //print("samples------>\(samples)")
                var i = 0;
                for sample in samples{
                    guard let clinicalRecord = sample as? HKClinicalRecord, let fhirResource = clinicalRecord.fhirResource else {
                        return
                    }
                    i = i + 1;
                    print("i------>\(i)")
                    do {
                       
                        let sourceObject = try JSONSerialization.jsonObject(with: fhirResource.data, options: [])
//                        let report = try DiagnosticReport(json: sourceObject as! FHIRJSON)
//                        var contecxt = FHIRInstantiationContext()
//                        report.populate(from: sourceObject as! FHIRJSON, context: &contecxt)
//                        report.issued?.date
//                        print("report.issued?.date",report.issued?.date)
                        let prettyPrintedSourceData = try JSONSerialization.data(withJSONObject: sourceObject, options: [.prettyPrinted])
                        
                        let sourceString = String(data: prettyPrintedSourceData, encoding: .utf8) ?? "Unable to display FHIR source."
                        
                        print(unescapeJSONString(sourceString))
                        if let dictionary = sourceObject as? [String: AnyObject] {
                            //Fetch Value of Lab Data
                            let valueQuantity = dictionary["valueQuantity"] as? [String: AnyObject]
                            
                            //Timestamp for Lab Data
                            let issueDate = dictionary["issued"] as? String
                            var timeStampOfLabData = issueDate?.iso8601withFractionalSeconds?.timeIntervalSince1970 ?? 0
                            if timeStampOfLabData == 0{
                                 timeStampOfLabData = issueDate?.iso8601withFractionalSecondsNew?.timeIntervalSince1970 ?? 0
                            }
                            print("timeStampOfLabData",timeStampOfLabData)
                            
                            //Code for  Lab Data
                            let dictionaryCode = dictionary["code"] as? [String: AnyObject]
                            let dictionaryCoding = dictionaryCode?["coding"]?.firstObject as? [String: AnyObject]
                            
                            /*
                             Logic : We will fetch  all data and before preparing model for system, first we check is it in 3 months data from Today? If yes, we prepare model from it and store it in system...
                             */
                            let now = MyWellScore.sharedManager.todaysDate
                            var component = Calendar.Component.day
                            var beforeDaysOrWeekOrMonth = 1
                            
                            
                            component = .month
                            beforeDaysOrWeekOrMonth = 3
                            let daysAgo = Calendar.current.date(byAdding: component, value: -beforeDaysOrWeekOrMonth, to: now)!
                            
                            let timeIntervalByLastMonth:Double = daysAgo.timeIntervalSince1970
                            //print("timeIntervalByLastMonth",getDateMediumFormat(time:timeIntervalByLastMonth))
                            let timeIntervalByNow:Double = now.timeIntervalSince1970
//
                            /*
                             For testing,If data is more than 3 months old, we can test by  beforeDaysOrWeekOrMonth = 10 and timeStampOfLabData = timeIntervalByNow
                             */
//                            print("timeStampOfLabData \(timeStampOfLabData)")
//                            print("timeIntervalByLastMonth \(timeIntervalByLastMonth)")
//                            print("timeIntervalByNow \(timeIntervalByNow)")
//
                            //Below code need to uncomment....
                            if (timeStampOfLabData >= timeIntervalByLastMonth && timeStampOfLabData <= timeIntervalByNow){
                                
                                //Pass value,code and timestamp to manager of all system...
                                if let value = (valueQuantity?["value"] as? Double)  ,let code = (dictionaryCoding?["code"] as? String)  {
                                    print("[code]",code)
                                    //code = "2951-2" // Comment this
                                    //if code == "2823-3"{ //Uncoment this....
                                    // access individual value in dictionary
                                    //Save Data For Cardio..
                                    CardioManager.sharedManager.saveLabData(code: code, value: value, timeStamp: Double(timeStampOfLabData))
                                    //Save Data For Respiratory..
                                    RespiratoryManager.sharedManager.saveLabData(code: code, value: value, timeStamp: Double(timeStampOfLabData))
                                    //Save Data For Renal..
                                    RenalManager.sharedManager.saveLabData(code: code, value: value, timeStamp: Double(timeStampOfLabData))
                                    //Save Data For IDiseaseManager..
                                    IDiseaseManager.sharedManager.saveLabData(code: code, value: value, timeStamp: Double(timeStampOfLabData))
                                    //Save Data For FNE..
                                    FNEManager.sharedManager.saveLabData(code: code, value: value, timeStamp: Double(timeStampOfLabData))
                                    //Save Data For Hemato..
                                    HematoManager.sharedManager.saveLabData(code: code, value: value, timeStamp: Double(timeStampOfLabData))
                                    //Save Data For Endocrine..
                                    EndocrineManager.sharedManager.saveLabData(code: code, value: value, timeStamp: Double(timeStampOfLabData))
                                    //Save Data For Gastrointestinal..
                                    GastrointestinalManager.sharedManager.saveLabData(code: code, value: value, timeStamp: Double(timeStampOfLabData))
                                    //Save Data For Genitourinary..
                                    GenitourinaryManager.sharedManager.saveLabData(code: code, value: value, timeStamp: Double(timeStampOfLabData))
                                    //Save Data For Neuro System..
                                    NeuroManager.sharedManager.saveLabData(code: code, value: value, timeStamp: Double(timeStampOfLabData))
                                    //Save Data For SDH System..
                                    SDHManager.sharedManager.saveLabData(code: code, value: value, timeStamp: Double(timeStampOfLabData))
                                    //Save Data For Musc System..
                                    MuscManager.sharedManager.saveLabData(code: code, value: value, timeStamp: Double(timeStampOfLabData))
                                    //Save Data For Skin System..
                                    SkinManager.sharedManager.saveLabData(code: code, value: value, timeStamp: Double(timeStampOfLabData))
                                    //Save Data For Heent System..
                                    HeentManager.sharedManager.saveLabData(code: code, value: value, timeStamp: Double(timeStampOfLabData))
                                    //}
                                    
                                }
                            }
                        }
                        
                    } catch {
                        dispatchGroup.leave()
                        completion(false, HealthkitSetupError.dataParsingError)
                    }
                    
                }
                dispatchGroup.leave()
                dispatchGroup.notify(queue: .main) {
                    
                    DispatchQueue.main.async {
                        completion(success, nil)
                    }
                }
                
            }else{
                dispatchGroup.leave()
                completion(success, error)
            }
        }
        print("lab result error")
    }
    
    
}
