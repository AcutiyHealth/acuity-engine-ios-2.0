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
    /*
     https://docs.google.com/spreadsheets/d/1XDGg4u6Nvzrbv-BZLzwWlRcGAf6FsAecC_I2yKozHIE/edit#gid=946627644
     */
    func readConditionsDataFromDatabase(completion: @escaping (Bool, Error?) -> Swift.Void)
    {
        DispatchQueue.global().async {
            self.fetchConditionsDataFromDatabase { (success, error) in
                completion(success,error)
            }
        }
    }
    func fetchConditionsDataFromDatabase(completion: @escaping (Bool, Error?) -> Swift.Void){
        
        if let conditionArray = DBManager.shared.loadOnConditionsOnly(){
            for element in conditionArray{
                saveDataInSystemsForCalculation(element: element)
            }
            completion(true, nil)
            return
        }
        completion(false, nil)
    }
    
    func saveDataInSystemsForCalculation(element:ConditionsModel){
        //print("saveConditionsData===========>")
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
        //Save data for Neuro...
        NeuroManager.sharedManager.saveConditionsData(element: element)
        //Save data for SDH...
        SDHManager.sharedManager.saveConditionsData(element: element)
        //Save data for Musc...
        MuscManager.sharedManager.saveConditionsData(element: element)
        //Save data for Skin...
        SkinManager.sharedManager.saveConditionsData(element: element)
        //Save data for Heent...
        HeentManager.sharedManager.saveConditionsData(element: element)
    }
}
