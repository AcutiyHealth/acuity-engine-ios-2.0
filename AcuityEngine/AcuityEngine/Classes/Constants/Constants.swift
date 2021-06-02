//
//  Constants.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 17/02/21.
//

import Foundation
import UIKit

enum RYGValue:Double {
    case Red = 1
    case Yellow = 0.5
    case Green = 0
}
enum LabResult:Double {
    case positive = 1
    case negative = 0
}
enum ConditionValue:Double {
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

enum SymptomsTextValue:String {
    case Severe = "Severe"
    case Moderate = "Moderate"
    case Mild = "Mild"
    case Present = "Present"
    case Not_Present = "Not Present"
    
}
enum SystemName:String {
    case Cardiovascular = "Cardiovascular"
    case Respiratory = "Pulmonary"
    case Renal = "Renal"
    case Gastrointestinal = "Gastrointestinal"
    case Genitourinary = "Genitourinary"
    case Endocrine = "Endocrine"
    case Nuerological = "Neurological"
    case Hematology = "Hematology"
    case Musculatory = "Musculoskeletal"
    case Integumentary = "Integumentary"
    case Fluids = "Fluids"
    case InfectiousDisease = "Infectious Disease"
    case SocialDeterminantsofHealth = "Social Determinants of Health"
    case Heent = "Head,Eyes,Ears,Nose,Throat"
}
enum ConditionValueText:String {
    case Yes = "Yes"
    case No = "No"
}
struct ImageSet {
    static let wheel1 = UIImage(named:"wheel_option_1.png")
    static let wheel2 = UIImage(named:"wheel_option_2.png")
}
enum PullUpType {
    case Detail
    case Profile
    case Add
}

enum SegmentValueForGraph:String {
    case SevenDays = "7 Days"
    case ThirtyDays = "1 Month"
    case ThreeMonths = "3 Months"
    case OneDay = "31 Day"
}
enum MetricsType:String {
    case Sympotms = "Symptoms"
    case LabData = "Labs"
    case Conditions = "Conditions"
    case Vitals = "Vitals"
}
enum Storyboard: String {
    case main = "Main"
    case profile = "Profile"
    case acuityDetailPullUp = "AcuityDetailPullUp"
    case add = "Add"
}
enum ProfileOption: String {
    case settings = "Settings"
    case profile = "Profile"
    case termsOfService = "Terms Of Service"
}
enum AddOption: String {
    case Symptom = "Symptoms Tracker"
    case Conditions = "Conditions"
    case vitals = "Vitals"
}
enum NSNotificationName: String {
    case pullUpOpen = "pullUpOpen"
    case pullUpClose = "pullUpClose"
    case showAcuityDetailPopup = "showAcuityDetailPopup"
    case refreshCircleView = "refreshCircleView"
}
struct AlertMessages {
    static let STARTDATEGRATETHANENDDATE = "Start date should be less than End date"
    static let OK = "OK"
}
struct WheelColor {
    static let BLUECOLORLABELTITLE = UIColor(red: 41.0 / 255.0, green: 121.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    static let SUBMENUITEMTITLECOLOR = UIColor(red: 206.0 / 255.0, green: 216.0 / 255.0, blue: 220.0 / 255.0, alpha: 1.0)
    static let MENULISTBACKGROUNDCOLOR = UIColor(red: 69.0 / 255.0, green: 90.0 / 255.0, blue: 100.0 / 255.0, alpha:1.0)
    static let REDCOLOR = UIColor(red: 244.0 / 255.0, green: 67.0 / 255.0, blue: 54.0 / 255.0, alpha: 1.0)
    static let GREENCOLOR = UIColor(red: 46.0 / 255.0, green: 125.0 / 255.0, blue: 50.0 / 255.0, alpha: 1.0)
    static let YELLOWCOLOR = UIColor(red: 255.0 / 255.0, green: 150.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
}
struct ChartColor {
    static let REDCOLOR = UIColor(red: 244.0 / 255.0, green: 67.0 / 255.0, blue: 54.0 / 255.0, alpha: 1.0)
    static let GREENCOLOR = UIColor(red: 52.0 / 255.0, green: 199 / 255.0, blue: 89 / 255.0, alpha: 1.0)
    static let YELLOWCOLOR = UIColor(red: 255.0 / 255.0, green: 152.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
}
enum ColorSchema {
    
    // Label Color
    static let titleLabelColor = UIColor.white
    static let smallTitleColor = UIColor.white
    static let detailLabelColor = UIColor.white
    
    // Button Color
    static let buttonShadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
    
    // Common Color
    static let lightBlueColor = UIColor(named: "light_blue_color")
    static let saffornColor = UIColor(named: "safforn_color")
    static let lightTextColor = UIColor(named: "light_text_color")
    
    //Main screen background
    static let kMainThemeColor =  UIColor(red: 20.0 / 255.0, green: 41 / 255.0, blue: 113 / 255.0, alpha: 1.0)
    static let kMainThemeColorForPullup =  UIColor(red: 20.0 / 255.0, green: 41 / 255.0, blue: 113 / 255.0, alpha: 0.3)
}
struct ChartSize {
    static let kAcuityCircleWidth  = (Int(Screen.screenWidth)*360)/Screen.iPhone11ScreenWidth
    static let kAcuityCircleHeight  = (Int(Screen.screenWidth)*360)/Screen.iPhone11ScreenWidth
}
struct Screen{
    static let screenSize = UIScreen.main.bounds
    static let screenWidth = screenSize.width
    static let screenHeight = screenSize.height
    static let iPhone11ScreenHeight =
        896
    static let iPhone11ScreenWidth =
        414
    static let iPhoneSEHeight =
        568
}

struct AcuityData {
    static let kAcuityId = "id"
}


struct AcuityImages {
    static let kCardiovascular = "cardiovascular.png"
    static let kRespiratory = "respiratory.png"
    static let kRenal = "renal.png"
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

struct Fonts {
    
    static let kAcuityMainTitle1Font = UIFont.SFProDisplayBold(of: 22)
    static let kAcuityMainScoreFont = UIFont.SFProDisplayBold(of: 55)
    static let kAcuityMainTitle2Font = UIFont.SFProDisplayBold(of: 20)
    //Pull up
    static let kAcuityDetailTitleFont = UIFont.SFProDisplayBold(of: 26)
    static let kAcuityDetailValueFont = UIFont.SFProDisplayBold(of: 26)
    static let kAcuityDetailSegmentFont = UIFont.SFProDisplayMedium(of: 13)
    static let kAcuityDetailCellFont = UIFont.SFProDisplayMedium(of: 12)
    static let kAcuitySystemCellFont = UIFont.SFProDisplayBold(of: 16)
    
    //All other screen cell
    static let kCellTitleFont = UIFont.SFProDisplaySemiBold(of: 18)
    static let kValueFont = UIFont.SFProDisplayMedium(of: 18)
    
    //Pull up
    static let kAcuityAddOptionTitleFont = UIFont.SFProDisplayBold(of: 22)
    static let kAcuityAddOptionValueFont = UIFont.SFProDisplayMedium(of: 12)
  
}

let dayArray = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "AcuityEngine"
