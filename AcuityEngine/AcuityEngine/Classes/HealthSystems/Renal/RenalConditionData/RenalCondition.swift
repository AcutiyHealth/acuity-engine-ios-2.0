//
//  RenalCondition.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 05/02/21.
//

import UIKit

class RenalCondition {
    var kidneyDieaseData:[RenalConditionData]  = []
    var kidneyStonesData:[RenalConditionData]  = []
    var hypertensionData:[RenalConditionData]  = []
    var electrolyteDisordersData:[RenalConditionData]  = []
    var underweightMalnutritionData:[RenalConditionData]  = []
    var diabetesData:[RenalConditionData]  = []
    var UTIData:[RenalConditionData]  = []
 
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalConditionDataScore() -> Double {
        let kidneyDiease = (Double(kidneyDieaseData.average(\.score) ).isNaN ? 0 : Double(kidneyDieaseData.average(\.score) ) )
        let kidneyStones = (Double(kidneyStonesData.average(\.score)) .isNaN ? 0 : Double(kidneyStonesData.average(\.score)))
        let hypertension = (Double(hypertensionData.average(\.score)).isNaN ? 0 : Double(hypertensionData.average(\.score)))
        let electrolyteDisorders = (Double(electrolyteDisordersData.average(\.score)).isNaN ? 0 :  Double(electrolyteDisordersData.average(\.score)))
        let underweightMalnutrition = (Double(underweightMalnutritionData.average(\.score)).isNaN ? 0 :  Double(underweightMalnutritionData.average(\.score)))
        let diabetes = (Double(diabetesData.average(\.score)).isNaN ? 0 :  Double(diabetesData.average(\.score)))
        let UTI = (Double(UTIData.average(\.score)).isNaN ? 0 :  Double(UTIData.average(\.score)))
      
        
        let totalLabScore1 = kidneyDiease + kidneyStones
        let totalLabScore2 =  hypertension + electrolyteDisorders + underweightMalnutrition
        let totalLabScore3 =  diabetes + UTI
        return Double(totalLabScore1  + totalLabScore2 + totalLabScore3);
    }
    
    func getMaxConditionDataScore() -> Double {
        let kidneyDiease = RenalConditionRelativeImportance.kidneyDiease.getConvertedValueFromPercentage()
        let kidneyStones =  RenalConditionRelativeImportance.kidneyStones.getConvertedValueFromPercentage()
        let hypertension =  RenalConditionRelativeImportance.hypertension.getConvertedValueFromPercentage()
        let electrolyteDisorders =  RenalConditionRelativeImportance.electrolyteDisorders.getConvertedValueFromPercentage()
        let underweightMalnutrition =  RenalConditionRelativeImportance.underweightOrMalnutrition.getConvertedValueFromPercentage()
        let diabetes =  RenalConditionRelativeImportance.diabetes.getConvertedValueFromPercentage()
        let UTI =  RenalConditionRelativeImportance.UTI.getConvertedValueFromPercentage()
       
        
        let totalLabScore1 = kidneyDiease + kidneyStones
        let totalLabScore2 =  hypertension + electrolyteDisorders + underweightMalnutrition
        let totalLabScore3 =  diabetes + UTI
        return Double(totalLabScore1  + totalLabScore2 + totalLabScore3);
    }
    
    func totalConditionScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        //print(totalAmount) // 4500.0
       
        arrayDayWiseScoreTotal = []
        var renalProblem:[Metrix] = []
        renalProblem.append(contentsOf: kidneyDieaseData)
        renalProblem.append(contentsOf: kidneyStonesData)
        renalProblem.append(contentsOf: hypertensionData)
        renalProblem.append(contentsOf: electrolyteDisordersData)
        renalProblem.append(contentsOf: underweightMalnutritionData)
        renalProblem.append(contentsOf: diabetesData)
        renalProblem.append(contentsOf: UTIData)
       
        arrayDayWiseScoreTotal = getScoreForConditions(array: renalProblem, days: days)
        renalProblem = []
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[ConditionsModel]{
        
        var arrCondition:[ConditionsModel] = []
        //kidneyDieaseData
        if kidneyDieaseData.count > 0{
            let condition = kidneyDieaseData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //kidneyStonesData
        if kidneyStonesData.count > 0{
            let condition = kidneyStonesData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //hypertensionData
        if hypertensionData.count > 0{
            let condition = hypertensionData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //electrolyteDisordersData
        if electrolyteDisordersData.count > 0{
            let condition = electrolyteDisordersData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //underweightMalnutritionData
        if underweightMalnutritionData.count > 0{
            let condition = underweightMalnutritionData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //diabetesData
        if diabetesData.count > 0{
            let condition = diabetesData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //UTIData
        if UTIData.count > 0{
            let condition = UTIData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
   
        return arrCondition
        
    }
    
}
