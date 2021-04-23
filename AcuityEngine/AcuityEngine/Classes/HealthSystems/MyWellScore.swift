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
    
    /*
     Load health data by value selected from Segment in Pullup segment control.
     Default is 3 months. It will fetch 3 months data from healthkit for Labs,Vital and Symptoms
     */
    
    func loadHealthData(days:SegmentValueForGraph,completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void) {
       
        //set current date to Today's date to fetch all data from health kit
        todaysDate = Date()
        
        var successValue:Bool = false
        var errorValue:HealthkitSetupError? = nil
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        //Load all system data....
        viewModelCardio.fetchAndLoadCardioData(days: days)
        
        //When data fetching is done it will refresh Wheel in MainViewController
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
        //Cardio
        let maxScoreCardioData = CardioManager.sharedManager.cardioData.maxScore
        //Respirator
        let maxScoreRespiratoryData = RespiratoryManager.sharedManager.respiratoryData.maxScore
        //Renal
        let maxScoreRenalData = RenalManager.sharedManager.renalData.maxScore
        //IDisease
        let maxScoreDiseaseData = IDiseaseManager.sharedManager.iDiseaseData.maxScore
        //fne
        let maxScoreFNEData = FNEManager.sharedManager.fneData.maxScore
        
        let totalMaxScore1 = maxScoreCardioData +  maxScoreRespiratoryData + maxScoreRenalData + maxScoreDiseaseData
        let totalMaxScore2 = maxScoreFNEData
        return totalMaxScore1 + totalMaxScore2
    }
    
    func getTotalWeightedSystemScore()->Double{
        //Cardio
        let cardioWeightedSystemScore = CardioManager.sharedManager.cardioData.cardioWeightedSystemScore
        //Respiratory
        let respiratoryWeightedSystemScore = RespiratoryManager.sharedManager.respiratoryData.respiratoryWeightedSystemScore
        //Renal
        let renalWeightedSystemScore = RenalManager.sharedManager.renalData.renalWeightedSystemScore
        //IDisease
        let iDiseaseWeightedSystemScore = IDiseaseManager.sharedManager.iDiseaseData.iDiseaseWeightedSystemScore
        //fne
        let fneWeightedSystemScore = FNEManager.sharedManager.fneData.fneWeightedSystemScore
        
        let totalWeightedSystemScore1 = cardioWeightedSystemScore + respiratoryWeightedSystemScore + renalWeightedSystemScore + iDiseaseWeightedSystemScore
        let totalWeightedSystemScore2 = fneWeightedSystemScore
        
        return totalWeightedSystemScore1 + totalWeightedSystemScore2
    }
}
