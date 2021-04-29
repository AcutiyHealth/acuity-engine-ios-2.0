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
        
        arrayDayWiseScoreTotal = daywiseFilterMetrixsData(days: days, array: endocrineProblem, metriXType: MetricsType.Conditions)
        endocrineProblem = []
        return arrayDayWiseScoreTotal
    }
    
    func dictionaryRepresentation()->[ConditionsModel]{
        
        let objModel = AcuityDetailConditionViewModel()
        return objModel.getConditionData()
        
    }
    
}
