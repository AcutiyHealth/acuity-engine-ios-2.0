//
//  CardioLab.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class IDiseaseLab {
    /*WBC's
     Neutrophil %
     blood glucose
     Urine nitrites
     Urine Blood
     Anion gap */
    var WBCData:[IDiseaseLabData] = []
    var neutrophilData:[IDiseaseLabData]  = []
    var bloodGlucoseData:[IDiseaseLabData] = []
    var urineNitrites:[IDiseaseLabData] = []
    var urineBlood:[IDiseaseLabData] = []
    var anionGapData:[IDiseaseLabData] = []

    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalLabDataScore() -> Double {
       
        return 0;
    }
    
    func getMaxLabDataScore() -> Double {
   
        let WBC = IDiseaseLabRelativeImportance.WBC.getConvertedValueFromPercentage()
        let neutrophil = IDiseaseLabRelativeImportance.neutrophil.getConvertedValueFromPercentage()
        let bloodGlucose = IDiseaseLabRelativeImportance.bloodGlucose.getConvertedValueFromPercentage()
        let urineNitrites = IDiseaseLabRelativeImportance.urineNitrites.getConvertedValueFromPercentage()
        let urineBlood = IDiseaseLabRelativeImportance.urineBlood.getConvertedValueFromPercentage()
        let anionGap = IDiseaseLabRelativeImportance.anionGap.getConvertedValueFromPercentage()
        
        let totalLabScore1 = WBC + neutrophil + bloodGlucose + urineNitrites + urineBlood + anionGap
      
        return Double(totalLabScore1);
    }
    
    func totalLabScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        arrayDayWiseScoreTotal = []
        
        var iDiseaseLab:[Metrix] = []
        
        /*iDiseaseLab.append(contentsOf: bunData)
        iDiseaseLab.append(contentsOf: creatinineData)
        iDiseaseLab.append(contentsOf: bloodGlucoseData)
        iDiseaseLab.append(contentsOf: carbonDioxideData)
        iDiseaseLab.append(contentsOf: potassiumLevelData)
        iDiseaseLab.append(contentsOf: calciumData)
        iDiseaseLab.append(contentsOf: chlorideData)
        iDiseaseLab.append(contentsOf: albuminData)
        iDiseaseLab.append(contentsOf: anionGapData)
        iDiseaseLab.append(contentsOf: hemaglobinData)
        iDiseaseLab.append(contentsOf: microalbuminData)
        iDiseaseLab.append(contentsOf: eGFRData)*/
        
        arrayDayWiseScoreTotal = daywiseFilterMetrixsData(days: days, array: iDiseaseLab, metriXType: MetricsType.LabData)
        iDiseaseLab = []
        
        return arrayDayWiseScoreTotal
    }
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[LabModel]{
        
        let objModel = AcuityMetricsDetailViewModel()
        return objModel.getLabData()
        
    }
}
