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
        let pneumonia =  IDiseaseConditionRelativeImportance.pneumonia.getConvertedValueFromPercentage()
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
        arrayDayWiseScoreTotal = getScoreForConditions(array: iDiseaseProblem, days: days)
        iDiseaseProblem = []
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[ConditionsModel]{
        
        var arrCondition:[ConditionsModel] = []
        //UTIData
        if UTIData.count > 0{
            let condition = UTIData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //pneumoniaData
        if pneumoniaData.count > 0{
            let condition = pneumoniaData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //cellulitisData
        if cellulitisData.count > 0{
            let condition = cellulitisData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //covidData
        if covidData.count > 0{
            let condition = covidData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //otitisData
        if otitisData.count > 0{
            let condition = otitisData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //respiratoryInfectionData
        if respiratoryInfectionData.count > 0{
            let condition = respiratoryInfectionData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //gastroentritisData
        if gastroentritisData.count > 0{
            let condition = gastroentritisData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //diabetesData
        if diabetesData.count > 0{
            let condition = diabetesData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        
        return arrCondition
        
    }
    
}
