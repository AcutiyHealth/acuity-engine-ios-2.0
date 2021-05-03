//
//  CardioViewModel.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation

protocol CardioViewModelProtocol {
    var cardioDataLoaded: ((Bool, HealthkitSetupError?) -> Void)? { get set }
    func fetchAndLoadCardioData(days: SegmentValueForGraph)
}

class CardioViewModel: CardioViewModelProtocol {
    var cardioDataLoaded: ((Bool, HealthkitSetupError?) -> Void)?
    
    
    //MARK: - Fetch health data for Vital,Symptoms,Lab and Problem.
    
    func fetchAndLoadCardioData(days: SegmentValueForGraph){
        
        var successValue:Bool = false
        var errorValue:HealthkitSetupError? = nil
        
        let dispatchGroup = DispatchGroup()
        
        //Reset All Data.....
        HKManagerReadVitals.sharedManager.resetData()
        
        //Put in dispatch group and when it's done it will call completion handler
        //It will read all symptoms,vital and lab data. After that, it will create object for particular system and store it in array for that system.
        
        //Read Conditio data......
        dispatchGroup.enter()
        HKManagerReadConditions.sharedManager.readConditionsDataFromDatabase{ (success, error) in
            successValue = success
            //errorValue = error
            dispatchGroup.leave()
        }
       
        //Read vital data......
        dispatchGroup.enter()
        HKManagerReadVitals.sharedManager.readVitalsData(days: days) { (success, error) in
            //CardioManager.sharedManager.cardioData.totalScore()
            successValue = success
            errorValue = error
            dispatchGroup.leave()
        }
        
        //Read Symptoms data......
        dispatchGroup.enter()
        HKManagerReadSymptoms.sharedManager.readSymptomsData(days: days, completion: { (success, error) in
            successValue = success
            errorValue = error
            dispatchGroup.leave()
        })
        
        //Read Lab data......
        dispatchGroup.enter()
        HKManagerReadLab.sharedManager.readLabDataTemp { (success, error) in
            successValue = success
            errorValue = error
            dispatchGroup.leave()
        }
        //When all leave from dispatch group it will notify and  call completion handler...
        dispatchGroup.notify(queue: .main) {
            
            DispatchQueue.main.async {
                print("Complete all reading of data")
                print("Complete all reading of data", separator: "//////////", terminator: "////////")
                self.cardioDataLoaded?(successValue,errorValue)
            }
        }
        
        
    }
    
}







