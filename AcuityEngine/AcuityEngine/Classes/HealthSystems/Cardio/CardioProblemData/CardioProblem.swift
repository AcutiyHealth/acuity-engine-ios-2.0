//
//  CardioCondition.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class CardioCondition {
    var hyperTenstionData:[CardioConditionData]  = []
    var arrhythmiaData:[CardioConditionData]  = []
    var heartFailureData:[CardioConditionData]  = []
    var arteryDieseaseData:[CardioConditionData]  = []
    var hyperLipidemiaData:[CardioConditionData]  = []
    var anemiaData:[CardioConditionData]  = []
    var diabetesData:[CardioConditionData]  = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalConditionDataScore() -> Double {
        let hyperTenstion = (Double(hyperTenstionData.average(\.score) ).isNaN ? 0 : Double(hyperTenstionData.average(\.score) ) )
        let arrhythmia = (Double(arrhythmiaData.average(\.score)) .isNaN ? 0 : Double(arrhythmiaData.average(\.score)))
        let heartFailure = (Double(heartFailureData.average(\.score)).isNaN ? 0 : Double(heartFailureData.average(\.score)))
        let arteryDiesease = (Double(arteryDieseaseData.average(\.score)).isNaN ? 0 :  Double(arteryDieseaseData.average(\.score)))
        let hyperLipidemia = (Double(hyperLipidemiaData.average(\.score)).isNaN ? 0 :  Double(hyperLipidemiaData.average(\.score)))
        let anemia = (Double(anemiaData.average(\.score)).isNaN ? 0 :  Double(anemiaData.average(\.score)))
        let diabetes = (Double(diabetesData.average(\.score)).isNaN ? 0 :  Double(diabetesData.average(\.score)))
        
        let totalLabScore1 = hyperTenstion + arrhythmia
        let totalLabScore2 =  heartFailure + arteryDiesease
        let totalLabScore3 =  hyperLipidemia + anemia + diabetes
        return Double(totalLabScore1  + totalLabScore2 + totalLabScore3);
    }
    
    func getMaxConditionDataScore() -> Double {
        let hyperTenstion = CardioConditionRelativeImportance.hypertension.getConvertedValueFromPercentage()
        let arrhythmia = CardioConditionRelativeImportance.arrhythmia.getConvertedValueFromPercentage()
        let heartFailure = CardioConditionRelativeImportance.heartFailure.getConvertedValueFromPercentage()
        let arteryDiesease = CardioConditionRelativeImportance.arteryDisease.getConvertedValueFromPercentage()
        let diabetes = CardioConditionRelativeImportance.diabetes.getConvertedValueFromPercentage()
        let anemia = CardioConditionRelativeImportance.anemia.getConvertedValueFromPercentage()
        let hyperlipidemia = CardioConditionRelativeImportance.hyperlipidemia.getConvertedValueFromPercentage()
        
        let totalLabScore1 = hyperTenstion + arrhythmia
        let totalLabScore2 =  heartFailure + arteryDiesease
        let totalLabScore3 =  diabetes + anemia + hyperlipidemia
        return Double(totalLabScore1  + totalLabScore2 + totalLabScore3);
    }
    
    func totalConditionScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        //print(totalAmount) // 4500.0
       
        arrayDayWiseScoreTotal = []
        var cardioProblem:[Metrix] = []
        cardioProblem.append(contentsOf: hyperTenstionData)
        cardioProblem.append(contentsOf: arrhythmiaData)
        cardioProblem.append(contentsOf: heartFailureData)
        cardioProblem.append(contentsOf: arteryDieseaseData)
        cardioProblem.append(contentsOf: diabetesData)
        cardioProblem.append(contentsOf: anemiaData)
        cardioProblem.append(contentsOf: hyperLipidemiaData)
      
        arrayDayWiseScoreTotal = daywiseFilterMetrixsData(days: days, array: cardioProblem, metriXType: MetricsType.Conditions)
        cardioProblem = []
        return arrayDayWiseScoreTotal
    }
    
    func dictionaryRepresentation()->[ConditionsModel]{
        
        let objModel = AcuityDetailConditionViewModel()
        return objModel.getConditionData()
        
    }
    
}
