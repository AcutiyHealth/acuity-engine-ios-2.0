//
//  CardioManagerProtocol.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 12/02/21.
//

import Foundation

protocol CardioManagerProtocol {
    
    var readIrregularHeartDataDone: (() -> Void)? { get set }
    var readBloodPressureDone: (() -> Void)? { get set }
    var readSymptomsDataDone: (() -> Void)? { get set }
    var readLabDataDone: (() -> Void)? { get set }
    var readConditionDataDone: (() -> Void)? { get set }
    
    func readIrregularHeartData(completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void)
    func readBloodPressure(completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void)
    func readSymptomsData(completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void)
    func readLabData(completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void)
    func readConditionData(completion: @escaping (Bool, HealthkitSetupError?) -> Swift.Void)
    
}
