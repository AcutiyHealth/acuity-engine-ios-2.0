//
//  File.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 27/04/21.
//

import Foundation

class AcuityDetailPullUpViewModel: NSObject
{
    func setNoDataInfoIfRecordsNotExists(tblView:UITableView)
    {
        let noDataLabel : UILabel = UILabel()
        noDataLabel.frame = CGRect(x: 0, y: 0 , width: (tblView.bounds.width), height: (tblView.bounds.height))
        noDataLabel.text = "No Records Found"
        noDataLabel.font = UIFont.systemFont(ofSize: 12)
        noDataLabel.textColor = UIColor.white
        noDataLabel.textAlignment = .center
        tblView.backgroundView = noDataLabel
        
    }
    func setBackGroundColorFor(viewSymptom:UIView,viewCondition:UIView,viewVital:UIView,viewLab:UIView){
        self.setBackgroundColorForMetricsView(view: viewCondition)
        self.setBackgroundColorForMetricsView(view: viewVital)
        self.setBackgroundColorForMetricsView(view: viewSymptom)
        self.setBackgroundColorForMetricsView(view: viewLab)
    }
    
    //MARK: Set background view of Conditions,lab,symptoms and vital
    func setBackgroundColorForMetricsView(view:UIView){
        view.layer.cornerRadius = 5;
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
    }
    //MARK: Make view of Conditions,lab,symptoms and vital selected
    func setBackgroundColorWhenViewSelcted(view:UIView){
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1;
    }
    
    //MARK: Make view of Conditions,lab,symptoms and vital unselected
    func setBackgroundColorWhenViewUnSelcted(viewSymptom:UIView,viewCondition:UIView,viewVital:UIView,viewLab:UIView){
        viewLab.layer.borderWidth = 0;
        viewVital.layer.borderWidth = 0;
        viewSymptom.layer.borderWidth = 0;
        viewCondition.layer.borderWidth = 0;
    }
    
    func prepareArrayFromAcuityModel(systemMetricsData:[String:Any]?)->([ConditionsModel],[SymptomsModel],[VitalsModel],[LabModel]){
        //generate array of conditions,lab,vital,symptoms
        var arrConditions:[ConditionsModel] = []
        var arrSymptoms:[SymptomsModel] = []
        var arrLabs:[LabModel] = []
        var arrVitals:[VitalsModel] = []
        guard let arrCondition = systemMetricsData?[MetricsType.Conditions.rawValue] as? [ConditionsModel] else {
            return (arrConditions,arrSymptoms,arrVitals,arrLabs)
        }
        guard let arrSymptom = systemMetricsData?[MetricsType.Sympotms.rawValue] as? [SymptomsModel] else {
            return (arrConditions,arrSymptoms,arrVitals,arrLabs)
        }
        guard let arrLab = systemMetricsData?[MetricsType.LabData.rawValue] as? [LabModel] else {
            return (arrConditions,arrSymptoms,arrVitals,arrLabs)
        }
        guard let arrVital = systemMetricsData?[MetricsType.Vitals.rawValue] as? [VitalsModel] else {
            return (arrConditions,arrSymptoms,arrVitals,arrLabs)
        }
        arrConditions = arrCondition
        arrSymptoms = arrSymptom
        arrLabs = arrLab
        arrVitals = arrVital
        
        //Sorting of array...
        arrConditions.sort {
            $0.title ?? "" < $1.title ?? ""
        }
        arrVitals.sort {
            $0.title ?? "" < $1.title ?? ""
        }
        arrSymptoms.sort {
            $0.title ?? "" < $1.title ?? ""
        }
        arrLabs.sort {
            $0.title ?? "" < $1.title ?? ""
        }
        return (arrConditions,arrSymptoms,arrVitals,arrLabs)
    }
    func setUpSegmentControl(segmentControl:UISegmentedControl){
        segmentControl.setTitle(SegmentValueForGraph.SevenDays.rawValue, forSegmentAt: 0)
        segmentControl.setTitle(SegmentValueForGraph.ThirtyDays.rawValue, forSegmentAt: 1)
        segmentControl.setTitle(SegmentValueForGraph.ThreeMonths.rawValue, forSegmentAt: 2)
        segmentControl.defaultConfiguration(font: Fonts.kAcuityDetailSegmentFont, color: UIColor.white)
        segmentControl.selectedConfiguration(font: Fonts.kAcuityDetailSegmentFont, color: UIColor.black)
        segmentControl.selectedSegmentIndex = 0
        //self.segmentClicked(segmentControl)
    }
    
