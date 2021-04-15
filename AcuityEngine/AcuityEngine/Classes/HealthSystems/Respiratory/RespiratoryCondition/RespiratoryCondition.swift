//
//  RespiratoryCondition.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class RespiratoryCondition {
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
        var cardioProblem:[Metrix] = []
        cardioProblem.append(contentsOf: asthmaData)
        cardioProblem.append(contentsOf: pneumoniaData)
        cardioProblem.append(contentsOf: respiratoryInfectionData)
        cardioProblem.append(contentsOf: covidData)
        cardioProblem.append(contentsOf: allergicRhiniitisData)
        cardioProblem.append(contentsOf: smokingData)
        cardioProblem.append(contentsOf: sleepApneaData)
        cardioProblem.append(contentsOf: heartFailureData)
        cardioProblem.append(contentsOf: coronaryArteryDiseaseData)

        arrayDayWiseScoreTotal = daywiseFilterMetrixsData(days: days, array: cardioProblem, metriXType: MetricsType.Conditions)
        cardioProblem = []
        return arrayDayWiseScoreTotal
    }
    
    func dictionaryRepresentation()->[ConditionsModel]{
        
        let objModel = AcuityDetailConditionViewModel()
        return objModel.getConditionData()
        
    }
    
}
