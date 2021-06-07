//
//  MuscCondition.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class MuscCondition {
    /*
     Muscular Sprain/Strain
     Osteoarthritis
     Osteoporosis
     Rheumatoid Arthritis
     Gout
     Hx of Stroke
     Neuropathy
     */
    
    var muscularSprainData:[MuscConditionData]  = []
    var osteoporosisData:[MuscConditionData]  = []
    var osteoarthritisData:[MuscConditionData]  = []
    var rheumatoidArthritisData:[MuscConditionData]  = []
    var GoutData:[MuscConditionData]  = []
    var HxOfStrokeData:[MuscConditionData]  = []
    var neuropathyData:[MuscConditionData]  = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    
    func getMaxConditionDataScore() -> Double {
        //muscularSprain
        let muscularSprain = MuscConditionRelativeImportance.muscularSprain.getConvertedValueFromPercentage()
        //osteoporosis
        let osteoporosis =  MuscConditionRelativeImportance.osteoporosis.getConvertedValueFromPercentage()
        //osteoarthritis
        let osteoarthritis =  MuscConditionRelativeImportance.osteoarthritis.getConvertedValueFromPercentage()
        //rheumatoidArthritis
        let rheumatoidArthritis =  MuscConditionRelativeImportance.rheumatoidArthritis.getConvertedValueFromPercentage()
        //Gout
        let Gout = MuscConditionRelativeImportance.Gout.getConvertedValueFromPercentage()
        //HxOfStroke
        let HxOfStroke = MuscConditionRelativeImportance.HxOfStroke.getConvertedValueFromPercentage()
        //neuropathy
        let neuropathy =  MuscConditionRelativeImportance.neuropathy.getConvertedValueFromPercentage()
        
        let totalConditionScore1 = muscularSprain + osteoporosis + osteoarthritis + rheumatoidArthritis
        let totalConditionScore2 = Gout + HxOfStroke + neuropathy
        
        return Double(totalConditionScore1+totalConditionScore2);
    }
    
    func totalConditionScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        arrayDayWiseScoreTotal = []
        var MuscProblem:[Metrix] = []
        MuscProblem.append(contentsOf: muscularSprainData)
        MuscProblem.append(contentsOf: osteoporosisData)
        MuscProblem.append(contentsOf: osteoarthritisData)
        MuscProblem.append(contentsOf: rheumatoidArthritisData)
        MuscProblem.append(contentsOf: GoutData)
        MuscProblem.append(contentsOf: HxOfStrokeData)
        MuscProblem.append(contentsOf: neuropathyData)
        
        arrayDayWiseScoreTotal = getScoreForConditions(array: MuscProblem, days: days)
        
        MuscProblem = []
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[ConditionsModel]{
  
        var arrCondition:[ConditionsModel] = []
        //muscularSprainData
        if muscularSprainData.count > 0{
            let condition = muscularSprainData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //osteoporosisData
        if osteoporosisData.count > 0{
            let condition = osteoporosisData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //osteoarthritisData
        if osteoarthritisData.count > 0{
            let condition = osteoarthritisData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //rheumatoidArthritisData
        if rheumatoidArthritisData.count > 0{
            let condition = rheumatoidArthritisData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        
        //GoutData
        if GoutData.count > 0{
            let condition = GoutData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //HxOfStrokeData
        if HxOfStrokeData.count > 0{
            let condition = HxOfStrokeData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        
        //neuropathyData
        if neuropathyData.count > 0{
            let condition = neuropathyData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        
        return arrCondition
        
    }
    
    
}
