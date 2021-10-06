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
    case MyWellScore = "MyWell  Score"
}
struct SystemId {
    static let Id_Cardiovascular = "0"
    static let Id_Respiratory = "15"
    static let Id_Renal = "20"
    static let Id_Gastrointestinal = "45"
    static let Id_Genitourinary = "32"
    static let Id_Endocrine = "46"
    static let Id_Nuerological = "78"
    static let Id_Hematology = "36"
    static let Id_Musculatory = "23"
    static let Id_Integumentary = "89"
    static let Id_Fluids = "432"
    static let Id_InfectiousDisease = "98"
    static let Id_SocialDeterminantsofHealth = "248"
    static let Id_Heent = "111"
    static let Id_MyWellScore = "112"
}

enum ConditionValueText:String {
    case Yes = "Yes"
    case No = "No"
}
struct ImageSet {
    //static let wheel1 = UIImage(named:"wheel_option_1.png")
    //static let wheel2 = UIImage(named:"wheel_option_2.png") //AppIcon
    static let wheel1 = UIImage(named:"center_button.png")
    static let wheel2 = UIImage(named:"center_button.png")
}
enum PullUpType {
    case Detail
    case Profile
    case Add
    case MyWellScore
}

enum SegmentValueForGraph:String {
    case SevenDays = "7 Days"
    case ThirtyDays = "1 Month"
    case ThreeMonths = "3 Months"
    case OneDay = "1 Day"
}

enum SegmentValueForCondition:String {
    case Yes = "Yes"
    case No = "No"
}
enum ValueForMonths:Int {
    case SevenDays = 7
    case One = 1
    case ThreeMonths = 3
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
    case symptom = "Symptoms Tracker"
    case conditions = "Conditions"
    case vitals = "Vitals"
    case medications = "Medications"
    case otherHistory = "Other Histories"
}
enum NSNotificationName: String {
    case pullUpOpen = "pullUpOpen"
    case pullUpClose = "pullUpClose"
    case showAcuityDetailPopup = "showAcuityDetailPopup"
    case refreshCircleView = "refreshCircleView"
    case refreshDataInCircle = "refreshDataInCircle"
}
//=============================Other History=================================================//
enum OtherHistory:String {
    case otherConditions = "Other Conditions"
    case surgicalHistory = "Surgical History"
    case familyHistory = "Family History"
    case socialHistory = "Social History"
    case allergies = "Allergies"
    case none = "none"
}
enum OtherHistoryId:Int,CaseIterable {
    case otherConditionsId = 1
    case surgicalHistoryId = 2
    case familyHistoryId = 3
    case socialHistoryId = 4
    case allergiesId = 5
}
//==============================================================================//
struct ScreenTitle {
    static let BMIIndexCalculator = "BMI Calculator"
}
struct AlertMessages {
    static let STARTDATEGRATETHANENDDATE = "Start date should be less than End date"
    static let OK = "OK"
    static let BP_AND_HEARTRATE_SAVED = "Blood Pressure and Heart Rate saved in health kit"
    static let o2_AND_HEARTRATE_SAVED = "Oxygen Saturation and Heart Rate saved in health kit"
    static let MESSAGE_IN_ADD_OPTION_SCREEN = " use to know well score of person."
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
    
    //Add Option Round view color...
    static let addOptionGrayColor =  UIColor(red: 1, green: 0.99, blue: 1, alpha: 0.22)
    
    // Button Color
    static let buttonShadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
    
    // Common Color
    static let lightBlueColor = UIColor(named: "light_blue_color")
    static let saffornColor = UIColor(named: "safforn_color")
    static let lightTextColor = UIColor(named: "light_text_color")
    
    //Main screen background
//    static let kMainThemeColor =  UIColor(red: 25.0 / 255.0, green: 25 / 255.0, blue: 112 / 255.0, alpha: 1.0)
//    static let kMainThemeColorForPullup =  UIColor(red: 61.0 / 255.0, green: 89 / 255.0, blue: 171 / 255.0, alpha: 0.3)
    static let kMainThemeColor =  UIColor.black
    static let kMainThemeColorForPullup =  UIColor(red: 28.0 / 255.0, green: 28 / 255.0, blue: 30 / 255.0, alpha: 1)//rgba(28,28,30,255)

}//rgba(53, 85, 189, 1)

