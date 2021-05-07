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
                        let prettyPrintedSourceData = try JSONSerialization.data(withJSONObject: sourceObject, options: [.prettyPrinted])
                        
                        let sourceString = String(data: prettyPrintedSourceData, encoding: .utf8) ?? "Unable to display FHIR source."
                        
                        print(unescapeJSONString(sourceString))
                        if let dictionary = sourceObject as? [String: AnyObject] {
                            let valueQuantity = dictionary["valueQuantity"] as? [String: AnyObject]
                            let dictionaryCode = dictionary["code"] as? [String: AnyObject]
                            let dictionaryCoding = dictionaryCode?["coding"]?.firstObject as? [String: AnyObject]
                            if let value = (valueQuantity?["value"] as? Double)  ,let code = (dictionaryCoding?["code"] as? String)  {
                             
                                if code == "2085-9"{
                                    // access individual value in dictionary
                                    print("\(code)----->\(value)")
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
