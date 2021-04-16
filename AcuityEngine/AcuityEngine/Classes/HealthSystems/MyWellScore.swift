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
    
    
    //Load health data by value seelcted from Segment in Pullup segment control
    func loadHealthData(days:SegmentValueForGraph,completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void) {
        
        print("call loadHealthData")
        daysToCalculateSystemScore = days
        //set current date to Today's date to fetch all data from health kit
        todaysDate = Date()
        
        var successValue:Bool = false
        var errorValue:HealthkitSetupError? = nil
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        //Load all system data....
        viewModelCardio.fetchAndLoadCardioData(days: days)
        
        viewModelCardio.cardioDataLoaded = {(success,error) in
            successValue = success
            errorValue = error
            completion(successValue,errorValue)
        }
        
        dispatchGroup.leave()
        dispatchGroup.notify(queue: .main) {
            
            DispatchQueue.main.async {
                print("calculate my well score")
                
            }
        }
    }
    
    //MARK: My Well Score calculation
    func myWellScoreCalculation(){
        let totalWeightedSystemScore = getTotalWeightedSystemScore()
        let totalMaxScore = getTotalMaxScore()
        let abnormalFraction = totalWeightedSystemScore / totalMaxScore
        MyWellScore.sharedManager.myWellScore = abnormalFraction * 100
        print("<--------------------MyWellScore.sharedManager.myWellScore-------------------->",MyWellScore.sharedManager.myWellScore)
    }
    
    func getTotalMaxScore()->Double{
        let maxScoreCardioData = CardioManager.sharedManager.cardioData.maxScore
        let maxScoreRespiratoryData = RespiratoryManager.sharedManager.respiratoryData.maxScore
        let maxScoreRenalData = RenalManager.sharedManager.renalData.maxScore
        let totalMaxScore = maxScoreCardioData +  maxScoreRespiratoryData + maxScoreRenalData
        return totalMaxScore
    }
    
    func getTotalWeightedSystemScore()->Double{
        let cardioWeightedSystemScore = CardioManager.sharedManager.cardioData.cardioWeightedSystemScore
        let respiratoryWeightedSystemScore = RespiratoryManager.sharedManager.respiratoryData.respiratoryWeightedSystemScore
        let renalWeightedSystemScore = RenalManager.sharedManager.renalData.renalWeightedSystemScore
        let totalWeightedSystemScore = cardioWeightedSystemScore + respiratoryWeightedSystemScore + renalWeightedSystemScore
        return totalWeightedSystemScore
    }
}
