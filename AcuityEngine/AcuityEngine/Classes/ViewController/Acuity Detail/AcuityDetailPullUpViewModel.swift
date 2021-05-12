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
        acuityModel.id = systemData["id"] as? String
        acuityModel.name = SystemName(rawValue: systemData["name"] as! String )
        acuityModel.score = systemData["score"]  as? String ?? ""
        acuityModel.image = systemData["image"]  as? String ?? ""
        acuityModel.metricCardio = systemData["metricCardio"] as? [String:Any]
        return acuityModel
    }
    func getScoreAndArrayOfSystemScore()->(String,[Double],[String:Any]){
        
        var scoreText = String(format: "0.00")
        var arraySystemScore:[Double] = []
        var metricCardio:[String:Any] = [:]
        print("<--------------------showScoreAndChartData-------------------->")
        switch MyWellScore.sharedManager.selectedSystem {
        case .Cardiovascular:
            do{
                let systemScore = CardioManager.sharedManager.cardioData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = String(format: "%.2f", systemScore)
                metricCardio = CardioManager.sharedManager.cardioData.dictionaryRepresentation()
                arraySystemScore = CardioManager.sharedManager.cardioData.arrayDayWiseSystemScore
            }
        case .Respiratory:
            do{
                let systemScore = RespiratoryManager.sharedManager.respiratoryData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = String(format: "%.2f", systemScore)
                metricCardio = RespiratoryManager.sharedManager.respiratoryData.dictionaryRepresentation()
                arraySystemScore = RespiratoryManager.sharedManager.respiratoryData.arrayDayWiseSystemScore
            }
        case .Renal:
            do{
                let systemScore = RenalManager.sharedManager.renalData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = String(format: "%.2f", systemScore)
                metricCardio = RenalManager.sharedManager.renalData.dictionaryRepresentation()
                arraySystemScore = RenalManager.sharedManager.renalData.arrayDayWiseSystemScore
            }
        case .InfectiousDisease:
            do{
                let systemScore = IDiseaseManager.sharedManager.iDiseaseData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = String(format: "%.2f", systemScore)
                metricCardio = IDiseaseManager.sharedManager.iDiseaseData.dictionaryRepresentation()
                arraySystemScore = IDiseaseManager.sharedManager.iDiseaseData.arrayDayWiseSystemScore
            }
        case .Fluids:
            do{
                let systemScore = FNEManager.sharedManager.fneData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = String(format: "%.2f", systemScore)
                metricCardio = FNEManager.sharedManager.fneData.dictionaryRepresentation()
                arraySystemScore = FNEManager.sharedManager.fneData.arrayDayWiseSystemScore
            }
        case .Hematology:
            do{
                let systemScore = HematoManager.sharedManager.hematoData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = String(format: "%.2f", systemScore)
                metricCardio = HematoManager.sharedManager.hematoData.dictionaryRepresentation()
                arraySystemScore = HematoManager.sharedManager.hematoData.arrayDayWiseSystemScore
            }
        case .Endocrine:
            do{
                let systemScore = EndocrineManager.sharedManager.endocrineData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = String(format: "%.2f", systemScore)
                metricCardio = EndocrineManager.sharedManager.endocrineData.dictionaryRepresentation()
                arraySystemScore = EndocrineManager.sharedManager.endocrineData.arrayDayWiseSystemScore
            }
        case .Gastrointestinal:
            do{
                let systemScore = GastrointestinalManager.sharedManager.gastrointestinalData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = String(format: "%.2f", systemScore)
                metricCardio = GastrointestinalManager.sharedManager.gastrointestinalData.dictionaryRepresentation()
                arraySystemScore = GastrointestinalManager.sharedManager.gastrointestinalData.arrayDayWiseSystemScore
            }
        default:
            break
        }
        return (scoreText,arraySystemScore,metricCardio)
        
    }
    
}
