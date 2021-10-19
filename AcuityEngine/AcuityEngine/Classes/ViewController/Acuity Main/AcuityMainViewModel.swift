//
//  AcuityMainViewModel.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 01/03/21.
//

import Foundation

class AcuityMainViewModel: NSObject {
    
   
    var leadingMyWellConstraint,topMyWellConstraint,centerMyWellConstraint,lblScoreCenterConstraint,lblScoreTopConstraint,lblScoreBottomConstraint,lblScoreTextLeadingConstraint,lblScoreTextBottomConstraint: NSLayoutConstraint?
    
    var traillingMyWellConstraint,lblScoreTextCenterConstraint: NSLayoutConstraint?
    var isAnimationConstraintAdded: Bool = false
    
    func getExpandedViewHeight(expandedViewHeight:CGFloat,headerViewHeight:CGFloat) -> CGFloat {
        if UIDevice.current.hasNotch {
            return expandedViewHeight - headerViewHeight
        } else {
            return expandedViewHeight - headerViewHeight + 20
        }
        
        
    }
    func removeMainScoreViewConstraintWhenaProfileOrAddClick(mainScoreView:UIView,lblMyWell:UILabel,lblScoreText:UILabel,lblScore:UILabel,viewHeight:CGFloat){
        mainScoreView.removeConstraint(leadingMyWellConstraint!)
        mainScoreView.removeConstraint(topMyWellConstraint!)
        mainScoreView.removeConstraint(centerMyWellConstraint!)
        
        mainScoreView.removeConstraint(lblScoreCenterConstraint!)
        mainScoreView.removeConstraint(lblScoreTopConstraint!)
        mainScoreView.removeConstraint(lblScoreBottomConstraint!)
        
        mainScoreView.removeConstraint(lblScoreTextLeadingConstraint!)
        mainScoreView.removeConstraint(lblScoreTextBottomConstraint!)
//        if isAnimationConstraintAdded {
//        mainScoreView.removeConstraint(traillingMyWellConstraint!)
//        mainScoreView.removeConstraint(lblScoreTextCenterConstraint!)
//        mainScoreView.removeConstraint(lblScoreTextLeadingConstraint!)
//        }
    }
    func setTopLabel(mainScoreView:UIView,lblMyWell:UILabel,lblScoreText:UILabel,lblScore:UILabel,viewHeight:CGFloat){
        
        if isAnimationConstraintAdded {
            mainScoreView.removeConstraint(traillingMyWellConstraint!)
            mainScoreView.removeConstraint(lblScoreTextCenterConstraint!)
            mainScoreView.removeConstraint(lblScoreTextLeadingConstraint!)
            isAnimationConstraintAdded = false
        }
        
       // UIView.animateKeyframes(withDuration: 0.7, delay: 0.0, options: .calculationModeLinear) { [self] in
        UIView.animateKeyframes(withDuration: 0.7, delay: 0.0, options: .calculationModeLinear)  { [self] in
            
            mainScoreView.backgroundColor = .red
            lblMyWell.backgroundColor = .black
            lblScoreText.backgroundColor = .black
            lblScore.backgroundColor = .black
            
            lblMyWell.font = lblMyWell.font.withSize(viewHeight * 0.046) //UIFont.systemFont(ofSize: 26, weight: .semibold)
            
            lblScoreText.font = lblScoreText.font.withSize(viewHeight * 0.046)
                //UIFont.systemFont(ofSize: 32, weight: .semibold)
           
            lblScore.font = lblScore.font.withSize(viewHeight * 0.046 + 12)
                //UIFont.systemFont(ofSize: 32, weight: .semibold)
            
            
            lblMyWell.translatesAutoresizingMaskIntoConstraints = false
            lblScore.translatesAutoresizingMaskIntoConstraints = false
            lblScoreText.translatesAutoresizingMaskIntoConstraints = false
            
            let margins = mainScoreView.layoutMarginsGuide
            
            
            leadingMyWellConstraint = lblMyWell.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20)
            topMyWellConstraint = lblMyWell.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0)
            centerMyWellConstraint = lblMyWell.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0)
            
            lblScoreCenterConstraint = lblScore.centerXAnchor.constraint(equalTo: lblMyWell.centerXAnchor, constant: 0)
            lblScoreTopConstraint = lblScore.topAnchor.constraint(equalTo: lblMyWell.bottomAnchor, constant: 0)
            lblScoreBottomConstraint = lblScore.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0)
            
            lblScoreTextLeadingConstraint = lblScoreText.leadingAnchor.constraint(equalTo: lblScore.trailingAnchor, constant: 4)
            lblScoreTextBottomConstraint = lblScoreText.bottomAnchor.constraint(equalTo: lblScore.bottomAnchor, constant: 0)
            
            mainScoreView.addConstraint(leadingMyWellConstraint!)
            mainScoreView.addConstraint(topMyWellConstraint!)
            mainScoreView.addConstraint(centerMyWellConstraint!)
            
            mainScoreView.addConstraint(lblScoreCenterConstraint!)
            mainScoreView.addConstraint(lblScoreTopConstraint!)
            mainScoreView.addConstraint(lblScoreBottomConstraint!)
            
            mainScoreView.addConstraint(lblScoreTextLeadingConstraint!)
            mainScoreView.addConstraint(lblScoreTextBottomConstraint!)
            
            mainScoreView.layoutIfNeeded()
        } completion: { [self] (isSuccess) in
            
            
        }
    }
    
    func setTopLabelAnimation(mainScoreView:UIView,lblMyWell:UILabel,lblScoreText:UILabel,lblScore:UILabel,viewHeight:CGFloat) {
        UIView.animateKeyframes(withDuration: 0.7, delay: 0.00, options: .calculationModeLinear) { [self] in
            isAnimationConstraintAdded = true
            lblMyWell.font = lblMyWell.font.withSize(viewHeight * 0.046)
            lblScoreText.font = lblScoreText.font.withSize(viewHeight * 0.046)
            lblScore.font = lblScore.font.withSize(viewHeight * 0.046)
            
            mainScoreView.removeConstraint(leadingMyWellConstraint!)
            mainScoreView.removeConstraint(topMyWellConstraint!)
            mainScoreView.removeConstraint(centerMyWellConstraint!)
            
            mainScoreView.removeConstraint(lblScoreCenterConstraint!)
            mainScoreView.removeConstraint(lblScoreTopConstraint!)
            mainScoreView.removeConstraint(lblScoreBottomConstraint!)
            
            mainScoreView.removeConstraint(lblScoreTextLeadingConstraint!)
            mainScoreView.removeConstraint(lblScoreTextBottomConstraint!)
            
            lblMyWell.translatesAutoresizingMaskIntoConstraints = false
            lblScore.translatesAutoresizingMaskIntoConstraints = false
            lblScoreText.translatesAutoresizingMaskIntoConstraints = false
            
            let margins = mainScoreView.layoutMarginsGuide
            
            traillingMyWellConstraint = lblMyWell.trailingAnchor.constraint(equalTo: lblScoreText.leadingAnchor, constant: -4)
            
            lblScoreTextCenterConstraint = lblScoreText.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 20)
            
            lblScoreTextLeadingConstraint = lblScore.leadingAnchor.constraint(equalTo: lblScoreText.trailingAnchor, constant: 4)
            
            mainScoreView.addConstraint(traillingMyWellConstraint!)
            mainScoreView.addConstraint(lblScoreTextCenterConstraint!)
            mainScoreView.addConstraint(lblScoreTextLeadingConstraint!)
            
            mainScoreView.layoutIfNeeded()
        }
        /*UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: .calculationModeLinear) { [self] in
            isAnimationConstraintAdded = true
            lblMyWell.font = lblMyWell.font.withSize(viewHeight * 0.046)
            lblScoreText.font = lblScoreText.font.withSize(viewHeight * 0.046)
            lblScore.font = lblScore.font.withSize(viewHeight * 0.046)
            
            mainScoreView.removeConstraint(leadingMyWellConstraint!)
            mainScoreView.removeConstraint(topMyWellConstraint!)
            mainScoreView.removeConstraint(centerMyWellConstraint!)
            
            mainScoreView.removeConstraint(lblScoreCenterConstraint!)
            mainScoreView.removeConstraint(lblScoreTopConstraint!)
            mainScoreView.removeConstraint(lblScoreBottomConstraint!)
            
            mainScoreView.removeConstraint(lblScoreTextLeadingConstraint!)
            mainScoreView.removeConstraint(lblScoreTextBottomConstraint!)
            
            lblMyWell.translatesAutoresizingMaskIntoConstraints = false
            lblScore.translatesAutoresizingMaskIntoConstraints = false
            lblScoreText.translatesAutoresizingMaskIntoConstraints = false
            
            let margins = mainScoreView.layoutMarginsGuide
            
            
            traillingMyWellConstraint = lblMyWell.trailingAnchor.constraint(equalTo: lblScoreText.leadingAnchor, constant: -4)
            
            lblScoreTextCenterConstraint = lblScoreText.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 30)
            
            lblScoreTextLeadingConstraint = lblScore.leadingAnchor.constraint(equalTo: lblScoreText.trailingAnchor, constant: 4)
            topMyWellConstraint = lblMyWell.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20)
     
            mainScoreView.addConstraint(traillingMyWellConstraint!)
            mainScoreView.addConstraint(lblScoreTextCenterConstraint!)
            mainScoreView.addConstraint(lblScoreTextLeadingConstraint!)
            
            mainScoreView.layoutIfNeeded()
        } completion: { [self] (isSuccess) in
            
            
        }*/
    }
    func setupBodySystemData()->[[String:Any]] {
        var arrBodySystems:[[String:Any]] = []
        
        let metricDictionary = CardioManager.sharedManager.cardioData.dictionaryRepresentation()
        
        let dictCardiovascular =   AcuityDisplayModel()
        dictCardiovascular.id = SystemId.Id_Cardiovascular
        dictCardiovascular.name = SystemName.Cardiovascular
        dictCardiovascular.score = String(format: "%.2f", (CardioManager.sharedManager.cardioData.cardioSystemScore))
        //dictCardiovascular.index = "89"
        dictCardiovascular.image = AcuityImages.kCardiovascular
        dictCardiovascular.metricDictionary = metricDictionary
        
        let metricRespiratory = RespiratoryManager.sharedManager.respiratoryData.dictionaryRepresentation()
        let dictRespiratory =   AcuityDisplayModel()
        dictRespiratory.id = SystemId.Id_Respiratory
        dictRespiratory.name = SystemName.Respiratory
        dictRespiratory.score = String(format: "%.2f", (RespiratoryManager.sharedManager.respiratoryData.respiratorySystemScore))
        //dictRespiratory.index = "23"
        dictRespiratory.image = AcuityImages.kRespiratory
        dictRespiratory.metricDictionary = metricRespiratory
        
        let metricRenal = RenalManager.sharedManager.renalData.dictionaryRepresentation()
        let dictRenal =   AcuityDisplayModel()
        dictRenal.id = SystemId.Id_Renal
        dictRenal.name = SystemName.Renal
        dictRenal.score = String(format: "%.2f", (RenalManager.sharedManager.renalData.renalSystemScore))
        //dictRespiratory.index = "23"
        dictRenal.image = AcuityImages.kRenal
        dictRenal.metricDictionary = metricRenal
        
        let metriciDisease = IDiseaseManager.sharedManager.iDiseaseData.dictionaryRepresentation()
        let dictInfectious =   AcuityDisplayModel()
        dictInfectious.id = SystemId.Id_InfectiousDisease
        dictInfectious.name = SystemName.InfectiousDisease
        dictInfectious.score = String(format: "%.2f", (IDiseaseManager.sharedManager.iDiseaseData.iDiseaseSystemScore))
        //dictInfectious.index = "98"
        dictInfectious.image = AcuityImages.kIDs
        dictInfectious.metricDictionary = metriciDisease
        
        //FNE
        let metricFNE = FNEManager.sharedManager.fneData.dictionaryRepresentation()
        let dictFluids =   AcuityDisplayModel()
        dictFluids.id = SystemId.Id_Fluids
        dictFluids.name = SystemName.Fluids
        dictFluids.score = String(format: "%.2f", (FNEManager.sharedManager.fneData.fneSystemScore))
        //dictFluids.index = "74"
        dictFluids.image = AcuityImages.kFluids
        dictFluids.metricDictionary = metricFNE
        
        //Hematology
        let metricHematology = HematoManager.sharedManager.hematoData.dictionaryRepresentation()
        let dictHematology =   AcuityDisplayModel()
        dictHematology.id = SystemId.Id_Hematology
        dictHematology.name = SystemName.Hematology
        dictHematology.score = String(format: "%.2f", (HematoManager.sharedManager.hematoData.hematoSystemScore))
        //dictHematology.index = "91"
        dictHematology.image = AcuityImages.kHematology
        dictHematology.metricDictionary = metricHematology
        
        //Endocrine
        let metricEndocrine = EndocrineManager.sharedManager.endocrineData.dictionaryRepresentation()
        let dictEndocrine =   AcuityDisplayModel()
        dictEndocrine.id = SystemId.Id_Endocrine
        dictEndocrine.name = SystemName.Endocrine
        dictEndocrine.score = String(format: "%.2f", (EndocrineManager.sharedManager.endocrineData.endocrineSystemScore))
        //dictEndocrine.index = "90"
        dictEndocrine.image = AcuityImages.kEndocrine
        dictEndocrine.metricDictionary = metricEndocrine
        
        //Gastrointestinal
        let metricGastrointestinal = GastrointestinalManager.sharedManager.gastrointestinalData.dictionaryRepresentation()
        let dictGastrointestinal =   AcuityDisplayModel()
        dictGastrointestinal.id = SystemId.Id_Gastrointestinal
        dictGastrointestinal.name = SystemName.Gastrointestinal
        dictGastrointestinal.score = String(format: "%.2f", (GastrointestinalManager.sharedManager.gastrointestinalData.gastrointestinalSystemScore))
        //dictGastrointestinal.index = "38"
        dictGastrointestinal.image = AcuityImages.kGastrointestinal
        dictGastrointestinal.metricDictionary = metricGastrointestinal
        
        //Gastrointestinal
        let metricGenitourinary = GenitourinaryManager.sharedManager.genitourinaryData.dictionaryRepresentation()
        let dictGenitourinary =   AcuityDisplayModel()
        dictGenitourinary.id = SystemId.Id_Genitourinary
        dictGenitourinary.name = SystemName.Genitourinary
        dictGenitourinary.score = String(format: "%.2f", (GenitourinaryManager.sharedManager.genitourinaryData.genitourinarySystemScore))
        //dictGenitourinary.index = "98"
        dictGenitourinary.image = AcuityImages.kGenitourinary
        dictGenitourinary.metricDictionary = metricGenitourinary
        
        //Neuro
        let metricNeuro = NeuroManager.sharedManager.neuroData.dictionaryRepresentation()
        let dictNuerological =   AcuityDisplayModel()
        dictNuerological.id = SystemId.Id_Nuerological
        dictNuerological.name = SystemName.Nuerological
        dictNuerological.score = String(format: "%.2f", (NeuroManager.sharedManager.neuroData.neuroSystemScore))
        //dictNuerological.index = "82"
        dictNuerological.image = AcuityImages.kNuerological
        dictNuerological.metricDictionary = metricNeuro
        
        //Musc
        let metricMusc = MuscManager.sharedManager.muscData.dictionaryRepresentation()
        let dictMusculatory =   AcuityDisplayModel()
        dictMusculatory.id = SystemId.Id_Musculatory
        dictMusculatory.name = SystemName.Musculatory
        dictMusculatory.score = String(format: "%.2f", (MuscManager.sharedManager.muscData.muscSystemScore))
        //dictMusculatory.index = "68"
        dictMusculatory.image = AcuityImages.kMusculatory
        dictMusculatory.metricDictionary = metricMusc
        
        //Skin
        let metricSkin = SkinManager.sharedManager.skinData.dictionaryRepresentation()
        let dictIntegumentary =   AcuityDisplayModel()
        dictIntegumentary.id = SystemId.Id_Integumentary
        dictIntegumentary.name = SystemName.Integumentary
        dictIntegumentary.score = String(format: "%.2f", (SkinManager.sharedManager.skinData.skinSystemScore))
        //dictIntegumentary.index = "92"
        dictIntegumentary.image = AcuityImages.kIntegumentary
        dictIntegumentary.metricDictionary = metricSkin
        
        //SDH
        let metricSDH = SDHManager.sharedManager.sdhData.dictionaryRepresentation()
        let dictSDH =   AcuityDisplayModel()
        dictSDH.id = SystemId.Id_SocialDeterminantsofHealth
        dictSDH.name = SystemName.SocialDeterminantsofHealth
        dictSDH.score = String(format: "%.2f", (SDHManager.sharedManager.sdhData.sdhSystemScore))
        //dictSDH.index = "84"
        dictSDH.image = AcuityImages.kSDH
        dictSDH.metricDictionary = metricSDH
        
        //Heent
        let metricHeent = HeentManager.sharedManager.heentData.dictionaryRepresentation()
        let dictHeent =   AcuityDisplayModel()
        dictHeent.id = SystemId.Id_Heent
        dictHeent.name = SystemName.Heent
        dictHeent.score = String(format: "%.2f", (HeentManager.sharedManager.heentData.heentSystemScore))
        //dictHeent.index = "78"
        dictHeent.image = AcuityImages.kHeent
        dictHeent.metricDictionary = metricHeent
        
        //MyWellScore
        let metricMyWellScore = MyWellScore.sharedManager.dictionaryOfSystemScore
        let dictMyWellScore =   AcuityDisplayModel()
        dictMyWellScore.id = SystemId.Id_MyWellScore
        dictMyWellScore.name = SystemName.MyWellScore
        dictMyWellScore.score = String(format: "%.2f", (MyWellScore.sharedManager.myWellScore))
        //dictHeent.index = "78"
        dictMyWellScore.image = AcuityImages.kMyWellScore
        dictMyWellScore.myWellScoreDataDictionary = metricMyWellScore
        
        arrBodySystems.append(dictCardiovascular.dictionaryRepresentation())
        arrBodySystems.append(dictRespiratory.dictionaryRepresentation())
        arrBodySystems.append(dictRenal.dictionaryRepresentation())
        arrBodySystems.append(dictInfectious.dictionaryRepresentation())
        arrBodySystems.append(dictFluids.dictionaryRepresentation())
        
        arrBodySystems.append(dictHematology.dictionaryRepresentation())
        arrBodySystems.append(dictEndocrine.dictionaryRepresentation())
        arrBodySystems.append(dictGastrointestinal.dictionaryRepresentation())
        arrBodySystems.append(dictGenitourinary.dictionaryRepresentation())
        arrBodySystems.append(dictNuerological.dictionaryRepresentation())
        
        arrBodySystems.append(dictMusculatory.dictionaryRepresentation())
        arrBodySystems.append(dictIntegumentary.dictionaryRepresentation())
        arrBodySystems.append(dictHeent.dictionaryRepresentation())
        arrBodySystems.append(dictSDH.dictionaryRepresentation())
        arrBodySystems.append(dictMyWellScore.dictionaryRepresentation())
        
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
    func sortDictionaryDataBasedOnScore(bodySystemArray:[[String:Any]]) -> [[String:Any]] {
        
        var redColorElememnts : [[String:Any]] = []
        var yellowColorElememnts : [[String:Any]] = []
        var greenColorElememnts : [[String:Any]] = []
 
        for item in bodySystemArray{
            let indexValue =  Double(item["score"] as? String ?? "") ?? 0
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
    
    func returnSortedArrayUsingIndexandSequence(bodySystemArray:[[String:Any]]) -> [[String:Any]] {
      
        var filterdBodySystemArray = bodySystemArray
        var finalArray: [[String:Any]] = []
        /*let filterMyWellData:[[String:Any]] = bodySystemArray.filter { $0["id"] as? String != SystemId.Id_MyWellScore}
        if let index = bodySystemArray.firstIndex(where: {$0["id"] as? String != SystemId.Id_MyWellScore}) {
            filterdBodySystemArray.remove(at: index)
        }
        if filterMyWellData.count > 0
        {
            finalArray.append(filterMyWellData.first!)
        }*/
        finalArray = sortDictionaryDataBasedOnScore(bodySystemArray: filterdBodySystemArray)
       
        return finalArray
    }
}
