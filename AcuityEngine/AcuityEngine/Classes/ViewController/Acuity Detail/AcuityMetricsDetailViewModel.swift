//
//  AcuityMetricsDetailViewModel.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 10/03/21.
//

import Foundation

class AcuityMetricsDetailViewModel: NSObject
{
    
    //MARK: Default system data...
    
    func getConditionData()->[ConditionsModel] {
        let arrConditions:[ConditionsModel] = []
        
      
        return arrConditions
    }
    
    func getLabData()->[LabModel] {
        let arrLabs:[LabModel] = []
        
        return arrLabs
    }
    
    func getSymptomsData()->[SymptomsModel] {
        /*switch MyWellScore.sharedManager.selectedSystem {
        case .Cardiovascular:
            do{
                return CardioManager.sharedManager.cardioData.cardioSymptoms.dictionaryRepresentation()
            }
        case .Respiratory:
            do{
                return RespiratoryManager.sharedManager.respiratoryData.respiratorySymptoms.dictionaryRepresentation()
            }
        case .Renal:
            do{
                return RenalManager.sharedManager.renalData.renalSymptoms.dictionaryRepresentation()
            }
        case .InfectiousDisease:
            do{
                return IDiseaseManager.sharedManager.iDiseaseData.iDiseaseSymptoms.dictionaryRepresentation()
            }
        case .Fluids:
            do{
                return FNEManager.sharedManager.fneData.fneSymptoms.dictionaryRepresentation()
            }
        case .Hematology:
            do{
                return HematoManager.sharedManager.hematoData.hematoSymptoms.dictionaryRepresentation()
            }
        case .Endocrine:
            do{
                return EndocrineManager.sharedManager.endocrineData.endocrineSymptoms.dictionaryRepresentation()
            }
        default:
            break
        }*/
        
        
        return []
    }
    
    func getVitals()->[VitalsModel] {
        /*switch MyWellScore.sharedManager.selectedSystem {
        case .Cardiovascular:
            do{
                return CardioManager.sharedManager.cardioData.cardioVital.dictionaryRepresentation()
            }
        case .Respiratory:
            do{
                return RespiratoryManager.sharedManager.respiratoryData.respiratoryVital.dictionaryRepresentation()
            }
        case .Renal:
            do{
                return RenalManager.sharedManager.renalData.renalVital.dictionaryRepresentation()
            }
        case .InfectiousDisease:
            do{
                return IDiseaseManager.sharedManager.iDiseaseData.iDiseaseVital.dictionaryRepresentation()
            }
        case .Fluids:
            do{
                return FNEManager.sharedManager.fneData.fneVital.dictionaryRepresentation()
            }
        case .Hematology:
            do{
                return HematoManager.sharedManager.hematoData.hematoVital.dictionaryRepresentation()
            }
        case .Endocrine:
            do{
                return EndocrineManager.sharedManager.endocrineData.endocrineVital.dictionaryRepresentation()
            }
        default:
            break
        }*/
        
        
        return []
    }
}
