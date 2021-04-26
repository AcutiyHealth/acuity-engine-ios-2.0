//
//  AcuityDetailValueViewModel.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 10/03/21.
//

import Foundation

class AcuityDetailValueViewModel: NSObject
{
    
    //MARK: Default system data...
    
    func getConditionData(title:String)->[ConditionsModel] {
        var arrConditions:[ConditionsModel] = []
        
        let Condition1 =  ConditionsModel(title: title, value: .No)
        Condition1.startTime = Date().timeIntervalSince1970
        let Condition2 =  ConditionsModel(title: title, value: .Yes)
        Condition2.startTime = Date().timeIntervalSince1970 - 86400
        let Condition3 =  ConditionsModel(title: title, value: .No)
        Condition3.startTime = Date().timeIntervalSince1970 - 86400 * 3
        let Condition4 =  ConditionsModel(title: title, value: .No)
        Condition4.startTime = Date().timeIntervalSince1970 - 86400 * 4
        arrConditions = [Condition1,Condition2,Condition3,Condition4]
        return arrConditions
    }
    
    func getLabData(title:String)->[LabModel] {
        var arrLabs:[LabModel] = []
        
        let lab1 =  LabModel(title: title, value: "3.3")
        lab1.startTime = Date().timeIntervalSince1970
        lab1.color = ChartColor.REDCOLOR
        let lab2 =  LabModel(title: title, value: "2")
        lab2.startTime = Date().timeIntervalSince1970 - 86400
        lab2.color = ChartColor.GREENCOLOR
        let lab3 =  LabModel(title: title, value: "97%")
        lab3.startTime = Date().timeIntervalSince1970 - 86400 * 2
        lab3.color = ChartColor.GREENCOLOR
        let lab4 =  LabModel(title: title, value: "0")
        lab4.startTime = Date().timeIntervalSince1970 - 86400 * 3
        lab4.color = ChartColor.GREENCOLOR
        let lab5 =  LabModel(title: title, value: "0.03")
        lab5.startTime = Date().timeIntervalSince1970 - 86400 * 4
        lab5.color = ChartColor.GREENCOLOR
        let lab6 =  LabModel(title: title, value: "17.6")
        lab6.startTime = Date().timeIntervalSince1970 - 86400 * 5
        lab6.color = ChartColor.REDCOLOR
        arrLabs = [lab1,lab2,lab3,lab4,lab5,lab6]
        
        return arrLabs
    }
    
    func getSymptomsData(title:String)->[SymptomsModel] {
        var arrSymptoms:[SymptomsModel] = []
        
        //Cardiovascular
        if MyWellScore.sharedManager.selectedSystem == SystemName.Cardiovascular{
            arrSymptoms = CardioManager.sharedManager.cardioData.cardioSymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
        }
        //Respiratory
        else if MyWellScore.sharedManager.selectedSystem == SystemName.Respiratory{
            arrSymptoms = RespiratoryManager.sharedManager.respiratoryData.respiratorySymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
        }
        //Renal
        else if MyWellScore.sharedManager.selectedSystem == SystemName.Renal{
            arrSymptoms = RenalManager.sharedManager.renalData.renalSymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
        }
        //InfectiousDisease
        else if MyWellScore.sharedManager.selectedSystem == SystemName.InfectiousDisease{
            arrSymptoms = IDiseaseManager.sharedManager.iDiseaseData.iDiseaseSymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
        }
        //FNE
        else if MyWellScore.sharedManager.selectedSystem == SystemName.Fluids{
            arrSymptoms = FNEManager.sharedManager.fneData.fneSymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
        }
        //Haematology
        else if MyWellScore.sharedManager.selectedSystem == SystemName.Haematology{
            arrSymptoms = HematoManager.sharedManager.hematoData.hematoSymptoms.getArrayDataForSymptoms(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
        }
        return arrSymptoms
    }
    
    func getVitals(title:String)->[VitalsModel] {
        var arrVitals:[VitalsModel] = []
        //Cardiovascular
        if MyWellScore.sharedManager.selectedSystem == SystemName.Cardiovascular{
            arrVitals = CardioManager.sharedManager.cardioData.cardioVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
        }
        //Respiratory
        else if MyWellScore.sharedManager.selectedSystem == SystemName.Respiratory{
            arrVitals = RespiratoryManager.sharedManager.respiratoryData.respiratoryVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
        }
        //Renal
        else if MyWellScore.sharedManager.selectedSystem == SystemName.Renal{
            arrVitals = RenalManager.sharedManager.renalData.renalVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
        }
        //InfectiousDisease
        else if MyWellScore.sharedManager.selectedSystem == SystemName.InfectiousDisease{
            arrVitals = IDiseaseManager.sharedManager.iDiseaseData.iDiseaseVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
        }
        //Fluids
        else if MyWellScore.sharedManager.selectedSystem == SystemName.Fluids{
            arrVitals = FNEManager.sharedManager.fneData.fneVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
        }
        //Haematology
        else if MyWellScore.sharedManager.selectedSystem == SystemName.Haematology{
            return HematoManager.sharedManager.hematoData.hematoVital.getArrayDataForVitals(days:MyWellScore.sharedManager.daysToCalculateSystemScore, title: title)
        }
        return arrVitals
    }
}