struct ChartSize {
    static let kAcuityCircleWidth  = (Int(Screen.screenWidth)*360)/Screen.iPhone11ScreenWidth
    static let kAcuityCircleHeight  = (Int(Screen.screenWidth)*360)/Screen.iPhone11ScreenWidth
}

struct Screen{
    static let screenSize = UIScreen.main.bounds
    static let screenWidth = screenSize.size.width
    static let screenHeight = screenSize.size.height
    static let iPhone11ScreenHeight =
        896
    static let iPhone11ScreenWidth =
        414
    static let iPhoneSEHeight =
        568
}

struct Keys {
    static let kAcuityId = "id"
    static let kSystemName = "name"
    static let kScore = "score"
    static let kImage = "image"
    static let kMetricDictionary = "metricDictionary"
    static let kMyWellScoreDataDictionary = "myWellScoreDataDictionary"
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
    static let kSDH = "disposition_information.png"
    static let kHeent = "heent.png"
    static let kMyWellScore = "mywellscore.png"
}

struct Fonts {
    
    static let kAcuityMainTitle1Font = UIFont.SFProDisplayBold(of: 22)
    static let kAcuityMainScoreFont = UIFont.SFProDisplayBold(of: 55)
    static let kAcuityMainTitle2Font = UIFont.SFProDisplayBold(of: 20)
    
    //Pull up
    static let kAcuityDetailTitleFont = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplayBold(of: 26), fontSize: 26)
    static let kAcuityDetailValueFont = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplayBold(of: 26), fontSize: 26)
    static let kAcuityDetailSegmentFont = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplayMedium(of: 13), fontSize: 13)
    static let kAcuityDetailCellTitleFont = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplayBold(of: 15), fontSize: 15)
    static let kAcuityPullUpMetricCellFont = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplayMedium(of: 12), fontSize: 12)
    static let kAcuityDetailCellFont = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplayMedium(of: 15), fontSize: 15)
    static let kAcuitySystemCellFont = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplayBold(of: 16), fontSize: 16)
    static let kAcuityMyWellTblCellTitleFont = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplaySemiBold(of: 16), fontSize: 16)
    static let kAcuityMyWellTblValueFont = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplayMedium(of: 16), fontSize: 16)
    
    //All other screen cell
    static let kCellTitleFont = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplayBold(of: 18), fontSize: 18)
    static let kValueFont = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplayMedium(of: 18), fontSize: 18)
    
    //List in Add Section cell
    static let kCellTextFontListInAddSection = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplaySemiBold(of: 18), fontSize: 18)
    static let kCellTitleFontListInAddSection = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplayBold(of: 26), fontSize: 26)
    static let kCellHistoryTitleFontInAddSection = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplaySemiBold(of: 22), fontSize: 22)
    static let kCellHistoryDescriptionFontInAddSection = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplayRegular(of: 16), fontSize: 16)
    static let kStartEndTitleFont = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplaySemiBold(of: 18), fontSize: 18)
    static let kStartEndValueFont = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplayMedium(of: 16), fontSize: 16)
    static let kAcuityBtnAdd = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplayBold(of: 16), fontSize: 16)
    //Pull up
    static let kAcuityAddOptionTitleFont = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplayBold(of: 18), fontSize: 18)
    static let kAcuityAddOptionValueFont = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplayMedium(of: 10), fontSize: 10)
    static let kAcuityAddDetailTitleFont = getFontAsPerDeviceSize(fontName: UIFont.SFProDisplayBold(of: 24), fontSize: 24)
    
}
//
let VERSION_KEY = "version"

let dayArray = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]

struct DeviceSize {
    static let screenRect = UIScreen.main.bounds
    static let screenWidth = screenRect.size.width
    static let screenHeight = screenRect.size.height
}

struct Key {
    static let kIsConditionDataAdded = "isConditionDataAdded" as  String
    static let kAppleFirstName = "appleFirstName" as  String
    static let kAppleLastName = "appleLastName" as  String
    static let kAppleEmail = "appleEmail" as  String
    static let kAppleUserID = "appleUserID" as  String
    static let kAppName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "AcuityEngine"
}

