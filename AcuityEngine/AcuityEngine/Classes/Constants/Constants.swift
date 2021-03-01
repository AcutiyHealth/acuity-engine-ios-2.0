//
//  Constants.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 17/02/21.
//

import Foundation
import UIKit

enum HeartRateValue:Double {
    case Red = 1
    case Yellow = 0.5
    case Green = 0
}

enum ProblemValue:Double {
    case Yes = 1
    case No = 0
}

enum SymptomsValue:Double {
    case Severe = 1
    case Moderate = 0.75
    case Mild = 0.5
    case Present = 0.25
    case Not_Present = 0
    
}

enum ProblemsValue:Double {
    case Yes = 1
    case No = 0
}
enum SegmentValueForGraph:String {
    case SevenDays = "7 Days"
    case ThirtyDays = "30 Days"
    case ThreeMonths = "3 Months"
}
enum Storyboard: String {
    case main = "Main"
    case acuityDetailPullUp = "AcuityDetailPullUp"
}
struct ChartColor {
    static let BLUECOLORLABELTITLE = UIColor(red: 41.0 / 255.0, green: 121.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    static let SUBMENUITEMTITLECOLOR = UIColor(red: 206.0 / 255.0, green: 216.0 / 255.0, blue: 220.0 / 255.0, alpha: 1.0)
    static let MENULISTBACKGROUNDCOLOR = UIColor(red: 69.0 / 255.0, green: 90.0 / 255.0, blue: 100.0 / 255.0, alpha:1.0)
    static let REDCOLOR = UIColor(red: 244.0 / 255.0, green: 67.0 / 255.0, blue: 54.0 / 255.0, alpha: 1.0)
    static let GREENCOLOR = UIColor(red: 46.0 / 255.0, green: 125.0 / 255.0, blue: 50.0 / 255.0, alpha: 1.0)
    static let YELLOWCOLOR = UIColor(red: 255.0 / 255.0, green: 152.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
}
struct ChartSize {
    static let kAcuityCircleWidth  = (Screen.screenWidth*340)/414
    static let kAcuityCircleHeight  = (Screen.screenWidth*340)/414
}
struct Screen{
    static let screenSize = UIScreen.main.bounds
    static let screenWidth = screenSize.width
    static let screenHeight = screenSize.height
}

struct AlertMessages {
    
}

struct AcuityData {
    static let kAcuityId = "id"
}
struct AppColorsData {
    static let kMainThemeColor = UIColor.systemBlue
}

struct AcuityImages {
    static let kCardiovascular = "cardiovascular.png"
    static let kRespiratory = "cardiovascular.png"
    static let kGastrointestinal = "gastrointestinal.png"
    static let kGenitourinary = "genitourinary.png"
    static let kEndocrine = "endocrine.png"
    static let kNuerological = "nuerological.png"
    static let kHematology = "hematology.png"
    static let kMusculatory = "musculatory.png"
    static let kIntegumentary = "integumentary.png"
    static let kFluids = "fluids.png"
    static let kIDs = "infectious_disease.png"
    static let kDisposition = "disposition_information.png"
    static let kHeent = "heent.png"
}

let dayArray = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]

