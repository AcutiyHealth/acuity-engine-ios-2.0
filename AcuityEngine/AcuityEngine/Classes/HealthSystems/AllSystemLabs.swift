//
//  AllSystemLabs.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 20/12/21.
//

import Foundation


class AllSystemLabs {
    
    //For Dictionary Representation
    private var arrLabSevenDays:[LabModel] = []
    private var arrLabOneMonth:[LabModel] = []
    private var arrLabThreeMonth:[LabModel] = []
    
    init(){
        arrLabSevenDays = []
        arrLabOneMonth = []
        arrLabThreeMonth = []
    }
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[LabModel]{
        var arrLab:[LabModel] = []
        
        switch MyWellScore.sharedManager.daysToCalculateSystemScore {
        case .SevenDays:
            do{
                arrLab = arrLabSevenDays
            }
        case .ThirtyDays:
            do{
                arrLab = arrLabOneMonth
            }
        case .ThreeMonths:
            do{
                arrLab = arrLabThreeMonth
            }
        default:
            break
        }
        if arrLab.count == 0{
            let days = MyWellScore.sharedManager.daysToCalculateSystemScore
            var labNameArrayHaveNoValue:[LabType] = []
            for labType in LabType.allCases{
                let filteredArrLab =  cArrayOfLabList.filter { labModel in
                    return labType == labModel.metricType
                }
                filterLabArrayToGetSingleDataWithSelectedSegmentInGraph(days: days, array: filteredArrLab)
                if filteredArrLab.count == 0{
                    labNameArrayHaveNoValue.append(labType)
                }
            }
            for name in labNameArrayHaveNoValue{
                let LabModel = LabModel(title: name.rawValue, value: "--")
                arrLab.append(LabModel)
            }
            switch MyWellScore.sharedManager.daysToCalculateSystemScore {
            case .SevenDays:
                do{
                    arrLabSevenDays.append(contentsOf: arrLab)
                    return arrLabSevenDays
                }
            case .ThirtyDays:
                do{
                    arrLabOneMonth.append(contentsOf: arrLab)
                    return arrLabOneMonth
                }
            case .ThreeMonths:
                do{
                    arrLabThreeMonth.append(contentsOf: arrLab)
                    return arrLabThreeMonth
                }
            default:
                break
            }
            
        }
        return arrLab
    }
    func filterLabArrayToGetSingleDataWithSelectedSegmentInGraph(days:SegmentValueForGraph,array:[LabCalculation]){
        var filteredArray:[LabCalculation] = []
        filteredArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: array)
        saveFilterDataInArrayLabs(days: days, filteredArray: filteredArray)
        //return filteredArray
    }
    
    func saveFilterDataInArrayLabs(days:SegmentValueForGraph,filteredArray:[LabCalculation]){
        if filteredArray.count > 0{
            let lab = filteredArray[0]
            saveLabDataInArrayAsPerDays(days: days, lab: getLabModel(item: lab))
        }
    }
    func saveLabDataInArrayAsPerDays(days:SegmentValueForGraph,lab:LabModel){
        switch days {
        case .SevenDays:
            do{
                arrLabSevenDays.append(lab)
            }
        case .ThirtyDays:
            do{
                arrLabOneMonth.append(lab)
            }
        case .ThreeMonths:
            do{
                arrLabThreeMonth.append(lab)
            }
        default:
            break
        }
        
    }
    //Get list of data for specific Lab in detail screen..
    func getArrayDataForLabs(days:SegmentValueForGraph,title:String) -> [LabModel]{
        
        var arrLab:[LabModel] = []
        let labName = LabType(rawValue: title)
        var filterArray:[LabCalculation] = []
        
        let filteredArrLab =  cArrayOfLabList.filter { labModel in
            return labName == labModel.metricType
        }
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: filteredArrLab)
        
        
        for item in filterArray{
            arrLab.append(saveLabsInArray(item: item))
        }
        return arrLab
    }
}

