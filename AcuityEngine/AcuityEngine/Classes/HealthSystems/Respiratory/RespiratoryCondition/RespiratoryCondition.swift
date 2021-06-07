//
//  RespiratoryCondition.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class RespiratoryCondition {
    /*COPD/Asthma
     Bronchitis/pneumonia
     Upper respiratory infection
     Covid
     Allergic Rhiniitis
     Smoking
     sleep apnea
     Congestive heart failure
     Coronary artery disease/peripheral vascular disease
     */
    var asthmaData:[RespiratoryConditionData]  = []
    var pneumoniaData:[RespiratoryConditionData]  = []
    var respiratoryInfectionData:[RespiratoryConditionData]  = []
    var covidData:[RespiratoryConditionData]  = []
    var allergicRhiniitisData:[RespiratoryConditionData]  = []
    var smokingData:[RespiratoryConditionData]  = []
    var sleepApneaData:[RespiratoryConditionData]  = []
    var heartFailureData:[RespiratoryConditionData]  = []
    var coronaryArteryDiseaseData:[RespiratoryConditionData]  = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalConditionDataScore() -> Double {
        let asthma = (Double(asthmaData.average(\.score) ).isNaN ? 0 : Double(asthmaData.average(\.score) ) )
        let pneumonia = (Double(pneumoniaData.average(\.score)) .isNaN ? 0 : Double(pneumoniaData.average(\.score)))
        let respiratoryInfection = (Double(respiratoryInfectionData.average(\.score)).isNaN ? 0 : Double(respiratoryInfectionData.average(\.score)))
        let covid = (Double(covidData.average(\.score)).isNaN ? 0 :  Double(covidData.average(\.score)))
        let allergicRhiniitis = (Double(allergicRhiniitisData.average(\.score)).isNaN ? 0 :  Double(allergicRhiniitisData.average(\.score)))
        let smoking = (Double(smokingData.average(\.score)).isNaN ? 0 :  Double(smokingData.average(\.score)))
        let sleepApnea = (Double(sleepApneaData.average(\.score)).isNaN ? 0 :  Double(sleepApneaData.average(\.score)))
        let heartFailure = (Double(heartFailureData.average(\.score)).isNaN ? 0 :  Double(heartFailureData.average(\.score)))
        let coronaryArteryDisease = (Double(coronaryArteryDiseaseData.average(\.score)).isNaN ? 0 :  Double(coronaryArteryDiseaseData.average(\.score)))
        
        
        let totalLabScore1 = asthma + pneumonia
        let totalLabScore2 =  respiratoryInfection + covid + allergicRhiniitis
        let totalLabScore3 =  smoking + sleepApnea + heartFailure + coronaryArteryDisease
        return Double(totalLabScore1  + totalLabScore2 + totalLabScore3);
    }
    
    func getMaxConditionDataScore() -> Double {
        let asthma = RespiratoryConditionRelativeImportance.asthma.getConvertedValueFromPercentage()
        let pneumonia =  RespiratoryConditionRelativeImportance.pneumonia.getConvertedValueFromPercentage()
        let respiratoryInfection =  RespiratoryConditionRelativeImportance.respiratoryInfection.getConvertedValueFromPercentage()
        let covid =  RespiratoryConditionRelativeImportance.covid.getConvertedValueFromPercentage()
        let allergicRhiniitis =  RespiratoryConditionRelativeImportance.allergicRhiniitis.getConvertedValueFromPercentage()
        let smoking =  RespiratoryConditionRelativeImportance.smoking.getConvertedValueFromPercentage()
        let sleepApnea =  RespiratoryConditionRelativeImportance.sleepApnea.getConvertedValueFromPercentage()
        let heartFailure =  RespiratoryConditionRelativeImportance.heartFailure.getConvertedValueFromPercentage()
        let coronaryArteryDisease =  RespiratoryConditionRelativeImportance.coronaryArteryDisease.getConvertedValueFromPercentage()
        
        
        let totalLabScore1 = asthma + pneumonia
        let totalLabScore2 =  respiratoryInfection + covid + allergicRhiniitis
        let totalLabScore3 =  smoking + sleepApnea + heartFailure + coronaryArteryDisease
        return Double(totalLabScore1  + totalLabScore2 + totalLabScore3);
    }
    
    func totalConditionScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        //print(totalAmount) // 4500.0
        
        arrayDayWiseScoreTotal = []
        var respiratoryProblem:[Metrix] = []
        respiratoryProblem.append(contentsOf: asthmaData)
        respiratoryProblem.append(contentsOf: pneumoniaData)
        respiratoryProblem.append(contentsOf: respiratoryInfectionData)
        respiratoryProblem.append(contentsOf: covidData)
        respiratoryProblem.append(contentsOf: allergicRhiniitisData)
        respiratoryProblem.append(contentsOf: smokingData)
        respiratoryProblem.append(contentsOf: sleepApneaData)
        respiratoryProblem.append(contentsOf: heartFailureData)
        respiratoryProblem.append(contentsOf: coronaryArteryDiseaseData)
        
        arrayDayWiseScoreTotal = getScoreForConditions(array: respiratoryProblem, days: days)
        respiratoryProblem = []
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[ConditionsModel]{
        
        var arrCondition:[ConditionsModel] = []
        //asthmaData
        if asthmaData.count > 0{
            let condition = asthmaData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //pneumoniaData
        if pneumoniaData.count > 0{
            let condition = pneumoniaData[0]
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
        //allergicRhiniitisData
        if allergicRhiniitisData.count > 0{
            let condition = allergicRhiniitisData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //smokingData
        if smokingData.count > 0{
            let condition = smokingData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //sleepApneaData
        if sleepApneaData.count > 0{
            let condition = sleepApneaData[0]
            arrCondition.append(getConditionsModel(condition: condition))
        }
        //heartFailureData
        if heartFailureData.count > 0{
            let condition = heartFailureData[0]
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
