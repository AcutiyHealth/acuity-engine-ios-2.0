//
//  CardioViewModel.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation

protocol CardioViewModelProtocol {
    
    var cardioDataLoaded: ((Bool, HealthkitSetupError?) -> Void)? { get set }
    
    func fetchAndLoadCardioData()
}
class CardioViewModel: CardioViewModelProtocol {
    var cardioDataLoaded: ((Bool, HealthkitSetupError?) -> Void)?
    
    //MARK: - Internal Properties
    
    func fetchAndLoadCardioData(){
        readAllCardioData()
        //Read IMP Data bloodpressure
        CardioManager.sharedManager.readBloodPressureDone = {
            //self.reloadTable()
        }
        //Read IMP Data heartrate
        CardioManager.sharedManager.readIrregularHeartDataDone = {
            //self.reloadTable()
        }
        //Read Lab data
        CardioManager.sharedManager.readLabDataDone = {
            //self.cardioDataLoaded?()
        }
        //Read Condition data
        CardioManager.sharedManager.readConditionDataDone = {
            //self.cardioDataLoaded?()
        }
        //Read Symptoms data
        CardioManager.sharedManager.readSymptomsDataDone = {
            //self.reloadTable()
        }
    }
    
    func readAllCardioData(){
        CardioManager.sharedManager.resetCardioData()
        CardioManager.sharedManager.readConditionData{ (success, error) in
            self.cardioDataLoaded?(success,error)
        }
        CardioManager.sharedManager.readSymptomsData{ (success, error) in
            self.cardioDataLoaded?(success,error)
        }
        CardioManager.sharedManager.readBloodPressure { (success, error) in
            self.cardioDataLoaded?(success,error)
        }
        CardioManager.sharedManager.readIrregularHeartData{ (success, error) in
            self.cardioDataLoaded?(success,error)
        }
        
        CardioManager.sharedManager.readLabData{ (success, error) in
            self.cardioDataLoaded?(success,error)
        }
        
        CardioManager.sharedManager.readLabDataTemp{ (success, error) in
            self.cardioDataLoaded?(success,error)
        }
        //CardioManager.sharedManager.setDefaultValueCardioData()
    }
    
}







