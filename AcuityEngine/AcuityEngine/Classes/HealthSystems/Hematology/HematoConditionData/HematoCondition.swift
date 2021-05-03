//
//  HematoCondition.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 05/02/21.
//

import UIKit

class HematoCondition {
    /*
     Anemia
     Cancer (of any type)
     Other Heme/Onc problem
     */
    var anemiaData:[HematoConditionData]  = []
    var cancerData:[HematoConditionData]  = []
    var otherHematoProblemData:[HematoConditionData]  = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    
    func getMaxConditionDataScore() -> Double {
        //anemia
        let anemia = HematoConditionRelativeImportance.anemia.getConvertedValueFromPercentage()
        //cancer
        let cancer =  HematoConditionRelativeImportance.cancer.getConvertedValueFromPercentage()
        //otherHematoProblem
        let otherHematoProblem =  HematoConditionRelativeImportance.otherHematoProblem.getConvertedValueFromPercentage()
        
        let totalConditionScore1 = anemia + cancer + otherHematoProblem
        
        return Double(totalConditionScore1);
    }
    
    func totalConditionScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        //print(totalAmount) // 4500.0
        
        arrayDayWiseScoreTotal = []
        var hematoProblem:[Metrix] = []
        hematoProblem.append(contentsOf: anemiaData)
        hematoProblem.append(contentsOf: cancerData)
        hematoProblem.append(contentsOf: otherHematoProblemData)
        arrayDayWiseScoreTotal = getScoreForConditions(array: hematoProblem, days: days)
        hematoProblem = []
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[ConditionsModel]{
        
        var arrCondition:[ConditionsModel] = []
        //anemiaData
        if anemiaData.count > 0{
            let condition = anemiaData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //cancerData
        if cancerData.count > 0{
            let condition = cancerData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //otherHematoProblemData
        if otherHematoProblemData.count > 0{
            let condition = otherHematoProblemData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        
        return arrCondition
        
    }
    
}
