//
//  FNECondition.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 05/02/21.
//

import UIKit

class FNECondition {
    /*
     electrolyte disorders
     underweight/malnutrition
     Overweight/Obesity
     kidney diease
     Bronchitis/pneumonia
     Gastroentritis
     diabetes
     */
    var electrolyteDisordersData:[FNEConditionData]  = []
    var underweightOrMalnutritionData:[FNEConditionData]  = []
    var overweightOrObesityData:[FNEConditionData]  = []
    var kidneyDieaseData:[FNEConditionData]  = []
    var pneumoniaData:[FNEConditionData]  = []
    var gastroentritisData:[FNEConditionData]  = []
    var diabetesData:[FNEConditionData]  = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    
    func getMaxConditionDataScore() -> Double {
        //electrolyteDisordersData
        let electrolyteDisordersData = FNEConditionRelativeImportance.electrolyteDisorders.getConvertedValueFromPercentage()
        //underweightOrMalnutrition
        let underweightOrMalnutrition =  FNEConditionRelativeImportance.underweightOrMalnutrition.getConvertedValueFromPercentage()
        //overweightOrObesity
        let overweightOrObesity =  FNEConditionRelativeImportance.overweightOrObesity.getConvertedValueFromPercentage()
        //kidneyDiease
        let kidneyDiease =  FNEConditionRelativeImportance.kidneyDiease.getConvertedValueFromPercentage()
        //pneumonia
        let pneumonia =  FNEConditionRelativeImportance.pneumonia.getConvertedValueFromPercentage()
        //gastroentritis
        let gastroentritis =  FNEConditionRelativeImportance.gastroentritis.getConvertedValueFromPercentage()
        //diabetes
        let diabetes =  FNEConditionRelativeImportance.diabetes.getConvertedValueFromPercentage()
        
        let totalConditionScore1 = electrolyteDisordersData + underweightOrMalnutrition
        let totalConditionScore2 =  overweightOrObesity + kidneyDiease + pneumonia
        let totalConditionScore3 =   gastroentritis + diabetes
        return Double(totalConditionScore1  + totalConditionScore2 + totalConditionScore3);
    }
    
    func totalConditionScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        //print(totalAmount) // 4500.0
        
        arrayDayWiseScoreTotal = []
        var fneProblem:[Metrix] = []
        fneProblem.append(contentsOf: electrolyteDisordersData)
        fneProblem.append(contentsOf: underweightOrMalnutritionData)
        fneProblem.append(contentsOf: overweightOrObesityData)
        fneProblem.append(contentsOf: kidneyDieaseData)
        fneProblem.append(contentsOf: pneumoniaData)
        fneProblem.append(contentsOf: gastroentritisData)
        fneProblem.append(contentsOf: diabetesData)
        arrayDayWiseScoreTotal = getScoreForConditions(array: fneProblem, days: days)
        fneProblem = []
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[ConditionsModel]{
        
        var arrCondition:[ConditionsModel] = []
        //electrolyteDisordersData
        if electrolyteDisordersData.count > 0{
            let condition = electrolyteDisordersData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //underweightOrMalnutritionData
        if underweightOrMalnutritionData.count > 0{
            let condition = underweightOrMalnutritionData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //overweightOrObesityData
        if overweightOrObesityData.count > 0{
            let condition = overweightOrObesityData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //kidneyDieaseData
        if kidneyDieaseData.count > 0{
            let condition = kidneyDieaseData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //pneumoniaData
        if pneumoniaData.count > 0{
            let condition = pneumoniaData[0]
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
