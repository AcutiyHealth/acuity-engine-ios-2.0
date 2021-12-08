//
//  File.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 27/04/21.
//

import Foundation

class AcuityDetailPullUpViewModel: NSObject
{
    
    func setBackGroundColorFor(viewSymptom:UIView,viewCondition:UIView,viewVital:UIView,viewLab:UIView){
        self.setBackgroundColorForMetricsView(view: viewCondition)
        self.setBackgroundColorForMetricsView(view: viewVital)
        self.setBackgroundColorForMetricsView(view: viewSymptom)
        self.setBackgroundColorForMetricsView(view: viewLab)
    }
    
    //MARK: Set background view of Conditions,lab,symptoms and vital
    func setBackgroundColorForMetricsView(view:UIView){
        view.layer.cornerRadius = 5;
        view.backgroundColor = ColorSchema.fourBoxColorInPullup
    }
    //MARK: Make view of Conditions,lab,symptoms and vital selected
    func setBackgroundColorWhenViewSelcted(view:UIView){
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1;
    }
    
    //MARK: Make view of Conditions,lab,symptoms and vital unselected
    func setBackgroundColorWhenViewUnSelcted(viewSymptom:UIView,viewCondition:UIView,viewVital:UIView,viewLab:UIView){
        viewLab.layer.borderWidth = 0;
        viewVital.layer.borderWidth = 0;
        viewSymptom.layer.borderWidth = 0;
        viewCondition.layer.borderWidth = 0;
    }
    
    func prepareArrayFromAcuityModel(systemMetricsData:[String:Any]?)->([ConditionsModel],[SymptomsModel],[VitalsModel],[LabModel]){
        //generate array of conditions,lab,vital,symptoms
        var arrConditions:[ConditionsModel] = []
        var arrSymptoms:[SymptomsModel] = []
        //var arrMedications:[MedicationDataDisplayModel] = []
        var arrLabs:[LabModel] = []
        var arrVitals:[VitalsModel] = []
        guard let arrCondition = systemMetricsData?[MetricsType.Conditions.rawValue] as? [ConditionsModel] else {
            return (arrConditions,arrSymptoms,arrVitals,arrLabs)
        }
        //arrMedications = self.fetchMedicationData() as [MedicationDataDisplayModel]
        
        guard let arrSymptom = systemMetricsData?[MetricsType.Sympotms.rawValue] as? [SymptomsModel] else {
            return (arrConditions,arrSymptoms,arrVitals,arrLabs)
        }
        guard let arrLab = systemMetricsData?[MetricsType.LabData.rawValue] as? [LabModel] else {
            return (arrConditions,arrSymptoms,arrVitals,arrLabs)
        }
        guard let arrVital = systemMetricsData?[MetricsType.Vitals.rawValue] as? [VitalsModel] else {
            return (arrConditions,arrSymptoms,arrVitals,arrLabs)
        }
        
        let sortArrayTupple = self.sortArrayColorWise(arrConditions: arrCondition, arrVitals: arrVital, arrSymptoms: arrSymptom, arrLabs: arrLab)
        
        arrConditions = sortArrayTupple.0
        arrSymptoms = sortArrayTupple.1
        arrVitals = sortArrayTupple.2
        arrLabs = sortArrayTupple.3
        
        /*//Sorting of array...
         arrConditions.sort {
         $0.title ?? "" < $1.title ?? ""
         }
         arrVitals.sort {
         $0.title ?? "" < $1.title ?? ""
         }
         
         arrSymptoms.sort {
         $0.title ?? "" < $1.title ?? ""
         }
         arrLabs.sort {
         $0.title ?? "" < $1.title ?? ""
         }*/
        
        return (arrConditions,arrSymptoms,arrVitals,arrLabs)
    }
    
