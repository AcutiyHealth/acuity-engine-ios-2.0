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
        var cardioProblem:[Metrix] = []
        cardioProblem.append(contentsOf: kidneyDieaseData)
        cardioProblem.append(contentsOf: kidneyStonesData)
        cardioProblem.append(contentsOf: hypertensionData)
        cardioProblem.append(contentsOf: electrolyteDisordersData)
        cardioProblem.append(contentsOf: underweightMalnutritionData)
        cardioProblem.append(contentsOf: diabetesData)
        cardioProblem.append(contentsOf: UTIData)
       
        arrayDayWiseScoreTotal = daywiseFilterMetrixsData(days: days, array: cardioProblem, metriXType: MetricsType.Conditions)
        cardioProblem = []
        return arrayDayWiseScoreTotal
    }
    
    func dictionaryRepresentation()->[ConditionsModel]{
        
        let objModel = AcuityDetailConditionViewModel()
        return objModel.getConditionData()
        
    }
    
}
