//
//  SDHLab.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 11/05/21.
//
import Foundation
import HealthKitReporter
// Available from 13.6
/*Albumin Level
 BUN
 creatinine
 Hemaglobin*/
struct SDHLabRelativeImportance {
    static let albumin:Double = 40
    static let BUN:Double = 100
    static let creatinine:Double = 100
    static let hemoglobin:Double = 80
}
class SDHLabData:LabCalculation {
    var type:LabType = .sodium{
        didSet{
            
            super.metricType = type
            switch type {
            //albumin
            case .albumin:
                self.relativeValue = SDHLabRelativeImportance.albumin
            //BUN
            case .BUN:
                self.relativeValue = SDHLabRelativeImportance.BUN
            //creatinine
            case .creatinine:
                self.relativeValue = SDHLabRelativeImportance.creatinine
            //hemoglobin
            case .hemoglobin:
                self.relativeValue = SDHLabRelativeImportance.hemoglobin
                
            default:
                break
            }
            
            
        }
    }
    override init() {
        super.init()
        super.systemName = SystemName.SocialDeterminantsofHealth
    }
    
}

