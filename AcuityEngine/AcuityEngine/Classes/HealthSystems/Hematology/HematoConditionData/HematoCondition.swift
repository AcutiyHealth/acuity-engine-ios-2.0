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
 
        arrayDayWiseScoreTotal = daywiseFilterMetrixsData(days: days, array: hematoProblem, metriXType: MetricsType.Conditions)
        hematoProblem = []
        return arrayDayWiseScoreTotal
    }
    
    func dictionaryRepresentation()->[ConditionsModel]{
        
        let objModel = AcuityDetailConditionViewModel()
        return objModel.getConditionData()
        
    }
    
}