    func sortArrayColorWise(arrConditions:[ConditionsModel],arrVitals:[VitalsModel],arrSymptoms:[SymptomsModel],arrLabs:[LabModel])->([ConditionsModel],[SymptomsModel],[VitalsModel],[LabModel]){
        
        var mutableArrSymptoms:[SymptomsModel] = []
        var mutableArrVitals:[VitalsModel] = []
        var mutableArrCondition:[ConditionsModel] = []
        var mutableArrLabs:[LabModel] = []
        
        //Conditions..
        let redColorArray = arrConditions.filter { model in
            model.color == ChartColor.REDCOLOR
        }
        let yellowColorArray = arrConditions.filter { model in
            model.color == ChartColor.YELLOWCOLOR
        }
        let greenColorArray = arrConditions.filter { model in
            model.color == ChartColor.GREENCOLOR
        }
        mutableArrCondition.append(contentsOf: redColorArray)
        mutableArrCondition.append(contentsOf: yellowColorArray)
        mutableArrCondition.append(contentsOf: greenColorArray)
        
        //Symptoms..
        let redColorarrSymptoms = arrSymptoms.filter { model in
            model.color == ChartColor.REDCOLOR
        }
        let yellowColorarrSymptoms = arrSymptoms.filter { model in
            model.color == ChartColor.YELLOWCOLOR
        }
        let greenColorarrSymptoms = arrSymptoms.filter { model in
            model.color == ChartColor.GREENCOLOR
        }
        mutableArrSymptoms.append(contentsOf: redColorarrSymptoms)
        mutableArrSymptoms.append(contentsOf: yellowColorarrSymptoms)
        mutableArrSymptoms.append(contentsOf: greenColorarrSymptoms)
        
        //Vitals...
        let redColorarrVitals:[VitalsModel] = arrVitals.filter { model in
            model.color == ChartColor.REDCOLOR
        }
        let yellowColorarrVitals = arrVitals.filter { model in
            model.color == ChartColor.YELLOWCOLOR
        }
        let greenColorarrVitals = arrVitals.filter { model in
            model.color == ChartColor.GREENCOLOR
        }
        mutableArrVitals.append(contentsOf: redColorarrVitals)
        mutableArrVitals.append(contentsOf: yellowColorarrVitals)
        mutableArrVitals.append(contentsOf: greenColorarrVitals)
        
        
        //labs..
        let redColorarrLabs = arrLabs.filter { model in
            model.color == ChartColor.REDCOLOR
        }
        let yellowColorarrLabs = arrLabs.filter { model in
            model.color == ChartColor.YELLOWCOLOR
        }
        let greenColorarrLabs = arrLabs.filter { model in
            model.color == ChartColor.GREENCOLOR
        }
        mutableArrLabs.append(contentsOf: redColorarrLabs)
        mutableArrLabs.append(contentsOf: yellowColorarrLabs)
        mutableArrLabs.append(contentsOf: greenColorarrLabs)
        
        return (mutableArrCondition,mutableArrSymptoms,mutableArrVitals,mutableArrLabs)
        
    }
    func setUpSegmentControl(segmentControl:UISegmentedControl){
        segmentControl.setTitle(SegmentValueForGraph.SevenDays.rawValue, forSegmentAt: 0)
        segmentControl.setTitle(SegmentValueForGraph.ThirtyDays.rawValue, forSegmentAt: 1)
        segmentControl.setTitle(SegmentValueForGraph.ThreeMonths.rawValue, forSegmentAt: 2)
        segmentControl.defaultConfiguration(font: Fonts.kAcuityDetailSegmentFont, color: UIColor.white)
        segmentControl.selectedConfiguration(font: Fonts.kAcuityDetailSegmentFont, color: UIColor.black)
        segmentControl.selectedSegmentIndex = 0
        //self.segmentClicked(segmentControl)
    }
    
