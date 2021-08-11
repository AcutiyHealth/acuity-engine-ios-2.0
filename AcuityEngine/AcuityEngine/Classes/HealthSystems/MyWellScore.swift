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
    var dictionaryOfSystemScore:[[String:Any]] = []
    //ViewModel Cardio
    private let viewModelCardio = CardioViewModel()
    
    
    /*
     Load health data by value selected from Segment in Pullup segment control.
     Default is 3 months. It will fetch 3 months data from healthkit for Labs,Vital and Symptoms
     */
    
    func loadHealthData(days:SegmentValueForGraph,completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void) {
        //Note: days is unused parameter
        
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
        //Hemato
        let maxScoreHematoData = HematoManager.sharedManager.hematoData.maxScore
        //Endocrine
        let maxScoreEndocrineData = EndocrineManager.sharedManager.endocrineData.maxScore
        //Gastrointestinal
        let maxScoreGastrointestinalData = GastrointestinalManager.sharedManager.gastrointestinalData.maxScore
        //Genitourinary
        let maxScoreGenitourinaryData = GenitourinaryManager.sharedManager.genitourinaryData.maxScore
        //Neuro
        let maxScoreNeuroData = NeuroManager.sharedManager.neuroData.maxScore
        //SDH
        let maxScoreSDHData = SDHManager.sharedManager.sdhData.maxScore
        //Musc
        let maxScoreMuscData = MuscManager.sharedManager.muscData.maxScore
        //Skin
        let maxScoreSkinData = SkinManager.sharedManager.skinData.maxScore
        //Heent
        let maxScoreHeentData = HeentManager.sharedManager.heentData.maxScore
        
        let totalMaxScore1 = maxScoreCardioData +  maxScoreRespiratoryData + maxScoreRenalData + maxScoreDiseaseData
        let totalMaxScore2 = maxScoreFNEData + maxScoreHematoData + maxScoreEndocrineData
        let totalMaxScore3 = maxScoreGastrointestinalData + maxScoreGenitourinaryData + maxScoreNeuroData
        let totalMaxScore4 = maxScoreSDHData + maxScoreMuscData + maxScoreSkinData + maxScoreHeentData
        return totalMaxScore1 + totalMaxScore2 + totalMaxScore3 + totalMaxScore4
    }
    
    func getTotalWeightedSystemScore()->Double{
        
        //Remove All Data From dictionaryOfSystemScore.
        dictionaryOfSystemScore = []
        /*
         My Well score calculate for Today/One day. So, when we get WeightedSystemScore, it has get method and in it calculate scroe for One Day.
         */
        //Cardio
       
        let cardioWeightedSystemScore = CardioManager.sharedManager.cardioData.cardioWeightedSystemScore
        let cardioSystemScore = CardioManager.sharedManager.cardioData.cardioSystemScore
        prepareDictionaryForSystemScore(systemName: SystemName.Cardiovascular, score: cardioSystemScore)
        
        //Respiratory
        let respiratoryWeightedSystemScore = RespiratoryManager.sharedManager.respiratoryData.respiratoryWeightedSystemScore
        let respiratorySystemScore = RespiratoryManager.sharedManager.respiratoryData.respiratorySystemScore
        prepareDictionaryForSystemScore(systemName: SystemName.Respiratory, score: respiratorySystemScore)
        
        //Renal
        let renalWeightedSystemScore = RenalManager.sharedManager.renalData.renalWeightedSystemScore
        let renalSystemScore = RenalManager.sharedManager.renalData.renalSystemScore
        prepareDictionaryForSystemScore(systemName: SystemName.Renal, score: renalSystemScore)
        
        //IDisease
        let iDiseaseWeightedSystemScore = IDiseaseManager.sharedManager.iDiseaseData.iDiseaseWeightedSystemScore
        let iDiseaseSystemScore = IDiseaseManager.sharedManager.iDiseaseData.iDiseaseSystemScore
        prepareDictionaryForSystemScore(systemName: SystemName.InfectiousDisease, score: iDiseaseSystemScore)
        
        //fne
        let fneWeightedSystemScore = FNEManager.sharedManager.fneData.fneWeightedSystemScore
        let fneSystemScore = FNEManager.sharedManager.fneData.fneSystemScore
        prepareDictionaryForSystemScore(systemName: SystemName.Fluids, score: fneSystemScore)
        
        //Hemato
        let hematoWeightedSystemScore = HematoManager.sharedManager.hematoData.hematoWeightedSystemScore
        let hematoSystemScore = HematoManager.sharedManager.hematoData.hematoSystemScore
        prepareDictionaryForSystemScore(systemName: SystemName.Hematology, score: hematoSystemScore)
        
        //Endocrine
        let endocrineWeightedSystemScore = EndocrineManager.sharedManager.endocrineData.endocrineWeightedSystemScore
        let endocrineSystemScore = EndocrineManager.sharedManager.endocrineData.endocrineSystemScore
        prepareDictionaryForSystemScore(systemName: SystemName.Endocrine, score: endocrineSystemScore)
        
        //Gastrointestinal
        let gastrointestinalWeightedSystemScore = GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalWeightedSystemScore
        let gastrointestinalSystemScore = GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalSystemScore
        prepareDictionaryForSystemScore(systemName: SystemName.Gastrointestinal, score: gastrointestinalSystemScore)
        
        //Genitourinary
        let genitourinaryWeightedSystemScore = GenitourinaryManager.sharedManager.genitourinaryData.genitourinaryWeightedSystemScore
        let genitourinarySystemScore = GenitourinaryManager.sharedManager.genitourinaryData.genitourinarySystemScore
        prepareDictionaryForSystemScore(systemName: SystemName.Genitourinary, score: genitourinarySystemScore)
        
        //Neuro
        let neuroWeightedSystemScore = NeuroManager.sharedManager.neuroData.neuroWeightedSystemScore
        let neuroSystemScore = NeuroManager.sharedManager.neuroData.neuroSystemScore
        prepareDictionaryForSystemScore(systemName: SystemName.Nuerological, score: neuroSystemScore)
        
        //SDH
        let sdhWeightedSystemScore = SDHManager.sharedManager.sdhData.sdhWeightedSystemScore
        let sdhSystemScore = SDHManager.sharedManager.sdhData.sdhSystemScore
        prepareDictionaryForSystemScore(systemName: SystemName.SocialDeterminantsofHealth, score: sdhSystemScore)
        
        //Musc
        let muscWeightedSystemScore = MuscManager.sharedManager.muscData.muscWeightedSystemScore
        let muscSystemScore = MuscManager.sharedManager.muscData.muscSystemScore
        prepareDictionaryForSystemScore(systemName: SystemName.Musculatory, score: muscSystemScore)
        
        //Skin
        let skinWeightedSystemScore = SkinManager.sharedManager.skinData.skinWeightedSystemScore
        let skinSystemScore = SkinManager.sharedManager.skinData.skinSystemScore
        prepareDictionaryForSystemScore(systemName: SystemName.Integumentary, score: skinSystemScore)
        
        //heent
        let heentWeightedSystemScore = HeentManager.sharedManager.heentData.heentWeightedSystemScore
        let heentSystemScore = HeentManager.sharedManager.heentData.heentSystemScore
        prepareDictionaryForSystemScore(systemName: SystemName.Heent, score: heentSystemScore)
     
        let totalWeightedSystemScore1 = cardioWeightedSystemScore + respiratoryWeightedSystemScore + renalWeightedSystemScore + iDiseaseWeightedSystemScore
        let totalWeightedSystemScore2 = fneWeightedSystemScore + hematoWeightedSystemScore + endocrineWeightedSystemScore
        let totalWeightedSystemScore3 = gastrointestinalWeightedSystemScore + genitourinaryWeightedSystemScore + neuroWeightedSystemScore
        let totalWeightedSystemScore4 = sdhWeightedSystemScore + muscWeightedSystemScore + skinWeightedSystemScore + heentWeightedSystemScore
        
        return totalWeightedSystemScore1 + totalWeightedSystemScore2 + totalWeightedSystemScore3 + totalWeightedSystemScore4
    }
    
    func prepareDictionaryForSystemScore(systemName:SystemName,score:Double){
        
        let dictCardio = [Keys.kSystemName:systemName.rawValue,Keys.kScore:score] as [String : Any];
        dictionaryOfSystemScore.append(dictCardio)
    }
}
