//
//  AcuityMainViewModel.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 01/03/21.
//

import Foundation

class AcuityMainViewModel: NSObject {
    
    func getExpandedViewHeight(expandedViewHeight:CGFloat,headerViewHeight:CGFloat) -> CGFloat {
        if UIDevice.current.hasNotch {
            return expandedViewHeight - headerViewHeight
        } else {
            return expandedViewHeight - headerViewHeight + 20
        }
       
       
    }
    
    
    //MARK: Default system data...
    
    func setupBodySystemData()->[[String:Any]] {
        var arrBodySystems:[[String:Any]] = []
        
        let metricCardio = CardioManager.sharedManager.cardioData.dictionaryRepresentation()
        let metricTemp = [MetricsType.Conditions.rawValue:CardioManager.sharedManager.cardioData.cardioCondition.dictionaryRepresentation(),MetricsType.Sympotms.rawValue:[],MetricsType.LabData.rawValue:CardioManager.sharedManager.cardioData.cardioLab.dictionaryRepresentation(),MetricsType.Vitals.rawValue:[]] as [String : Any]
        
        let dictCardiovascular =   AcuityDisplayModel()
        dictCardiovascular.id = "0"
        dictCardiovascular.name = SystemName.Cardiovascular
        dictCardiovascular.score = String(format: "%.2f", (CardioManager.sharedManager.cardioData.cardioSystemScore))
        //dictCardiovascular.index = "89"
        dictCardiovascular.image = AcuityImages.kCardiovascular
        dictCardiovascular.metricCardio = metricCardio
        
        let metricRespiratory = RespiratoryManager.sharedManager.respiratoryData.dictionaryRepresentation()
        let dictRespiratory =   AcuityDisplayModel()
        dictRespiratory.id = "15"
        dictRespiratory.name = SystemName.Respiratory
        dictRespiratory.score = String(format: "%.2f", (RespiratoryManager.sharedManager.respiratoryData.respiratorySystemScore))
        //dictRespiratory.index = "23"
        dictRespiratory.image = AcuityImages.kRespiratory
        dictRespiratory.metricCardio = metricRespiratory
        
        let dictRenal =   AcuityDisplayModel()
        dictRenal.id = "20"
        dictRenal.name = SystemName.Renal
        dictRenal.score = "84"
        //dictRespiratory.index = "23"
        dictRenal.image = AcuityImages.kRenal
        dictRenal.metricCardio = metricTemp
        
        
        let dictGastrointestinal =   AcuityDisplayModel()
        dictGastrointestinal.id = "45"
        dictGastrointestinal.name = SystemName.Gastrointestinal
        dictGastrointestinal.score = "84"
        //dictGastrointestinal.index = "38"
        dictGastrointestinal.image = AcuityImages.kGastrointestinal
        dictGastrointestinal.metricCardio = metricTemp
        
        let dictGenitourinary =   AcuityDisplayModel()
        dictGenitourinary.id = "32"
        dictGenitourinary.name = SystemName.Genitourinary
        dictGenitourinary.score = "29"
        //dictGenitourinary.index = "98"
        dictGenitourinary.image = AcuityImages.kGenitourinary
        dictGenitourinary.metricCardio = metricTemp
        
        let dictEndocrine =   AcuityDisplayModel()
        dictEndocrine.id = "46"
        dictEndocrine.name = SystemName.Endocrine
        dictEndocrine.score = "89"
        //dictEndocrine.index = "90"
        dictEndocrine.image = AcuityImages.kEndocrine
        dictEndocrine.metricCardio = metricTemp
        
        let dictNuerological =   AcuityDisplayModel()
        dictNuerological.id = "78"
        dictNuerological.name = SystemName.Nuerological
        dictNuerological.score = "56"
        //dictNuerological.index = "82"
        dictNuerological.image = AcuityImages.kNuerological
        dictNuerological.metricCardio = metricTemp
        
        let dictHaematology =   AcuityDisplayModel()
        dictHaematology.id = "36"
        dictHaematology.name = SystemName.Haematology
        dictHaematology.score = "91"
        //dictHaematology.index = "91"
        dictHaematology.image = AcuityImages.kHematology
        dictHaematology.metricCardio = metricTemp
        
        
        let dictMusculatory =   AcuityDisplayModel()
        dictMusculatory.id = "23"
        dictMusculatory.name = SystemName.Musculatory
        dictMusculatory.score = "68"
        //dictMusculatory.index = "68"
        dictMusculatory.image = AcuityImages.kMusculatory
        dictMusculatory.metricCardio = metricTemp
        
        
        let dictIntegumentary =   AcuityDisplayModel()
        dictIntegumentary.id = "89"
        dictIntegumentary.name = SystemName.Integumentary
        dictIntegumentary.score = "90"
        //dictIntegumentary.index = "92"
        dictIntegumentary.image = AcuityImages.kIntegumentary
        dictIntegumentary.metricCardio = metricTemp
        
        let dictFluids =   AcuityDisplayModel()
        dictFluids.id = "432"
        dictFluids.name = SystemName.Fluids
        dictFluids.score = "74"
        //dictFluids.index = "74"
        dictFluids.image = AcuityImages.kFluids
        dictFluids.metricCardio = metricTemp
        
        let dictInfectious =   AcuityDisplayModel()
        dictInfectious.id = "98"
        dictInfectious.name = SystemName.InfectiousDisease
        dictInfectious.score = "98"
        //dictInfectious.index = "98"
        dictInfectious.image = AcuityImages.kIDs
        dictInfectious.metricCardio = metricTemp
        
        let dictDisposition =   AcuityDisplayModel()
        dictDisposition.id = "248"
        dictDisposition.name = SystemName.SocialDeterminantsofHealth
        dictDisposition.score = "84"
        //dictDisposition.index = "84"
        dictDisposition.image = AcuityImages.kDisposition
        dictDisposition.metricCardio = metricTemp
        
        let dictHeent =   AcuityDisplayModel()
        dictHeent.id = "111"
        dictHeent.name = SystemName.Heent
        dictHeent.score = "78"
        //dictHeent.index = "78"
        dictHeent.image = AcuityImages.kHeent
        dictHeent.metricCardio = metricTemp
        
        arrBodySystems.append(dictCardiovascular.dictionaryRepresentation())
        arrBodySystems.append(dictRespiratory.dictionaryRepresentation())
        arrBodySystems.append(dictRenal.dictionaryRepresentation())
        arrBodySystems.append(dictGastrointestinal.dictionaryRepresentation())
        arrBodySystems.append(dictGenitourinary.dictionaryRepresentation())
        arrBodySystems.append(dictEndocrine.dictionaryRepresentation())
        arrBodySystems.append(dictNuerological.dictionaryRepresentation())
        
        arrBodySystems.append(dictHaematology.dictionaryRepresentation())
        arrBodySystems.append(dictHeent.dictionaryRepresentation())
        arrBodySystems.append(dictDisposition.dictionaryRepresentation())
        arrBodySystems.append(dictInfectious.dictionaryRepresentation())
        arrBodySystems.append(dictFluids.dictionaryRepresentation())
        
        arrBodySystems.append(dictIntegumentary.dictionaryRepresentation())
        arrBodySystems.append(dictMusculatory.dictionaryRepresentation())
        
        
        return arrBodySystems
    }
    
    
    func arrayIndexFromBodySystem(bodyStystem:[[String:Any]],andAcuityId acuityId:String) -> Int{
        for i in 0..<bodyStystem.count {
            let item = bodyStystem[i]
            if acuityId==item["id"] as? String{
                return i
            }
        }
        return 0;
    }
    
    //MARK: Return sorted data array...
    func returnSortedArrayUsingIndexandSequence(bodySystemArray:[[String:Any]]) -> [[String:Any]] {
        var redColorElememnts : [[String:Any]] = []
        var yellowColorElememnts : [[String:Any]] = []
        var greenColorElememnts : [[String:Any]] = []
        
        for item in bodySystemArray{
            let indexValue = Int(item["score"] as! String) ?? 0
            if indexValue  > 0 && indexValue <= 75{
                redColorElememnts.append(item)
            }else if indexValue  > 75 && indexValue <= 85{
                yellowColorElememnts.append(item)
            }else{
                greenColorElememnts.append(item)
            }
        }
        var finalArray: [[String:Any]] = []
        finalArray.append(contentsOf: redColorElememnts)
        finalArray.append(contentsOf: yellowColorElememnts)
        finalArray.append(contentsOf: greenColorElememnts)
        return finalArray
    }
    
}