    func prepareAcuityModelFromSystemData(systemData:[String:Any])->AcuityDisplayModel{
        let acuityModel = AcuityDisplayModel()
        acuityModel.id = systemData[Keys.kAcuityId] as? String
        acuityModel.name = SystemName(rawValue: systemData[Keys.kSystemName] as! String )
        acuityModel.score = systemData[Keys.kScore]  as? String ?? ""
        acuityModel.image = systemData[Keys.kImage]  as? String ?? ""
        acuityModel.metricDictionary = systemData[Keys.kMetricDictionary] as? [String:Any]
        acuityModel.myWellScoreDataDictionary = systemData[Keys.kMyWellScoreDataDictionary] as? [[String:Double]]
        return acuityModel
    }
    func getScoreAndArrayOfSystemScore()->(String,[Double],[String:Any]){
        /*
         From this method, score for each system will be calculated for 7 days, 1 month and 3 months based upon selected segment.
         */
        var scoreText = String(format: "0.00")
        var arraySystemScore:[Double] = []
        var metricDictionary:[String:Any] = [:]
        print("<--------------------showScoreAndChartData-------------------->")
        switch MyWellScore.sharedManager.selectedSystem {
        case .Cardiovascular:
            do{
                let systemScore = CardioManager.sharedManager.cardioData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                //scoreText = String(format: "%.2f", systemScore)
                metricDictionary = CardioManager.sharedManager.cardioData.dictionaryRepresentation()
                arraySystemScore = CardioManager.sharedManager.cardioData.arrayDayWiseSystemScore
            }
        case .Respiratory:
            do{
                let systemScore = RespiratoryManager.sharedManager.respiratoryData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = RespiratoryManager.sharedManager.respiratoryData.dictionaryRepresentation()
                arraySystemScore = RespiratoryManager.sharedManager.respiratoryData.arrayDayWiseSystemScore
            }
        case .Renal:
            do{
                let systemScore = RenalManager.sharedManager.renalData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = RenalManager.sharedManager.renalData.dictionaryRepresentation()
                arraySystemScore = RenalManager.sharedManager.renalData.arrayDayWiseSystemScore
            }
        case .InfectiousDisease:
            do{
                let systemScore = IDiseaseManager.sharedManager.iDiseaseData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = IDiseaseManager.sharedManager.iDiseaseData.dictionaryRepresentation()
                arraySystemScore = IDiseaseManager.sharedManager.iDiseaseData.arrayDayWiseSystemScore
            }
        case .Fluids:
            do{
                let systemScore = FNEManager.sharedManager.fneData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = FNEManager.sharedManager.fneData.dictionaryRepresentation()
                arraySystemScore = FNEManager.sharedManager.fneData.arrayDayWiseSystemScore
            }
        case .Hematology:
            do{
                let systemScore = HematoManager.sharedManager.hematoData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = HematoManager.sharedManager.hematoData.dictionaryRepresentation()
                arraySystemScore = HematoManager.sharedManager.hematoData.arrayDayWiseSystemScore
            }
        case .Endocrine:
            do{
                let systemScore = EndocrineManager.sharedManager.endocrineData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = EndocrineManager.sharedManager.endocrineData.dictionaryRepresentation()
                arraySystemScore = EndocrineManager.sharedManager.endocrineData.arrayDayWiseSystemScore
            }
        case .Gastrointestinal:
            do{
                let systemScore = GastrointestinalManager.sharedManager.gastrointestinalData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = GastrointestinalManager.sharedManager.gastrointestinalData.dictionaryRepresentation()
                arraySystemScore = GastrointestinalManager.sharedManager.gastrointestinalData.arrayDayWiseSystemScore
            }
        case .Genitourinary:
            do{
                let systemScore = GenitourinaryManager.sharedManager.genitourinaryData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = GenitourinaryManager.sharedManager.genitourinaryData.dictionaryRepresentation()
                arraySystemScore = GenitourinaryManager.sharedManager.genitourinaryData.arrayDayWiseSystemScore
            }
        case .Nuerological:
            do{
                let systemScore = NeuroManager.sharedManager.neuroData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = NeuroManager.sharedManager.neuroData.dictionaryRepresentation()
                arraySystemScore = NeuroManager.sharedManager.neuroData.arrayDayWiseSystemScore
            }
        case .SocialDeterminantsofHealth:
            do{
                let systemScore = SDHManager.sharedManager.sdhData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = SDHManager.sharedManager.sdhData.dictionaryRepresentation()
                arraySystemScore = SDHManager.sharedManager.sdhData.arrayDayWiseSystemScore
            }
        case .Musculatory:
            do{
                let systemScore = MuscManager.sharedManager.muscData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = MuscManager.sharedManager.muscData.dictionaryRepresentation()
                arraySystemScore = MuscManager.sharedManager.muscData.arrayDayWiseSystemScore
            }
        case .Integumentary:
            do{
                let systemScore = SkinManager.sharedManager.skinData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = SkinManager.sharedManager.skinData.dictionaryRepresentation()
                arraySystemScore = SkinManager.sharedManager.skinData.arrayDayWiseSystemScore
            }
        case .Heent:
            do{
                let systemScore = HeentManager.sharedManager.heentData.totalSystemScoreWithDays(days: MyWellScore.sharedManager.daysToCalculateSystemScore)
                scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
                metricDictionary = HeentManager.sharedManager.heentData.dictionaryRepresentation()
                arraySystemScore = HeentManager.sharedManager.heentData.arrayDayWiseSystemScore
            }
            
        default:
            break
        }
        
        return (scoreText,arraySystemScore,metricDictionary)
        
    }
    func getScoreAndArrayOfSystemScoreForMyWellScore()->(String,[String],[[String:Any]]){
        /*
         From this method, score for each system will be calculated for 7 days, 1 month and 3 months based upon selected segment.
         */
        var scoreText = String(format: "0.00")
        var arraySystemScore:[String] = []
        var metricDictionary:[[String:Any]] = [[:]]
        
        let systemScore = MyWellScore.sharedManager.myWellScore
        scoreText = systemScore == 100 ? String(format: "%.0f", systemScore) : String(format: "%.2f", systemScore)
        //scoreText = String(format: "%.2f", systemScore)
        metricDictionary = MyWellScore.sharedManager.dictionaryOfSystemScore
        for dict in metricDictionary{
            if let score = dict[Keys.kScore]{
                arraySystemScore.append(score as? String ?? "")
            }
        }
        
        return (scoreText,arraySystemScore,metricDictionary)
    }
    func combineOtherEntriesFromListOfVitalsInArrayForDisplay(arrVital:[VitalsModel])->[VitalsModel]{
        var arrVitals:[VitalsModel] = arrVital
        let _ = vitalsArrayInConstant.map { vitalModel in
            if vitalModel.name == VitalsName.bloodPressure{
                vitalModel.name = VitalsName.bloodPressureSystolicDiastolic
            }
        }
        for model in vitalsArrayInConstant{
            print("model.name?.rawValue",model.name?.rawValue ?? "")
            
            let filteredArrVital =  arrVitals.filter { vitalModel in
                return model.name?.rawValue ?? "" == vitalModel.title ?? ""
            }
            if filteredArrVital.count <= 0{
                let modelForVitalsArrayObj = VitalsModel(title:  model.name?.rawValue ?? "", value: "--")
                arrVitals.append(modelForVitalsArrayObj)
            }
        }
        return arrVitals
    }
    //========================================================================================================
    //MARK: Combine Free Condition with Add Section Condition Data.
    //========================================================================================================
    func fetchFreeConditionDataAndCombineWithAddSectionCondition(arrConditions:[ConditionsModel])->[ConditionsModel]{
        var newArrConditions = arrConditions
        DBManager.shared.loadHisory(withID: OtherHistoryId.otherConditionsId.rawValue) { (success, historyData) in
            if success{
                //First convert otherConditions data to Condition Model...
                guard (historyData != nil) else {
                    return
                }
                for history in historyData!{
                    let conditionModel = ConditionsModel(title: history.txtValue ?? "", value: .Yes)
                    conditionModel.startTime = history.timeStamp ?? 0
                    //======= Append Free Condition With Current Condition Data ======//
                    newArrConditions.append(conditionModel)
                }
                
                //======= Sort Condition Array TimeStamp Wise ======//
                newArrConditions =  newArrConditions.sorted(by: { (model1, model2) -> Bool in
                    return model1.startTime > model2.startTime
                })
            }
        }
        return newArrConditions
    }
    
