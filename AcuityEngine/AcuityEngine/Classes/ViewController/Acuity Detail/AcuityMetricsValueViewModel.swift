//
//  AcuityMetricsValueViewModel.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 10/03/21.
//

import Foundation

class AcuityMetricsValueViewModel: NSObject
{
    
    //MARK: Default system data...
    
    func getConditionData(title:String)->[ConditionsModel] {
        let arrConditions:[ConditionsModel] = []
        
        /*let Condition1 =  ConditionsModel(title: title, value: .No)
         Condition1.startTime = Date().timeIntervalSince1970
         let Condition2 =  ConditionsModel(title: title, value: .Yes)
         Condition2.startTime = Date().timeIntervalSince1970 - 86400
         let Condition3 =  ConditionsModel(title: title, value: .No)
         Condition3.startTime = Date().timeIntervalSince1970 - 86400 * 3
         let Condition4 =  ConditionsModel(title: title, value: .No)
         Condition4.startTime = Date().timeIntervalSince1970 - 86400 * 4
         arrConditions = [Condition1,Condition2,Condition3,Condition4]*/
        
        return arrConditions
    }
    
    func getLabData(title:String)->[LabModel] {
        var arrLab:[LabModel] = []
        switch MyWellScore.sharedManager.selectedSystem {
        case .Cardiovascular:
            do{
                arrLab = CardioManager.sharedManager.cardioData.cardioLab.getArrayDataForLabs(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Respiratory:
            do{
                arrLab = RespiratoryManager.sharedManager.respiratoryData.respiratoryLab.getArrayDataForLabs(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Renal:
            do{
                arrLab = RenalManager.sharedManager.renalData.renalLab.getArrayDataForLabs(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .InfectiousDisease:
            do{
                arrLab = IDiseaseManager.sharedManager.iDiseaseData.iDiseaseLab.getArrayDataForLabs(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Fluids:
            do{
                arrLab = FNEManager.sharedManager.fneData.fneLab.getArrayDataForLabs(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Hematology:
            do{
                arrLab = HematoManager.sharedManager.hematoData.hematoLab.getArrayDataForLabs(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Endocrine:
            do{
                arrLab = EndocrineManager.sharedManager.endocrineData.endocrineLab.getArrayDataForLabs(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Gastrointestinal:
            do{
                arrLab = GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalLab.getArrayDataForLabs(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Genitourinary:
            do{
                arrLab = GenitourinaryManager.sharedManager.genitourinaryData.genitourinaryLab.getArrayDataForLabs(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Nuerological:
            do{
                arrLab = NeuroManager.sharedManager.neuroData.neuroLab.getArrayDataForLabs(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .SocialDeterminantsofHealth:
            do{
                arrLab = SDHManager.sharedManager.sdhData.sdhLab.getArrayDataForLabs(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Musculatory:
            do{
                arrLab = MuscManager.sharedManager.muscData.muscLab.getArrayDataForLabs(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Integumentary:
            do{
                arrLab = SkinManager.sharedManager.skinData.skinLab.getArrayDataForLabs(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Heent:
            do{
                arrLab = HeentManager.sharedManager.heentData.heentLab.getArrayDataForLabs(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        default:
        break
        }
        
        return arrLab
    }
    
    func getSymptomsData(title:String)->[SymptomsModel] {
        var arrSymptoms:[SymptomsModel] = []
        switch MyWellScore.sharedManager.selectedSystem {
        case .Cardiovascular:
            do{
                arrSymptoms = CardioManager.sharedManager.cardioData.cardioSymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Respiratory:
            do{
                arrSymptoms = RespiratoryManager.sharedManager.respiratoryData.respiratorySymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Renal:
            do{
                arrSymptoms = RenalManager.sharedManager.renalData.renalSymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .InfectiousDisease:
            do{
                arrSymptoms = IDiseaseManager.sharedManager.iDiseaseData.iDiseaseSymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Fluids:
            do{
                arrSymptoms = FNEManager.sharedManager.fneData.fneSymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Hematology:
            do{
                arrSymptoms = HematoManager.sharedManager.hematoData.hematoSymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Endocrine:
            do{
                arrSymptoms = EndocrineManager.sharedManager.endocrineData.endocrineSymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Gastrointestinal:
            do{
                arrSymptoms = GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalSymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Genitourinary:
            do{
                arrSymptoms = GenitourinaryManager.sharedManager.genitourinaryData.genitourinarySymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Nuerological:
            do{
                arrSymptoms = NeuroManager.sharedManager.neuroData.neuroSymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .SocialDeterminantsofHealth:
            do{
                arrSymptoms = SDHManager.sharedManager.sdhData.sdhSymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Musculatory:
            do{
                arrSymptoms = MuscManager.sharedManager.muscData.muscSymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Integumentary:
            do{
                arrSymptoms = SkinManager.sharedManager.skinData.skinSymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Heent:
            do{
                arrSymptoms = HeentManager.sharedManager.heentData.heentSymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        default:
        break
        }
        
        return arrSymptoms
    }
    
    func getVitals(title:String)->[VitalsModel] {
        var arrVitals:[VitalsModel] = []
        switch MyWellScore.sharedManager.selectedSystem {
        
        case .Cardiovascular:
            do{
                arrVitals = CardioManager.sharedManager.cardioData.cardioVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Respiratory:
            do{
                arrVitals = RespiratoryManager.sharedManager.respiratoryData.respiratoryVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Renal:
            do{
                arrVitals = RenalManager.sharedManager.renalData.renalVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .InfectiousDisease:
            do{
                arrVitals = IDiseaseManager.sharedManager.iDiseaseData.iDiseaseVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Fluids:
            do{
                arrVitals = FNEManager.sharedManager.fneData.fneVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Hematology:
            do{
                arrVitals = HematoManager.sharedManager.hematoData.hematoVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Endocrine:
            do{
                arrVitals = EndocrineManager.sharedManager.endocrineData.endocrineVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Gastrointestinal:
            do{
                arrVitals = GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Genitourinary:
            do{
                arrVitals = GenitourinaryManager.sharedManager.genitourinaryData.genitourinaryVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Nuerological:
            do{
                arrVitals = NeuroManager.sharedManager.neuroData.neuroVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .SocialDeterminantsofHealth:
            do{
                arrVitals = SDHManager.sharedManager.sdhData.sdhVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Musculatory:
            do{
                arrVitals = MuscManager.sharedManager.muscData.muscVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Integumentary:
            do{
                arrVitals = SkinManager.sharedManager.skinData.skinVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        case .Heent:
            do{
                arrVitals = HeentManager.sharedManager.heentData.heentVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
            }
        default:
        break
        }
        return arrVitals
    }
    
}

