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
    
    //MARK: - Internal Properties
 
    
    func fetchAndLoadCardioData(days: SegmentValueForGraph){
        
        var successValue:Bool = false
        var errorValue:HealthkitSetupError? = nil
        
        let dispatchGroup = DispatchGroup()
        
        //Reset All Data.....
        HKManagerReadVitals.sharedManager.resetData()
        
        dispatchGroup.enter()
        HKManagerReadVitals.sharedManager.readVitalsData(days: days) { (success, error) in
            //CardioManager.sharedManager.cardioData.totalScore()
            successValue = success
            errorValue = error
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        HKManagerReadSymptoms.sharedManager.readSymptomsData(days: days, completion: { (success, error) in
            successValue = success
            errorValue = error
            dispatchGroup.leave()
        })
        dispatchGroup.notify(queue: .main) {
            
            DispatchQueue.main.async {
                print("Complete all reading of data")
                print("Complete all reading of data", separator: "//////////", terminator: "////////")
               
                //let _ = CardioManager.sharedManager.cardioData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                self.cardioDataLoaded?(successValue,errorValue)
            }
        }
        
      
    }
    
}