    //========================================================================================================
    //MARK: Combine BP Systolic and Disastolic in One Entry in Vital Array.
    //========================================================================================================
    func combineBPSystolicandDisastolicInVitalArray(arrVital:[VitalsModel])->[VitalsModel]{
        var newArrVitals:[VitalsModel] = []
        let vitalModelBP = VitalsModel()
        vitalModelBP.title = VitalsName.bloodPressureSystolicDiastolic.rawValue
        var indexBPSystolic = -1
        var indexBPDiastolic = -1
        for index in 0..<(arrVital.count) {
            let vitalModel = arrVital[index]
            
            if vitalModel.title == VitalsName.bloodPressureSystolic.rawValue{
                vitalModelBP.value = vitalModel.value ?? ""
                vitalModelBP.isBPModel = true
                vitalModelBP.color = vitalModel.color
                indexBPSystolic = index;
                //self.arrVitals.remove(at: index)
            }
            else if vitalModel.title == VitalsName.bloodPressureDiastolic.rawValue{
                vitalModelBP.valueForDiastolic = vitalModel.value ?? ""
                vitalModelBP.isBPModel = true
                vitalModelBP.colorForDiastolic = vitalModel.color
                indexBPDiastolic = index
                //self.arrVitals.remove(at: index)
            }else{
                newArrVitals.append(vitalModel)
            }
            
        }
        
        if vitalModelBP.isBPModel,indexBPSystolic>=0,indexBPDiastolic>=0{
            newArrVitals.insert(vitalModelBP, at: 0)
        }
        return newArrVitals
    }
    
}
