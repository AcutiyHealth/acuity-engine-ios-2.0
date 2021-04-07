//
//  RespiratoryViewModel.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation

protocol RespiratoryViewModelProtocol {
    
    var respiratoryDataLoaded: ((Bool, HealthkitSetupError?) -> Void)? { get set }
    
    func fetchAndLoadRespiratoryData()
}
class RespiratoryViewModel: RespiratoryViewModelProtocol {
    var respiratoryDataLoaded: ((Bool, HealthkitSetupError?) -> Void)?
    
    //MARK: - Internal Properties
    
    func fetchAndLoadRespiratoryData(){
        readAllespiratoryData()
        //Read IMP Data bloodpressure
       /* RespiratoryManager.sharedManager.readIMPQuantityDataDone = {
            //self.reloadTable()
        }
        //Read IMP Data heartrate
        RespiratoryManager.sharedManager.readIMPCategoryDataDone = {
            //self.reloadTable()
        }
        //Read Lab data
        RespiratoryManager.sharedManager.readLabDataDone = {
            //self.respiratoryDataLoaded?()
        }
        //Read Condition data
        RespiratoryManager.sharedManager.readConditionDataDone = {
            //self.respiratoryDataLoaded?()
        }
        //Read Symptoms data
        RespiratoryManager.sharedManager.readSymptomsDataDone = {
            //self.reloadTable()
        }*/
    }
    
    func readAllespiratoryData(){
       /* RespiratoryManager.sharedManager.resetRespiratoryData()
       
        RespiratoryManager.sharedManager.readIMPCategoryData{ (success, error) in
            self.respiratoryDataLoaded?(success,error)
        }
        RespiratoryManager.sharedManager.readIMPQuantityData{ (success, error) in
            self.respiratoryDataLoaded?(success,error)
        }
        RespiratoryManager.sharedManager.readSymptomsData{ (success, error) in
            self.respiratoryDataLoaded?(success,error)
        }
        RespiratoryManager.sharedManager.readLabData{ (success, error) in
            self.respiratoryDataLoaded?(success,error)
        }
        RespiratoryManager.sharedManager.readConditionData{ (success, error) in
            self.respiratoryDataLoaded?(success,error)
        }*/
        
        //RespiratoryManager.sharedManager.setDefaultValueRespiratoryData()
    }
    
}







