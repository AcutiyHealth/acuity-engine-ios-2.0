//
//  AllSystemVitals.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 19/12/21.
//

import Foundation

class AllSystemVitals {
    /*
     S Blood pressure
     D Blood pressure
     Heart rate
     Irregular rhythm notification
     High heart rate
     Low heart rate
     VO2 Max
     Oxygen saturation
     */
    var heartRateData:[VitalCalculation] = []
    var systolicBloodPressureData:[VitalCalculation] = []
    var diastolicBloodPressureData:[VitalCalculation] = []
    var irregularRhythmNotificationData:[VitalCalculation] = []
    var vo2MaxData:[VitalCalculation] = []
    var peakflowRateData:[VitalCalculation] = []
    var temperatureData:[VitalCalculation] = []
    var bloodSugarData:[VitalCalculation] = []
    var weightData:[VitalCalculation] = []
    var oxygenSaturationData:[VitalCalculation] = []
    var respiratoryRateData:[VitalCalculation] = []
    var BMIData:[VitalCalculation] = []
    var stepsData:[VitalCalculation] = []
    var sleepData:[VitalCalculation] = []
    var waterIntakeData:[VitalCalculation] = []
    
    
    
    var totalScore:[Double] = []
    var arrayDayWiseScoreTotal:[Double] = []
    //For Dictionary Representation
    private var arrVitalSevenDays:[VitalsModel] = []
    private var arrVitalOneMonth:[VitalsModel] = []
    private var arrVitalThreeMonth:[VitalsModel] = []
    var vitalNameArrayHaveNoValue:[VitalsName] = []
    init(){
        arrVitalSevenDays = []
        arrVitalOneMonth = []
        arrVitalThreeMonth = []
    }
    //Get recent data for Specific Vitals..
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[VitalsModel]{
        
        var arrVital:[VitalsModel] = []
        vitalNameArrayHaveNoValue = []
        
        switch MyWellScore.sharedManager.daysToCalculateSystemScore {
        case .SevenDays:
            do{
                arrVital = arrVitalSevenDays
            }
        case .ThirtyDays:
            do{
                arrVital = arrVitalOneMonth
            }
        case .ThreeMonths:
            do{
                arrVital = arrVitalThreeMonth
            }
        default:
            break
        }
        if arrVital.count == 0{
            
            let days = MyWellScore.sharedManager.daysToCalculateSystemScore
            
            /*  case age = "Age"
             case heartRate = "Heart Rate"
             
             case vo2Max = "VO2 Max"
             case irregularRhymesNotification = "Irregular Rhymes Notification"
             case respiratoryRate = "Respiratory Rate (breaths/min)"
             case peakflowRate = "Peak Flow Rate(L/min)"
             
             case temperature = "Temperature"
             case BMI = "BMI"
             case bloodSugar = "Blood Sugar"
             
             case oxygenSaturation = "Oxygen Saturation"
             
             case headPhoneAudioLevel = "Headphone Audio Levels"
             case bloodPressureSystolicDiastolic = "BP Systolic/Diastolic"
             case steps = "Steps"
             case sleep = "Sleep"
             case waterIntake = "Water Intake"*/
            
            let systolicBloodPressureData = CardioManager.sharedManager.cardioData.cardioVital.systolicBloodPressureData
            let filterSystolicBloodPressureData = filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: systolicBloodPressureData,vitalName: VitalsName.bloodPressureSystolicDiastolic)
            
            let diastolicBloodPressureData = CardioManager.sharedManager.cardioData.cardioVital.diastolicBloodPressureData
            let filterDiastolicBloodPressureData = filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: diastolicBloodPressureData,vitalName: VitalsName.bloodPressureSystolicDiastolic)
            