    func prepareAcuityModelFromSystemData(systemData:[String:Any])->AcuityDisplayModel{
        let acuityModel = AcuityDisplayModel()
        acuityModel.id = systemData[Keys.kAcuityId] as? String
        acuityModel.name = SystemName(rawValue: systemData[Keys.kSystemName] as! String )
        acuityModel.score = systemData[Keys.kScore]  as? String ?? ""
        acuityModel.image = systemData[Keys.kImage]  as? String ?? ""
        acuityModel.metricDictionary = systemData[Keys.kMetricDictionary] as? [String:Any]
        acuityModel.myWellScoreDataDictionary = systemData[Keys.kMyWellScoreDataDictionary] as? [[String:Double]]
        return acuityModel
    }
    func getScoreAndArrayOfSystemScore()->(String,[Double],[String:Any]){
        /*
         From this method, score for each system will be calculated for 7 days, 1 month and 3 months based upon selected segment.
         */
        var scoreText = String(format: "0.00")
        var arraySystemScore:[Double] = []
        var metricDictionary:[String:Any] = [:]
        print("<--------------------showScoreAndChartData-------------------->")
        switch MyWellScore.sharedManager.selectedSystem {
        case .Cardiovascular:
            do{
                let systemScore = CardioManager.sharedManager.cardioData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                //scoreText = String(format: "%.2f", systemScore)
                metricDictionary = CardioManager.sharedManager.cardioData.dictionaryRepresentation()
                arraySystemScore = CardioManager.sharedManager.cardioData.arrayDayWiseSystemScore
            }
        case .Respiratory:
            do{
                let systemScore = RespiratoryManager.sharedManager.respiratoryData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = RespiratoryManager.sharedManager.respiratoryData.dictionaryRepresentation()
                arraySystemScore = RespiratoryManager.sharedManager.respiratoryData.arrayDayWiseSystemScore
            }
        case .Renal:
            do{
                let systemScore = RenalManager.sharedManager.renalData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = RenalManager.sharedManager.renalData.dictionaryRepresentation()
                arraySystemScore = RenalManager.sharedManager.renalData.arrayDayWiseSystemScore
            }
        case .InfectiousDisease:
            do{
                let systemScore = IDiseaseManager.sharedManager.iDiseaseData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = IDiseaseManager.sharedManager.iDiseaseData.dictionaryRepresentation()
                arraySystemScore = IDiseaseManager.sharedManager.iDiseaseData.arrayDayWiseSystemScore
            }
        case .Fluids:
            do{
                let systemScore = FNEManager.sharedManager.fneData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = FNEManager.sharedManager.fneData.dictionaryRepresentation()
                arraySystemScore = FNEManager.sharedManager.fneData.arrayDayWiseSystemScore
            }
        case .Hematology:
            do{
                let systemScore = HematoManager.sharedManager.hematoData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = HematoManager.sharedManager.hematoData.dictionaryRepresentation()
                arraySystemScore = HematoManager.sharedManager.hematoData.arrayDayWiseSystemScore
            }
        case .Endocrine:
            do{
                let systemScore = EndocrineManager.sharedManager.endocrineData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = EndocrineManager.sharedManager.endocrineData.dictionaryRepresentation()
                arraySystemScore = EndocrineManager.sharedManager.endocrineData.arrayDayWiseSystemScore
            }
        case .Gastrointestinal:
            do{
                let systemScore = GastrointestinalManager.sharedManager.gastrointestinalData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = GastrointestinalManager.sharedManager.gastrointestinalData.dictionaryRepresentation()
                arraySystemScore = GastrointestinalManager.sharedManager.gastrointestinalData.arrayDayWiseSystemScore
            }
        case .Genitourinary:
            do{
                let systemScore = GenitourinaryManager.sharedManager.genitourinaryData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = GenitourinaryManager.sharedManager.genitourinaryData.dictionaryRepresentation()
                arraySystemScore = GenitourinaryManager.sharedManager.genitourinaryData.arrayDayWiseSystemScore
            }
        case .Nuerological:
            do{
                let systemScore = NeuroManager.sharedManager.neuroData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = NeuroManager.sharedManager.neuroData.dictionaryRepresentation()
                arraySystemScore = NeuroManager.sharedManager.neuroData.arrayDayWiseSystemScore
            }
        case .SocialDeterminantsofHealth:
            do{
                let systemScore = SDHManager.sharedManager.sdhData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = SDHManager.sharedManager.sdhData.dictionaryRepresentation()
                arraySystemScore = SDHManager.sharedManager.sdhData.arrayDayWiseSystemScore
            }
        case .Musculatory:
            do{
                let systemScore = MuscManager.sharedManager.muscData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = MuscManager.sharedManager.muscData.dictionaryRepresentation()
                arraySystemScore = MuscManager.sharedManager.muscData.arrayDayWiseSystemScore
            }
        case .Integumentary:
            do{
                let systemScore = SkinManager.sharedManager.skinData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = SkinManager.sharedManager.skinData.dictionaryRepresentation()
                arraySystemScore = SkinManager.sharedManager.skinData.arrayDayWiseSystemScore
            }
        case .Heent:
            do{
                let systemScore = HeentManager.sharedManager.heentData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = HeentManager.sharedManager.heentData.dictionaryRepresentation()
                arraySystemScore = HeentManager.sharedManager.heentData.arrayDayWiseSystemScore
            }
            
        default:
            break
        }
        
        return (scoreText,arraySystemScore,metricDictionary)
        
    }
    func getScoreAndArrayOfSystemScoreForMyWellScore()->(String,[String],[[String:Any]]){
        /*
         From this method, score for each system will be calculated for 7 days, 1 month and 3 months based upon selected segment.
         */
        var scoreText = String(format: "0.00")
        var arraySystemScore:[String] = []
        var metricDictionary:[[String:Any]] = [[:]]
        
        let systemScore = MyWellScore.sharedManager.myWellScore
        scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
        //scoreText = String(format: "%.2f", systemScore)
        metricDictionary = MyWellScore.sharedManager.dictionaryOfSystemScore
        for dict in metricDictionary{
            if let score = dict[Keys.kScore]{
                arraySystemScore.append(score as? String ?? "")
            }
        }
        
        return (scoreText,arraySystemScore,metricDictionary)
    }
    
}
