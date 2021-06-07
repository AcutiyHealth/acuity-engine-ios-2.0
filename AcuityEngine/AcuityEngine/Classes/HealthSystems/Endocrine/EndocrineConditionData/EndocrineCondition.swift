//
//  EndocrineCondition.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 05/02/21.
//

import UIKit

class EndocrineCondition {
    /*
     diabetes
     Thyroid disorder
     Polycystic Ovarian Disease
     Hormone problems
     */
    var diabetesData:[EndocrineConditionData]  = []
    var thyroidDisorderData:[EndocrineConditionData]  = []
    var polycysticOvarianDiseaseData:[EndocrineConditionData]  = []
    var hormoneProblemsData:[EndocrineConditionData]  = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    
    func getMaxConditionDataScore() -> Double {
        //diabetes
        let diabetes = EndocrineConditionRelativeImportance.diabetes.getConvertedValueFromPercentage()
        //thyroidDisorder
        let thyroidDisorder =  EndocrineConditionRelativeImportance.thyroidDisorder.getConvertedValueFromPercentage()
        //polycysticOvarianDisease
        let polycysticOvarianDisease =  EndocrineConditionRelativeImportance.polycysticOvarianDisease.getConvertedValueFromPercentage()
        //hormoneProblems
        let hormoneProblems =  EndocrineConditionRelativeImportance.hormoneProblems.getConvertedValueFromPercentage()
        
        let totalConditionScore1 = diabetes + thyroidDisorder + polycysticOvarianDisease + hormoneProblems
        
        return Double(totalConditionScore1);
    }
    
    func totalConditionScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        //print(totalAmount) // 4500.0
        
        arrayDayWiseScoreTotal = []
        var endocrineProblem:[Metrix] = []
        endocrineProblem.append(contentsOf: diabetesData)
        endocrineProblem.append(contentsOf: thyroidDisorderData)
        endocrineProblem.append(contentsOf: polycysticOvarianDiseaseData)
        endocrineProblem.append(contentsOf: hormoneProblemsData)
        arrayDayWiseScoreTotal = getScoreForConditions(array: endocrineProblem, days: days)
        endocrineProblem = []
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[ConditionsModel]{
        
        var arrCondition:[ConditionsModel] = []
        //diabetesData
        if diabetesData.count > 0{
            let condition = diabetesData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //thyroidDisorderData
        if thyroidDisorderData.count > 0{
            let condition = thyroidDisorderData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //polycysticOvarianDiseaseData
        if polycysticOvarianDiseaseData.count > 0{
            let condition = polycysticOvarianDiseaseData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //hormoneProblemsData
        if hormoneProblemsData.count > 0{
            let condition = hormoneProblemsData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        
        return arrCondition
        
    }
    
    
}
