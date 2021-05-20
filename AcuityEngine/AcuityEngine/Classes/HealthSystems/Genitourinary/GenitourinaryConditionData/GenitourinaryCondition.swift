//
//  GenitourinaryCondition.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class GenitourinaryCondition {
    /*
     UTI
     Urinary problems
     kidney stones
     chronic kidney disease
     diabetes
     */
    var UTIData:[GenitourinaryConditionData]  = []
    var urinaryProblemsData:[GenitourinaryConditionData]  = []
    var kidneyStonesData:[GenitourinaryConditionData]  = []
    var kidneyDiseaseData:[GenitourinaryConditionData]  = []
    var diabetesData:[GenitourinaryConditionData]  = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    
    func getMaxConditionDataScore() -> Double {
        //UTI
        let UTI = GenitourinaryConditionRelativeImportance.UTI.getConvertedValueFromPercentage()
        //urinaryProblems
        let urinaryProblems =  GenitourinaryConditionRelativeImportance.urinaryProblems.getConvertedValueFromPercentage()
        //kidneyStones
        let kidneyStones =  GenitourinaryConditionRelativeImportance.kidneyStones.getConvertedValueFromPercentage()
        //chronicKidneyDisease
        let chronicKidneyDisease =  GenitourinaryConditionRelativeImportance.chronicKidneyDisease.getConvertedValueFromPercentage()
        //diabetes
        let diabetes = GenitourinaryConditionRelativeImportance.diabetes.getConvertedValueFromPercentage()

        let totalConditionScore1 = UTI + urinaryProblems + kidneyStones + chronicKidneyDisease
        let totalConditionScore2 = diabetes
      
        return Double(totalConditionScore1+totalConditionScore2);
    }
    
    func totalConditionScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        //print(totalAmount) // 4500.0
        
        arrayDayWiseScoreTotal = []
        var gastrointestinalProblem:[Metrix] = []
        gastrointestinalProblem.append(contentsOf: UTIData)
        gastrointestinalProblem.append(contentsOf: urinaryProblemsData)
        gastrointestinalProblem.append(contentsOf: kidneyStonesData)
        gastrointestinalProblem.append(contentsOf: kidneyDiseaseData)
        gastrointestinalProblem.append(contentsOf: diabetesData)
  
        
        arrayDayWiseScoreTotal = getScoreForConditions(array: gastrointestinalProblem, days: days)
        
        gastrointestinalProblem = []
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
        //urinaryProblemsData
        if urinaryProblemsData.count > 0{
            let condition = urinaryProblemsData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //kidneyStonesData
        if kidneyStonesData.count > 0{
            let condition = kidneyStonesData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //kidneyDiseaseData
        if kidneyDiseaseData.count > 0{
            let condition = kidneyDiseaseData[0]
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
