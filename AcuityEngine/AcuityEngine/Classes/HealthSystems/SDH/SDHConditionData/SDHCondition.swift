//
//  SDHCondition.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class SDHCondition {
    /*
     Single
     Sedintary lifestyle
     unsafe Housing
     Overweight/Obesity
     Unemployed
     Smoking
     diabetes
     */
    var singleData:[SDHConditionData]  = []
    var sedintaryLifestyleData:[SDHConditionData]  = []
    var unsafeHousingData:[SDHConditionData]  = []
    var overweightData:[SDHConditionData]  = []
    var unemployedData:[SDHConditionData]  = []
    var smokingData:[SDHConditionData]  = []
    var diabetesData:[SDHConditionData]  = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    
    func getMaxConditionDataScore() -> Double {
        //single
        let single = SDHConditionRelativeImportance.single.getConvertedValueFromPercentage()
        //sedintaryLifestyle
        let sedintaryLifestyle =  SDHConditionRelativeImportance.sedintaryLifestyle.getConvertedValueFromPercentage()
        //unsafeHousing
        let unsafeHousing =  SDHConditionRelativeImportance.unsafeHousing.getConvertedValueFromPercentage()
        //overweightOrObesity
        let overweightOrObesity =  SDHConditionRelativeImportance.overweightOrObesity.getConvertedValueFromPercentage()
        //unemployed
        let unemployed = SDHConditionRelativeImportance.unemployed.getConvertedValueFromPercentage()
        //diabetes
        let diabetes = SDHConditionRelativeImportance.diabetes.getConvertedValueFromPercentage()
        //smoking
        let smoking =  SDHConditionRelativeImportance.smoking.getConvertedValueFromPercentage()
        
        let totalConditionScore1 = single + sedintaryLifestyle + unsafeHousing + overweightOrObesity
        let totalConditionScore2 = unemployed + diabetes + smoking
        
        return Double(totalConditionScore1+totalConditionScore2);
    }
    
    func totalConditionScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        arrayDayWiseScoreTotal = []
        var SDHProblem:[Metrix] = []
        SDHProblem.append(contentsOf: singleData)
        SDHProblem.append(contentsOf: sedintaryLifestyleData)
        SDHProblem.append(contentsOf: unsafeHousingData)
        SDHProblem.append(contentsOf: overweightData)
        SDHProblem.append(contentsOf: unemployedData)
        SDHProblem.append(contentsOf: diabetesData)
        SDHProblem.append(contentsOf: smokingData)
        
        arrayDayWiseScoreTotal = getScoreForConditions(array: SDHProblem, days: days)
        
        SDHProblem = []
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[ConditionsModel]{
        /*
         Single
         Sedintary lifestyle
         unsafe Housing
         Overweight/Obesity
         Unemployed
         Smoking
         diabetes
         */
        var arrCondition:[ConditionsModel] = []
        //singleData
        if singleData.count > 0{
            let condition = singleData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //sedintaryLifestyleData
        if sedintaryLifestyleData.count > 0{
            let condition = sedintaryLifestyleData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //unsafeHousingData
        if unsafeHousingData.count > 0{
            let condition = unsafeHousingData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //overweightData
        if overweightData.count > 0{
            let condition = overweightData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        
        //unemployedData
        if unemployedData.count > 0{
            let condition = unemployedData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //diabetesData
        if diabetesData.count > 0{
            let condition = diabetesData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        
        //smokingData
        if smokingData.count > 0{
            let condition = smokingData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
 
        return arrCondition
        
    }
    
    
}
