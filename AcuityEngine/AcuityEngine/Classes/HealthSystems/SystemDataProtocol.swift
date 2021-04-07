//
//  CardioDataProtocol.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 06/04/21.
//

import Foundation

protocol SystemDataProtocol {
    func getWeightedSystemScore()->Double
    func totalSystemScoreWithDays(days:SegmentValueForGraph) -> Double
    func systemScoreWithDays(days:SegmentValueForGraph)->[Double]
    func abnormalFractionWithDays(days:SegmentValueForGraph)->[Double]
    func totalMetrixScoreWithDays(days:SegmentValueForGraph) -> [Double]
    func maxTotalScore() -> Double
    func dictionaryRepresentation()->[String:Any]
}



protocol VitalProtocol {
    func totalVitalsScore() -> Double
    func totalVitalsScoreForDays(days:SegmentValueForGraph) -> [Double]
    func getMaxVitalsScore() -> Double
    func getVitalModel(item:CardioVitals)->VitalsModel
    func saveVitalsInArray(item:IMPCalculation)->VitalsModel
    func getArrayDataForVitals(days:SegmentValueForGraph,title:String) -> [VitalsModel]
    func dictionaryRepresentation()->[VitalsModel]
}

