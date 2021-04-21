//
//  IDiseaseCondition.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 05/02/21.
//

import UIKit

class IDiseaseCondition {
    /*
     UTI
     bronchitis/pneumonia
     cellulitis
     Covid
     Otitis
     Upper respiratory infection
     Gastroentritis
     diabetes
     */
    var UTIData:[IDiseaseConditionData]  = []
    var pneumoniaData:[IDiseaseConditionData]  = []
    var cellulitisData:[IDiseaseConditionData]  = []
    var covidData:[IDiseaseConditionData]  = []
    var otitisData:[IDiseaseConditionData]  = []
    var respiratoryInfectionData:[IDiseaseConditionData]  = []
    var gastroentritisData:[IDiseaseConditionData]  = []
    var diabetesData:[IDiseaseConditionData]  = []
    var arrayDayWiseScoreTotal:[Double] = []
    
   
    
    func getMaxConditionDataScore() -> Double {
        //UTIData
        let UTIData = IDiseaseConditionRelativeImportance.UTI.getConvertedValueFromPercentage()
        //pneumoniaData
        let pneumonia =  IDiseaseConditionRelativeImportance.bronchitisPneumonia.getConvertedValueFromPercentage()
        //cellulitis
        let cellulitis =  IDiseaseConditionRelativeImportance.cellulitis.getConvertedValueFromPercentage()
        //covid
        let covid =  IDiseaseConditionRelativeImportance.covid.getConvertedValueFromPercentage()
        //otitis
        let otitis =  IDiseaseConditionRelativeImportance.otitis.getConvertedValueFromPercentage()
        //respiratoryInfection
        let respiratoryInfection =  IDiseaseConditionRelativeImportance.respiratoryInfection.getConvertedValueFromPercentage()
        //gastroentritis
        let gastroentritis =  IDiseaseConditionRelativeImportance.gastroentritis.getConvertedValueFromPercentage()
        //diabetes
        let diabetes =  IDiseaseConditionRelativeImportance.diabetes.getConvertedValueFromPercentage()
        
        let totalConditionScore1 = UTIData + pneumonia
        let totalConditionScore2 =  cellulitis + covid + otitis
        let totalConditionScore3 =  respiratoryInfection + gastroentritis + diabetes
        return Double(totalConditionScore1  + totalConditionScore2 + totalConditionScore3);
    }
    
    func totalConditionScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        //print(totalAmount) // 4500.0
       
        arrayDayWiseScoreTotal = []
        var iDiseaseProblem:[Metrix] = []
        iDiseaseProblem.append(contentsOf: UTIData)
        iDiseaseProblem.append(contentsOf: pneumoniaData)
        iDiseaseProblem.append(contentsOf: cellulitisData)
        iDiseaseProblem.append(contentsOf: covidData)
        iDiseaseProblem.append(contentsOf: otitisData)
        iDiseaseProblem.append(contentsOf: respiratoryInfectionData)
        iDiseaseProblem.append(contentsOf: gastroentritisData)
        iDiseaseProblem.append(contentsOf: diabetesData)
        arrayDayWiseScoreTotal = daywiseFilterMetrixsData(days: days, array: iDiseaseProblem, metriXType: MetricsType.Conditions)
        iDiseaseProblem = []
        return arrayDayWiseScoreTotal
    }
    
    func dictionaryRepresentation()->[ConditionsModel]{
        
        let objModel = AcuityDetailConditionViewModel()
        return objModel.getConditionData()
        
    }
    
}
