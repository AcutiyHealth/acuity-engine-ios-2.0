//
//  MyWellScore.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 24/02/21.
//

import Foundation

class MyWellScore: NSObject {
    
    
    static let sharedManager = MyWellScore()
    
    var todaysDate:Date = Date()
    var myWellScore:Double = 77
    var daysToCalculateSystemScore = SegmentValueForGraph.SevenDays
    var selectedSystem = SystemName.Cardiovascular
    
    //ViewModel Cardio
    private let viewModelCardio = CardioViewModel()
    //ViewModel Respiratory
    private let viewModelRespiratory = RespiratoryViewModel()
    
    func loadHealthData(days:SegmentValueForGraph,completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void) {
        
        print("call loadHealthData")
        daysToCalculateSystemScore = days
        //set current date to Today's date to fetch all data from health kit
        todaysDate = Date()
        
        var successValue:Bool = false
        var errorValue:HealthkitSetupError? = nil
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        //Load cardio data....
        viewModelCardio.fetchAndLoadCardioData(days: days)
        
        viewModelCardio.cardioDataLoaded = {(success,error) in
            successValue = success
            errorValue = error
            //Temporary code..remove it once all calculation done...
            self.temporaryWellScoreCalculation()
            completion(successValue,errorValue)
        }
        
        dispatchGroup.leave()
        dispatchGroup.notify(queue: .main) {
            
            DispatchQueue.main.async {
                print("calculate my well score")
                
            }
        }
    }
    
    //MARK: Temporary Code
    func temporaryWellScoreCalculation(){
        MyWellScore.sharedManager.myWellScore = CardioManager.sharedManager.cardioData.cardioWeightedSystemScore
        
    }
}
