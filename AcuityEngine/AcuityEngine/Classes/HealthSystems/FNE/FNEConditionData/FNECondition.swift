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
        var iDiseaseProblem:[Metrix] = []
        iDiseaseProblem.append(contentsOf: electrolyteDisordersData)
        iDiseaseProblem.append(contentsOf: pneumoniaData)
        iDiseaseProblem.append(contentsOf: underweightOrMalnutritionData)
        iDiseaseProblem.append(contentsOf: overweightOrObesityData)
        iDiseaseProblem.append(contentsOf: kidneyDieaseData)
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
