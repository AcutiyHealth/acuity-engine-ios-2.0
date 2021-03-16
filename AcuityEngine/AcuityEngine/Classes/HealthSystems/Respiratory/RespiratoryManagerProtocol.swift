//
//  CardioManagerProtocol.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation

protocol RespiratoryManagerProtocol {
    
    var readIrregularHeartDataDone: (() -> Void)? { get set }
    var readBloodPressureDone: (() -> Void)? { get set }
    var readSymptomsDataDone: (() -> Void)? { get set }
    var readLabDataDone: (() -> Void)? { get set }
    var readConditionDataDone: (() -> Void)? { get set }
    
    func readIrregularHeartData()
    func readBloodPressure()
    func readSymptomsData()
    func readLabData()
    func readConditionData()
    
}