            if filterSystolicBloodPressureData.count == 0 || filterDiastolicBloodPressureData.count == 0{
                vitalNameArrayHaveNoValue.append(VitalsName.bloodPressureSystolicDiastolic)
            }
            
            
            let heartRateData = CardioManager.sharedManager.cardioData.cardioVital.heartRateData
            let _ = filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: heartRateData,vitalName: VitalsName.heartRate)
            
            let irregularRhythmNotificationData = CardioManager.sharedManager.cardioData.cardioVital.irregularRhythmNotificationData
            let _ = filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: irregularRhythmNotificationData,vitalName: VitalsName.irregularRhymesNotification)
            
            let vO2MaxData = CardioManager.sharedManager.cardioData.cardioVital.vO2MaxData
            let _ = filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: vO2MaxData,vitalName: VitalsName.vo2Max)
            
            let peakFlowRateData = RespiratoryManager.sharedManager.respiratoryData.respiratoryVital.peakFlowRateData
            let _ = filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: peakFlowRateData,vitalName: VitalsName.peakflowRate)
            
            let temperatureData = IDiseaseManager.sharedManager.iDiseaseData.iDiseaseVital.temperatureData
            let _ = filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: temperatureData,vitalName: VitalsName.temperature)
            
            let bloodSugarData = EndocrineManager.sharedManager.endocrineData.endocrineVital.bloodSugarData
            let _ = filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: bloodSugarData,vitalName: VitalsName.bloodSugar)
            
            let oxygenSaturationData = CardioManager.sharedManager.cardioData.cardioVital.oxygenSaturationData
            let _ = filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: oxygenSaturationData,vitalName: VitalsName.oxygenSaturation)
            
            let headphoneAudioLevelsData = HeentManager.sharedManager.heentData.heentVital.headphoneAudioLevelsData
            let _ = filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: headphoneAudioLevelsData,vitalName: VitalsName.headPhoneAudioLevel)
            
            let stepsData = CardioManager.sharedManager.cardioData.cardioVital.stepsData
            let _ = filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: stepsData,vitalName: VitalsName.steps)
            
            let sleepData = CardioManager.sharedManager.cardioData.cardioVital.sleepData
            let _ = filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: sleepData,vitalName: VitalsName.sleep)
            
            let waterIntakeData = CardioManager.sharedManager.cardioData.cardioVital.waterIntakeData
            let _ = filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: waterIntakeData,vitalName: VitalsName.waterIntake)
            /*for model in vitalsArrayFromCalculationInConstant{
             if model.name == VitalsName.bloodPressure || model.name == VitalsName.bloodPressureSystolicDiastolic{
             let filteredArrSystolic =  cArrayOfVitalList.filter { vitalModel in
             return VitalsName.bloodPressureSystolic == vitalModel.vitalName
             }
             let filteredArrDiastolic =  cArrayOfVitalList.filter { vitalModel in
             return VitalsName.bloodPressureDiastolic == vitalModel.vitalName
             }
             let vitalArrayFromQuantityTypeSystolic =  createVitalArrayCalculationFromFilteredArray(days: days, filteredArrVital: filteredArrSystolic)
             let filteredVitalCalculationArraySystolic =  filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: vitalArrayFromQuantityTypeSystolic)
             
             let vitalArrayFromQuantityTypeDystolic = createVitalArrayCalculationFromFilteredArray(days: days, filteredArrVital: filteredArrDiastolic)
             let filteredVitalCalculationArrayDystolic = filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: vitalArrayFromQuantityTypeDystolic)
             
             if filteredVitalCalculationArraySystolic.count == 0 || filteredVitalCalculationArrayDystolic.count == 0{
             vitalNameArrayHaveNoValue.append(VitalsName.bloodPressureSystolicDiastolic)
             }
             }
             else{
             let filteredArrVital =  cArrayOfVitalList.filter { vitalModel in
             return model.name! == vitalModel.vitalName
             }
             
             vitalCalculationArrayFromQuantity = createVitalArrayCalculationFromFilteredArray(days: days, filteredArrVital: filteredArrVital)
             let filteredVitalCalculationArray =  filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: vitalCalculationArrayFromQuantity)
             if filteredVitalCalculationArray.count == 0{
             vitalNameArrayHaveNoValue.append(model.name)
             }
             }
             
             }*/
            for name in vitalNameArrayHaveNoValue{
                let vitalModel = VitalsModel(title: name.rawValue, value: "--")
                arrVital.append(vitalModel)
            }
            switch MyWellScore.sharedManager.daysToCalculateSystemScore {
            case .SevenDays:
                do{
                    arrVitalSevenDays.append(contentsOf: arrVital)
                    return arrVitalSevenDays
                }
            case .ThirtyDays:
                do{
                    arrVitalOneMonth.append(contentsOf: arrVital)
                    return arrVitalOneMonth
                }
            case .ThreeMonths:
                do{
                    arrVitalThreeMonth.append(contentsOf: arrVital)
                    return arrVitalThreeMonth
                }
            default:
                break
            }
            
        }
        return arrVital
    }
    
    func createVitalArrayCalculationFromFilteredArray(days:SegmentValueForGraph,filteredArrVital:[VitalQuantityOrCategoryModel])->[VitalCalculation]{
        var arrayVitalCalculation:[VitalCalculation] = []
        let _ = filteredArrVital.map { objModel in
            let objVitalCalculation = VitalCalculation()
            objVitalCalculation.title = objModel.vitalName!
            if objModel.quantity != nil{
                objVitalCalculation.value = Double(objModel.quantity?.harmonized.value ?? -1)
                objVitalCalculation.startTimeStamp = objModel.quantity?.startTimestamp ?? 0
                objVitalCalculation.endTimeStamp = objModel.quantity?.endTimestamp ?? 0
            }else{
                objVitalCalculation.value = Double(objModel.categoryValue)
                objVitalCalculation.startTimeStamp = objModel.category?.startTimestamp ?? 0
                objVitalCalculation.endTimeStamp = objModel.category?.endTimestamp ?? 0
            }
            
            arrayVitalCalculation.append(objVitalCalculation)
            
        }
        return arrayVitalCalculation
        
        
    }
    func filterVitalArrayToGetSingleDataWithSelectedSegmentInGraph(days:SegmentValueForGraph,array:[VitalCalculation],vitalName:VitalsName)->[VitalCalculation] {
        var filteredArray:[VitalCalculation] = []
        filteredArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: array)
        saveFilterDataInArrayVitals(days: days,filteredArray: filteredArray,vitalName: vitalName)
        return filteredArray
    }
    
    func saveFilterDataInArrayVitals(days:SegmentValueForGraph,filteredArray:[VitalCalculation],vitalName:VitalsName){
        if filteredArray.count > 0{
            let vital = filteredArray[0]
            saveVitalDataInArrayAsPerDays(days: days, vital: getVitalModel(item: vital))
        }else if vitalName != .bloodPressureSystolicDiastolic {
            vitalNameArrayHaveNoValue.append(vitalName)
        }
    }
    
    func saveVitalDataInArrayAsPerDays(days:SegmentValueForGraph,vital:VitalsModel){
        switch days {
        case .SevenDays:
            do{
                arrVitalSevenDays.append(vital)
            }
        case .ThirtyDays:
            do{
                arrVitalOneMonth.append(vital)
            }
        case .ThreeMonths:
            do{
                arrVitalThreeMonth.append(vital)
            }
        default:
            break
        }
        
    }
    //MARK:- For DetailValue  Screen...
    
    //Get list of data for specific Vital in detail screen..
    func getArrayDataForVitals(days:SegmentValueForGraph,title:String) -> [VitalsModel]{
        var arrVital:[VitalsModel] = []
        let vitalsName = VitalsName(rawValue: title)
        var filterArray:[VitalCalculation] = []
        
        if  vitalsName == VitalsName.bloodPressure || vitalsName == VitalsName.bloodPressureSystolicDiastolic{
            let systolicBloodPressureData = CardioManager.sharedManager.cardioData.cardioVital.systolicBloodPressureData
            let diastolicBloodPressureData = CardioManager.sharedManager.cardioData.cardioVital.diastolicBloodPressureData
            let filterArraySystolic = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: systolicBloodPressureData)
            let filterArrayDiastolic = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: diastolicBloodPressureData)
            arrVital = combineBPSystolicAndDiastolic(arraySystolic: filterArraySystolic, arrayDiastolic: filterArrayDiastolic)
            return arrVital
        }
        switch vitalsName {
        case .age:
            do{
                let ageData = SDHManager.sharedManager.sdhData.sdhVital.ageData
                filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: ageData)
            }
        case .heartRate:
            do{
                let heartRateData = CardioManager.sharedManager.cardioData.cardioVital.heartRateData
                filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: heartRateData)
            }
        case .irregularRhymesNotification:
            do{
                let irregularRhythmNotificationData = CardioManager.sharedManager.cardioData.cardioVital.irregularRhythmNotificationData
                filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: irregularRhythmNotificationData)
            }
        case .vo2Max:
            do{
                let vO2MaxData = CardioManager.sharedManager.cardioData.cardioVital.vO2MaxData
                filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: vO2MaxData)
            }
        case .peakflowRate:
            do{
                let peakFlowRateData = RespiratoryManager.sharedManager.respiratoryData.respiratoryVital.peakFlowRateData
                filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: peakFlowRateData)
            }
        case .temperature:
            do{
                let temperatureData = IDiseaseManager.sharedManager.iDiseaseData.iDiseaseVital.temperatureData
                filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: temperatureData)
            }
        case .bloodSugar:
            do{
                let bloodSugarData = EndocrineManager.sharedManager.endocrineData.endocrineVital.bloodSugarData
                filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: bloodSugarData)
            }
        case .oxygenSaturation:
            do{
                let oxygenSaturationData = CardioManager.sharedManager.cardioData.cardioVital.oxygenSaturationData
                filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: oxygenSaturationData)
            }
        case .headPhoneAudioLevel:
            do{
                let headphoneAudioLevelsData = HeentManager.sharedManager.heentData.heentVital.headphoneAudioLevelsData
                filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: headphoneAudioLevelsData)
            }
        case .steps:
            do{
                let stepsData = CardioManager.sharedManager.cardioData.cardioVital.stepsData
                filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: stepsData)
            }
        case .sleep:
            do{
                let sleepData = CardioManager.sharedManager.cardioData.cardioVital.sleepData
                filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: sleepData)
            }
        case .waterIntake:
            do{
                let waterIntakeData = CardioManager.sharedManager.cardioData.cardioVital.waterIntakeData
                filterArray = filterVitalArrayWithSelectedSegmentInGraph(days: days, array: waterIntakeData)
            }
        default:
            break;
        }
        for item in filterArray{
            arrVital.append(saveVitalsInArray(item: item))
        }
       
        return arrVital
    }
}

