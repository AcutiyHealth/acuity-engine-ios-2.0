//
//  GastrointestinalCondition.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 05/02/21.
//

import UIKit

class GastrointestinalCondition {
    /*
     GERD
     Hyperlipidemia
     Ulcerative Colitis
     Crohns disease
     Gastroentritis
     Irritable Bowel disease
     Obesity/overweight
     sleep apnea
     underweight/malnutrition
     Liver DIsease
     diabetes
     */
    var GERDData:[GastrointestinalConditionData]  = []
    var hyperlipidemiaData:[GastrointestinalConditionData]  = []
    var ulcerativeColitisData:[GastrointestinalConditionData]  = []
    var crohnsDiseaseData:[GastrointestinalConditionData]  = []
    var gastroentritisData:[GastrointestinalConditionData]  = []
    var irritableBowelDiseaseData:[GastrointestinalConditionData]  = []
    var overweightData:[GastrointestinalConditionData]  = []
    var sleepApneaData:[GastrointestinalConditionData]  = []
    var underweightMalnutritionData:[GastrointestinalConditionData]  = []
    var liverDiseaseData:[GastrointestinalConditionData]  = []
    var diabetesData:[GastrointestinalConditionData]  = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    
    func getMaxConditionDataScore() -> Double {
        //GERD
        let GERD = GastrointestinalConditionRelativeImportance.GERD.getConvertedValueFromPercentage()
        //hyperlipidemia
        let hyperlipidemia =  GastrointestinalConditionRelativeImportance.hyperlipidemia.getConvertedValueFromPercentage()
        //ulcerativeColitis
        let ulcerativeColitis =  GastrointestinalConditionRelativeImportance.ulcerativeColitis.getConvertedValueFromPercentage()
        //crohnsDisease
        let crohnsDisease =  GastrointestinalConditionRelativeImportance.crohnsDisease.getConvertedValueFromPercentage()
        //gastroentritis
        let gastroentritis = GastrointestinalConditionRelativeImportance.gastroentritis.getConvertedValueFromPercentage()
        //irritableBowelDisease
        let irritableBowelDisease =  GastrointestinalConditionRelativeImportance.irritableBowelDisease.getConvertedValueFromPercentage()
        //overweight
        let overweight =  GastrointestinalConditionRelativeImportance.overweight.getConvertedValueFromPercentage()
        //sleepApnea
        let sleepApnea =  GastrointestinalConditionRelativeImportance.sleepApnea.getConvertedValueFromPercentage()
        //underweightMalnutrition
        let underweightMalnutrition =  GastrointestinalConditionRelativeImportance.underweightMalnutrition.getConvertedValueFromPercentage()
        //liverDisease
        let liverDisease =  GastrointestinalConditionRelativeImportance.liverDisease.getConvertedValueFromPercentage()
        //diabetes
        let diabetes =  GastrointestinalConditionRelativeImportance.diabetes.getConvertedValueFromPercentage()
        
        let totalConditionScore1 = GERD + hyperlipidemia + ulcerativeColitis + crohnsDisease
        let totalConditionScore2 = gastroentritis + irritableBowelDisease + overweight + sleepApnea
        let totalConditionScore3 = underweightMalnutrition + liverDisease + diabetes
        
        return Double(totalConditionScore1+totalConditionScore2+totalConditionScore3);
    }
    
    func totalConditionScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        //print(totalAmount) // 4500.0
        
        arrayDayWiseScoreTotal = []
        var gastrointestinalProblem:[Metrix] = []
        gastrointestinalProblem.append(contentsOf: GERDData)
        gastrointestinalProblem.append(contentsOf: hyperlipidemiaData)
        gastrointestinalProblem.append(contentsOf: ulcerativeColitisData)
        gastrointestinalProblem.append(contentsOf: crohnsDiseaseData)
        
        gastrointestinalProblem.append(contentsOf: gastroentritisData)
        gastrointestinalProblem.append(contentsOf: irritableBowelDiseaseData)
        gastrointestinalProblem.append(contentsOf: overweightData)
        gastrointestinalProblem.append(contentsOf: sleepApneaData)
        
        gastrointestinalProblem.append(contentsOf: underweightMalnutritionData)
        gastrointestinalProblem.append(contentsOf: liverDiseaseData)
        gastrointestinalProblem.append(contentsOf: diabetesData)
        
        arrayDayWiseScoreTotal = getScoreForConditions(array: gastrointestinalProblem, days: days)
        
        gastrointestinalProblem = []
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[ConditionsModel]{
        
        var arrCondition:[ConditionsModel] = []
        //GERDData
        if GERDData.count > 0{
            let condition = GERDData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //hyperlipidemiaData
        if hyperlipidemiaData.count > 0{
            let condition = hyperlipidemiaData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //ulcerativeColitisData
        if ulcerativeColitisData.count > 0{
            let condition = ulcerativeColitisData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //crohnsDiseaseData
        if crohnsDiseaseData.count > 0{
            let condition = crohnsDiseaseData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        
        //gastroentritisData
        if gastroentritisData.count > 0{
            let condition = gastroentritisData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //irritableBowelDiseaseData
        if irritableBowelDiseaseData.count > 0{
            let condition = irritableBowelDiseaseData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //overweightData
        if overweightData.count > 0{
            let condition = overweightData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //sleepApneaData
        if sleepApneaData.count > 0{
            let condition = sleepApneaData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        
        //underweightMalnutritionData
        if underweightMalnutritionData.count > 0{
            let condition = underweightMalnutritionData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //liverDiseaseData
        if liverDiseaseData.count > 0{
            let condition = liverDiseaseData[0]
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
