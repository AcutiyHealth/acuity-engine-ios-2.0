//
//  SkinCondition.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class SkinCondition {
    /*
     Rash/Acne
     Psoriasis/Eczema
     Cellulitis
     diabetes
     */
    
    var rashOrAcneData:[SkinConditionData]  = []
    var psoriasisEczemaData:[SkinConditionData]  = []
    var cellulitisData:[SkinConditionData]  = []
    var diabetesData:[SkinConditionData]  = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    
    func getMaxConditionDataScore() -> Double {
        //rashOrAcne
        let rashOrAcne = SkinConditionRelativeImportance.rashOrAcne.getConvertedValueFromPercentage()
        //psoriasisEczema
        let psoriasisEczema =  SkinConditionRelativeImportance.psoriasisEczema.getConvertedValueFromPercentage()
        //cellulitis
        let cellulitis =  SkinConditionRelativeImportance.cellulitis.getConvertedValueFromPercentage()
        //diabetes
        let diabetes =  SkinConditionRelativeImportance.diabetes.getConvertedValueFromPercentage()
        
        let totalConditionScore1 = rashOrAcne + psoriasisEczema + cellulitis + diabetes
        
        return Double(totalConditionScore1);
    }
    
    func totalConditionScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        arrayDayWiseScoreTotal = []
        var SkinProblem:[Metrix] = []
        SkinProblem.append(contentsOf: rashOrAcneData)
        SkinProblem.append(contentsOf: psoriasisEczemaData)
        SkinProblem.append(contentsOf: cellulitisData)
        SkinProblem.append(contentsOf: diabetesData)
        
        arrayDayWiseScoreTotal = getScoreForConditions(array: SkinProblem, days: days)
        
        SkinProblem = []
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[ConditionsModel]{
        
        var arrCondition:[ConditionsModel] = []
        //rashOrAcneData
        if rashOrAcneData.count > 0{
            let condition = rashOrAcneData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //psoriasisEczemaData
        if psoriasisEczemaData.count > 0{
            let condition = psoriasisEczemaData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //cellulitisData
        if cellulitisData.count > 0{
            let condition = cellulitisData[0]
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
