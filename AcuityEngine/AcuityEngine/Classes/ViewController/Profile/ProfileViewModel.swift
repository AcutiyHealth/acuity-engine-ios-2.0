//
//  ProfileViewModel.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 16/10/21.
//

import Foundation

class ProfileViewModel: NSObject {
    func fetchMedicationData(completionHandler: @escaping(_ success:Bool,_ error:Error?,_ arrayForTblDataView:[[String:[String]]]) -> Void){
        //Global Queue
        
        DispatchQueue.global(qos: .background).async {
            
            //Fetch data......
            var arrayForTblDataView:[[String:[String]]] = []
            let medicationData = DBManager.shared.loadMedications()
            //Main Queue......
            DispatchQueue.main.async {
                /*
                 After fetching data from dataabse, prepare array of dicitonary. Dictionary will have key -> title of section and Value -> Array
                 Filter data with Id of Histyory type and fetch Medication Name and MAke it's key. Sp E.g. If id = 1, name will be otherCondition and key will be of other condition. IT will have value which have Id = 1 in database..
                 MedicationDataDisplayModel will have Id,name and textValue and TimeStamp...
                 */
                for id in MedicationId.allCases {
                    let filteredIdData = medicationData?.filter{$0.id == id}
                    if filteredIdData?.count ?? 0>0{
                        //Get name of filter data...
                        let name = filteredIdData?.first?.name?.rawValue
                        var arrStr:[String] = []
                        for item in filteredIdData! {
                            arrStr.append(item.txtValue ?? "")
                        }
                        arrayForTblDataView.append([name!:arrStr])
                        
                    }
                    
                }
                
                completionHandler(true,nil,arrayForTblDataView)
            }
            
        }
        /*
         Ex. of arrayForTblDataView = [[AcuityEngine.Medication.otherConditions: [AcuityEngine.MedicationDataDisplayModel]], [AcuityEngine.Medication.surgicalMedication: []],
         [AcuityEngine.Medication.familyMedication: [AcuityEngine.MedicationDataDisplayModel]],
         [AcuityEngine.Medication.socialMedication: []],
         [AcuityEngine.Medication.allergies: [AcuityEngine.MedicationDataDisplayModel]]]
         It has key of Section Title and Value are Array Of Input Data in Textfield which convert into model and save in database..
         */
    }
    func fetchHistoryData(completionHandler: @escaping(_ success:Bool,_ error:Error?,_ arrayForTblDataView:[[String:[String]]]) -> Void){
        //Global Queue
        
        DispatchQueue.global(qos: .background).async {
            
            //Fetch data......
            var arrayForTblDataView:[[String:[String]]] = []
            let arrayOfFetchedConditionFromDatabase = DBManager.shared.loadOnConditionsOnly();
            let historyData = DBManager.shared.loadHistories()
            //Main Queue......
            DispatchQueue.main.async {
                /*
                 After fetching data from dataabse, prepare array of dicitonary. Dictionary will have key -> title of section and Value -> Array
                 Filter data with Id of Histyory type and fetch Medication Name and MAke it's key. Sp E.g. If id = 1, name will be otherCondition and key will be of other condition. IT will have value which have Id = 1 in database..
                 MedicationDataDisplayModel will have Id,name and textValue and TimeStamp...
                 */
                if arrayOfFetchedConditionFromDatabase!.count  > 0{
                    var arrStr:[String] = []
                    
                    for item in arrayOfFetchedConditionFromDatabase! {
                        arrStr.append(item.title ?? "")
                    }
                    arrayForTblDataView.append([AddOption.conditions.rawValue:arrStr])
                }
                for id in OtherHistoryId.allCases {
                    let filteredIdData = historyData?.filter{$0.id == id}
                    if filteredIdData?.count ?? 0>0{
                        //Get name of filter data...
                        let name = filteredIdData?.first?.name?.rawValue
                        var arrStr:[String] = []
                        
                        for item in filteredIdData! {
                            arrStr.append(item.txtValue ?? "")
                        }
                        arrayForTblDataView.append([name!:arrStr])
                        
                    }
                    
                }
                
                completionHandler(true,nil,arrayForTblDataView)
            }
            
        }
        /*
         Ex. of arrayForTblDataView = [[AcuityEngine.Medication.otherConditions: [AcuityEngine.MedicationDataDisplayModel]], [AcuityEngine.Medication.surgicalMedication: []],
         [AcuityEngine.Medication.familyMedication: [AcuityEngine.MedicationDataDisplayModel]],
         [AcuityEngine.Medication.socialMedication: []],
         [AcuityEngine.Medication.allergies: [AcuityEngine.MedicationDataDisplayModel]]]
         It has key of Section Title and Value are Array Of Input Data in Textfield which convert into model and save in database..
         */
    }
}
