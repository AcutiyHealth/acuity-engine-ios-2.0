//
//  HKManagerReadConditions.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 29/04/21.
//

import Foundation

class HKManagerReadConditions: NSObject
{
    static let sharedManager = HKManagerReadConditions()
    
    override init() {
        super.init()
        
    }
    func readConditionsDataFromDatabase(completion: @escaping (Bool, Error?) -> Swift.Void)
    {
        DispatchQueue.global().async {
            do {
                // Fetch data from Txt file and convert it in array to display in tableview
                if  let isConditionDataAdded = UserDefaults.standard.string(forKey: "isConditionDataAdded"){
                    if isConditionDataAdded == "Yes"{
                        self.fetchConditionsDataFromDatabase { (success, error) in
                            completion(success,error)
                        }
                    }
                }else{
                    //save condition data in database
                    DBManager.shared.insertConditionData(completionHandler: { (sucess,error) in
                        if sucess{
                            UserDefaults.standard.set("Yes", forKey: "isConditionDataAdded") //String
                            self.fetchConditionsDataFromDatabase{ (success, error) in
                                completion(success,error)
                            }
                        }
                    })
                }
                
            }
        }
    }
    func fetchConditionsDataFromDatabase(completion: @escaping (Bool, Error?) -> Swift.Void){
        
        if let conditionArray = DBManager.shared.loadOnConditionsOnly(){
            for element in conditionArray{
                print("saveConditionsData===========>")
                //Save data for Cardio...
                CardioManager.sharedManager.saveConditionsData(element: element)
                //Save data for Respiratory...
                RespiratoryManager.sharedManager.saveConditionsData(element: element)
                //Save data for Renal...
                RenalManager.sharedManager.saveConditionsData(element: element)
                //Save data for IDisease...
                IDiseaseManager.sharedManager.saveConditionsData(element: element)
                //Save data for FNE...
                FNEManager.sharedManager.saveConditionsData(element: element)
                //Save data for Hemato...
                HematoManager.sharedManager.saveConditionsData(element: element)
                //Save data for Endocrine...
                EndocrineManager.sharedManager.saveConditionsData(element: element)
                //Save data for Gastrointestinal...
                GastrointestinalManager.sharedManager.saveConditionsData(element: element)
                //Save data for Genitourinary...
                GenitourinaryManager.sharedManager.saveConditionsData(element: element)
            }
            completion(true, nil)
            return
        }
        completion(false, nil)
    }
}
