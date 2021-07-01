//
//  NeuroCondition.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//

import UIKit

class NeuroCondition {
    /*
     Depression/Anxiety
     Bipolar disorder
     Hx of Stroke
     Memory Loss/dementia
     Neuropathy
     diabetes
     hypertension
     Arrhythmia
     Coronary artery disease/peripheral vascular disease
     */
    var depressionData:[NeuroConditionData]  = []
    var bipolarDisorderData:[NeuroConditionData]  = []
    var hxOfStrokeData:[NeuroConditionData]  = []
    var memoryLossData:[NeuroConditionData]  = []
    var neuropathyData:[NeuroConditionData]  = []
    var diabetesData:[NeuroConditionData]  = []
    var hypertensionData:[NeuroConditionData]  = []
    var arrhythmiaData:[NeuroConditionData]  = []
    var coronaryArteryDiseaseData:[NeuroConditionData]  = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    
    func getMaxConditionDataScore() -> Double {
        //depressionAnxiety
        let depressionAnxiety = NeuroConditionRelativeImportance.depressionAnxiety.getConvertedValueFromPercentage()
        //bipolarDisorder
        let bipolarDisorder =  NeuroConditionRelativeImportance.bipolarDisorder.getConvertedValueFromPercentage()
        //HxOfStroke
        let HxOfStroke =  NeuroConditionRelativeImportance.HxOfStroke.getConvertedValueFromPercentage()
        //memoryLoss
        let memoryLoss =  NeuroConditionRelativeImportance.memoryLoss.getConvertedValueFromPercentage()
        //neuropathy
        let neuropathy = NeuroConditionRelativeImportance.neuropathy.getConvertedValueFromPercentage()
        //diabetes
        let diabetes = NeuroConditionRelativeImportance.diabetes.getConvertedValueFromPercentage()
        //hypertension
        let hypertension =  NeuroConditionRelativeImportance.hypertension.getConvertedValueFromPercentage()
        //arrhythmia
        let arrhythmia =  NeuroConditionRelativeImportance.arrhythmia.getConvertedValueFromPercentage()
        //coronaryArteryDisease
        let coronaryArteryDisease =  NeuroConditionRelativeImportance.coronaryArteryDisease.getConvertedValueFromPercentage()
        
        let totalConditionScore1 = depressionAnxiety + bipolarDisorder + HxOfStroke + memoryLoss
        let totalConditionScore2 = neuropathy + diabetes + hypertension + arrhythmia + coronaryArteryDisease
        
        return Double(totalConditionScore1+totalConditionScore2);
    }
    
    func totalConditionScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        arrayDayWiseScoreTotal = []
        var gastrointestinalProblem:[Metrix] = []
        gastrointestinalProblem.append(contentsOf: depressionData)
        gastrointestinalProblem.append(contentsOf: bipolarDisorderData)
        gastrointestinalProblem.append(contentsOf: hxOfStrokeData)
        gastrointestinalProblem.append(contentsOf: memoryLossData)
        gastrointestinalProblem.append(contentsOf: neuropathyData)
        gastrointestinalProblem.append(contentsOf: diabetesData)
        gastrointestinalProblem.append(contentsOf: hypertensionData)
        gastrointestinalProblem.append(contentsOf: arrhythmiaData)
        gastrointestinalProblem.append(contentsOf: coronaryArteryDiseaseData)
        
        arrayDayWiseScoreTotal = getScoreForConditions(array: gastrointestinalProblem, days: days)
        
        gastrointestinalProblem = []
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[ConditionsModel]{
        
        var arrCondition:[ConditionsModel] = []
        //depressionData
        if depressionData.count > 0{
            let condition = depressionData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //bipolarDisorderData
        if bipolarDisorderData.count > 0{
            let condition = bipolarDisorderData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //hxOfStrokeData
        if hxOfStrokeData.count > 0{
            let condition = hxOfStrokeData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //memoryLossData
        if memoryLossData.count > 0{
            let condition = memoryLossData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        
        //neuropathyData
        if neuropathyData.count > 0{
            let condition = neuropathyData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //diabetesData
        if diabetesData.count > 0{
            let condition = diabetesData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        
        //hypertensionData
        if hypertensionData.count > 0{
            let condition = hypertensionData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //arrhythmiaData
        if arrhythmiaData.count > 0{
            let condition = arrhythmiaData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //coronaryArteryDiseaseData
        if coronaryArteryDiseaseData.count > 0{
            let condition = coronaryArteryDiseaseData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        return arrCondition
        
    }
    
    
}
