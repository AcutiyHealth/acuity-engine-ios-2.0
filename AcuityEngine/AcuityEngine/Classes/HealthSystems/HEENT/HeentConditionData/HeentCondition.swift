//
//  HeentCondition.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class HeentCondition {
    /*
     Allergic Rhnitis
     Upper respiratory infection
     Covid
     Decreased vision
     Hearing Loss
     Otitis
     diabetes
     */
    
    var allergicRhiniitisData:[HeentConditionData]  = []
    var respiratoryInfectionData:[HeentConditionData]  = []
    var covidData:[HeentConditionData]  = []
    var decreasedVisionData:[HeentConditionData]  = []
    var hearingLossData:[HeentConditionData]  = []
    var otitisData:[HeentConditionData]  = []
    var diabetesData:[HeentConditionData]  = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    
    func getMaxConditionDataScore() -> Double {
        //allergicRhiniitis
        let allergicRhiniitis = HeentConditionRelativeImportance.allergicRhiniitis.getConvertedValueFromPercentage()
        //respiratoryInfection
        let respiratoryInfection =  HeentConditionRelativeImportance.respiratoryInfection.getConvertedValueFromPercentage()
        //covid
        let covid =  HeentConditionRelativeImportance.covid.getConvertedValueFromPercentage()
        //decreasedVision
        let decreasedVision =  HeentConditionRelativeImportance.decreasedVision.getConvertedValueFromPercentage()
        //hearingLoss
        let hearingLoss = HeentConditionRelativeImportance.hearingLoss.getConvertedValueFromPercentage()
        //otitis
        let otitis =  HeentConditionRelativeImportance.otitis.getConvertedValueFromPercentage()
        //diabetes
        let diabetes =  HeentConditionRelativeImportance.diabetes.getConvertedValueFromPercentage()
       
        let totalConditionScore1 = allergicRhiniitis + respiratoryInfection + covid + decreasedVision + hearingLoss + otitis + diabetes
        
        return Double(totalConditionScore1);
    }
    
    func totalConditionScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        arrayDayWiseScoreTotal = []
        var HeentProblem:[Metrix] = []
        HeentProblem.append(contentsOf: allergicRhiniitisData)
        HeentProblem.append(contentsOf: respiratoryInfectionData)
        HeentProblem.append(contentsOf: covidData)
        HeentProblem.append(contentsOf: decreasedVisionData)
        HeentProblem.append(contentsOf: hearingLossData)
        HeentProblem.append(contentsOf: otitisData)
        HeentProblem.append(contentsOf: diabetesData)
        
        arrayDayWiseScoreTotal = getScoreForConditions(array: HeentProblem, days: days)
        
        HeentProblem = []
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[ConditionsModel]{
       
        var arrCondition:[ConditionsModel] = []
        //allergicRhiniitisData
        if allergicRhiniitisData.count > 0{
            let condition = allergicRhiniitisData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //respiratoryInfectionData
        if respiratoryInfectionData.count > 0{
            let condition = respiratoryInfectionData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //covidData
        if covidData.count > 0{
            let condition = covidData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //decreasedVisionData
        if decreasedVisionData.count > 0{
            let condition = decreasedVisionData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //hearingLossData
        if hearingLossData.count > 0{
            let condition = hearingLossData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //otitisData
        if otitisData.count > 0{
            let condition = otitisData[0]
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
