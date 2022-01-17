//
//  ProfileViewModel.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 16/10/21.
//

import Foundation

class ProfileViewModel: NSObject {
    //MARK: Fetch Medication Data
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
                 Filter data with Id of Medication type and fetch Medication Name and MAke it's key. Sp E.g. If id = 1, name will be Medication and key will be of Medication. It will have value(text) which have Id = 1 in database..
                 MedicationDataDisplayModel will have Id,name and textValue and TimeStamp...
                 */
                for id in MedicationId.allCases {
                    //Filter Data with Medication Id...
                    let filteredIdData = medicationData?.filter{$0.id == id}
                    if filteredIdData?.count ?? 0>0{
                        //Get name of filter data...
                        let name = filteredIdData?.first?.name?.rawValue
                        var arrStr:[String] = []
                        //Get text value of filter data...
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
    //MARK: Fetch Prevention Tracker Data
    func fetchPreventionTrackerData(completionHandler: @escaping(_ success:Bool,_ error:Error?,_ arrayForTblDataView:[[String:[String]]]) -> Void){
        //Global Queue
        
        DispatchQueue.global(qos: .background).async {
            
            //Fetch data......
            var arrayForTblDataView:[[String:[String]]] = []
            var preventionTrackerData = DBManager.shared.loadYesPreventionsOnly()
            preventionTrackerData = Utility.shared.filterPreventionDataForAgeAndGender(preventionData: preventionTrackerData, age: ProfileSharedData.shared.age, gender: ProfileSharedData.shared.sex)
            //Main Queue......
            DispatchQueue.main.async {
                /*
                 After fetching data from dataabse, prepare array of dicitonary. Dictionary will have key -> title of section and Value -> Array
                 Filter data with Id of Medication type and fetch Medication Name and MAke it's key. Sp E.g. If id = 1, name will be Medication and key will be of Medication. It will have value(text) which have Id = 1 in database..
                 MedicationDataDisplayModel will have Id,name and textValue and TimeStamp...
                 */
                if preventionTrackerData.count>0{
                    var arrTitle:[String] = []
                    let _ = preventionTrackerData.map { objPreventionTracker in
                        arrTitle.append(objPreventionTracker.specificRecommendation?.title ?? "")
                    }
                    arrayForTblDataView.append([AddOption.preventionTracker.rawValue:arrTitle])
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
    //MARK: Fetch History And Condition Data
    func fetchHistoryData(completionHandler: @escaping(_ success:Bool,_ error:Error?,_ arrayForTblDataView:[[String:[String]]]) -> Void){
        //Global Queue
        
        DispatchQueue.global(qos: .background).async {
            
            //Fetch data......
            var arrayForTblDataView:[[String:[String]]] = []
            //Fetch data from Condition from Add Section
            let arrayOfFetchedConditionFromDatabase = DBManager.shared.loadOnConditionsOnly();
            //Feth History Data......
            let historyData = DBManager.shared.loadHistories()
            //Main Queue......
            DispatchQueue.main.async {
                /*
                 After fetching data from dataabse, prepare array of dicitonary. Dictionary will have key -> title of section and Value -> Array
                 Filter data with Id of Histyory type and fetch History Name and MAke it's key. Sp E.g. If id = 1, name will be otherCondition and key will be of other condition. IT will have value which have Id = 1 in database..
                 MedicationDataDisplayModel will have Id,name and textValue and TimeStamp...
                 */
                //Here Prepare one array of String and append string array to arrayForTblDataView with key Condition...
                if arrayOfFetchedConditionFromDatabase!.count  > 0{
                    var arrStr:[String] = []
                    
                    for item in arrayOfFetchedConditionFromDatabase! {
                        arrStr.append(item.title ?? "")
                    }
                    arrayForTblDataView.append([AddOption.conditions.rawValue:arrStr])
                }
                
                for id in OtherHistoryId.allCases {
                    //Filter Data with History Id...
                    let filteredIdData = historyData?.filter{$0.id == id}
                    if filteredIdData?.count ?? 0>0{
                        //Get name of filter data...
                        let name = filteredIdData?.first?.name?.rawValue
                        //Prepare array from value of specific history...
                        //It will have name as key and value as array....
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
