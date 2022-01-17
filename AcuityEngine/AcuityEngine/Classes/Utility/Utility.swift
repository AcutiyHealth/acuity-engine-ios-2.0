//
//  Helper.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 17/02/21.
//

import Foundation
import SVProgressHUD
import HealthKitReporter

class Utility {
    //UserDefaults
    static let shared = Utility()
    
    class func setBoolForKey(_ value: Bool, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func fetchBool(forKey key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    class func setStringForKey(_ value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func setIntegerForKey(_ value: Int, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func setDoubleForKey(_ value: Double, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func fetchInteger(forKey key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    class func fetchDouble(forKey key: String) -> Double {
        return UserDefaults.standard.double(forKey: key)
    }
    
    class func fetchString(forKey key: String) -> String {
        return UserDefaults.standard.string(forKey: key)!
    }
    
    class func setObjectForKey(_ value: Data, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func fetchObject(forKey key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    class func removeUserDefaults(key: String){
        UserDefaults.standard.string(forKey: key)
        UserDefaults.standard.removeObject(forKey:key)
    }
    
    class func showSVProgress(){
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.clear)
    }
    class func hideSVProgress(){
        SVProgressHUD.dismiss()
    }
    class func showAlertWithOKBtn(onViewController vc: UIViewController, title titleOfAlert:String = "\(Key.kAppName)" , message messageInAlert: String) {
        
        //Create alertController object with specific message
        let alertController = UIAlertController(title: titleOfAlert, message: messageInAlert, preferredStyle: .alert)
        
        //Add OK button to alert and dismiss it on action
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        
        //Show alert to user
        vc.present(alertController, animated: true, completion: nil)
    }
    class func getDateForDayOrMonth(from startDate:Date, component:Calendar.Component, numberOfBeforeOrAfterDays:Int)->Date{
        
        let daysAgo = Calendar.current.date(byAdding: component, value: numberOfBeforeOrAfterDays, to: startDate)!
        return daysAgo
    }
    //MARK: Make view of Conditions,lab,symptoms and vital selected
    static func setBackgroundColorWhenViewSelcted(view:UIView){
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1;
    }
    
    //MARK: Make view of Conditions,lab,symptoms and vital unselected
    static func setBackgroundColorWhenViewUnSelcted(viewSymptom:UIView,viewCondition:UIView,viewVital:UIView,viewLab:UIView){
        viewLab.layer.borderWidth = 0;
        viewVital.layer.borderWidth = 0;
        viewSymptom.layer.borderWidth = 0;
        viewCondition.layer.borderWidth = 0;
    }
    //MARK: Make view of Conditions,lab,symptoms and vital unselected
    static func setBackgroundColorWhenViewUnSelcted(view:UIView){
        view.layer.borderWidth = 0;
    }
    
    //MARK: Filter prevention data based on age and gender...
    func filterPreventionDataForAgeAndGender(preventionData:[PreventionTrackerModel],age:Int,gender:String)->[PreventionTrackerModel] {
        //let newAge = 11
        var ageSpecificRecommendations: [PreventionTrackerModel] = []
        for obj in 0..<(preventionData.count) {
            let objPrevention = preventionData[obj]
            let data = objPrevention.specificRecommendation
            let min = data?.ageRange?.first ?? 0
            let max = data?.ageRange?.last ?? 0
            
            // let _ = data?.ageRange?.map{ _ in
            if age >= min && age <= max {
                //print("data?.gender",data?.gender as Any)
                // || data?.gender == "men and women"
                if gender.lowercased() == data?.gender || data?.gender == "men and women"{
                    if let _ =  data{
                        ageSpecificRecommendations.append(objPrevention)
                    }
                }
            }
            //}
        }
        return ageSpecificRecommendations
        //showContactPopUp()
    }
}

func setupViewBorderForAddSection(view:UIView){
    view.layer.borderWidth = 1
    view.layer.cornerRadius = 5
    view.layer.borderColor = UIColor.white.cgColor
    view.backgroundColor = UIColor.white.withAlphaComponent(0.3)
}
func roundCorners(view:UIView,_ corners: UIRectCorner, radius: CGFloat) {
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.white.cgColor
    view.layer.cornerRadius = 0
    let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    view.layer.mask = mask
}
/// Standardize the display of dates within the app.
func createDefaultDateFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}

/// Used to unescape the FHIR JSON prior to displaying it in the FHIR Source view.
func unescapeJSONString(_ string: String) -> String {
    return string.replacingOccurrences(of: "\\/", with: "/").replacingOccurrences(of: "\\\\", with: "\\")
}
//========================================================================================================
//MARK: Version Number String..
//========================================================================================================
func versionNumberString() -> String? {
    let infoDictionary = Bundle.main.infoDictionary
    let majorVersion = infoDictionary?["CFBundleShortVersionString"] as? String
    return majorVersion
}

//========================================================================================================
//MARK: Birthdate and Age..
//========================================================================================================
func calculateAgeFromBirthDate(birthday:String)->Int{
    
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "yyyy-MM-dd"
    let birthdayDate = dateFormater.date(from: birthday)
    let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
    let now = Date()
    if let birthdayDate = birthdayDate{
        let calcAge = calendar.components(.year, from: birthdayDate, to: now, options: [])
        let age = calcAge.year
        return age ?? 0
    }
    return 0
}
//MARK: Apply Animation For Adding View
func animationForDetailViewWhenAdded(subviewToAdd:UIView, in   view:UIView){
    let transition = CATransition()
    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromRight
    view.layer.add(transition, forKey: nil)
    view.addSubview(subviewToAdd)
}
//MARK: Apply Animation For Removing View
func animationForDetailViewWhenRemoved(from   view:UIView){
    let transition = CATransition()
    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromLeft
    view.layer.add(transition, forKey: nil)
}
//MARK: set background view when no data available....
func setNoDataInfoIfRecordsNotExists(tblView:UITableView,font:UIFont =  UIFont.systemFont(ofSize: 12),message:String = "No Records Found")
{
    let noDataLabel : UILabel = UILabel()
    noDataLabel.frame = CGRect(x: 0, y: 0 , width: (tblView.bounds.width), height: (tblView.bounds.height))
    noDataLabel.text = message
    noDataLabel.font = font
    noDataLabel.textColor = UIColor.white
    noDataLabel.textAlignment = .center
    tblView.backgroundView = noDataLabel
    
}
//MARK: Animation For Score Label....
func animateScoreView(view:UIView){
    view.alpha = 0.0
    UIView.animate(withDuration: 0.5) {
        view.alpha = 1.0
    }
}
//MARK: Chart Segment Color
func getThemeColor(index: String?,isForWheel:Bool) -> UIColor? {
    let indexValue = Double(index ?? "") ?? 0
    if indexValue > 0 && indexValue <= 75 {
        if isForWheel{
            return WheelColor.REDCOLOR
        }else{
            return ChartColor.REDCOLOR
        }
    } else if indexValue > 75 && indexValue <= 85 {
        if isForWheel{
            return WheelColor.YELLOWCOLOR
        }else{
            return ChartColor.YELLOWCOLOR
        }
        
    } else {
        if isForWheel{
            return WheelColor.GREENCOLOR
        }else{
            return ChartColor.GREENCOLOR
        }
        
    }
}


//MARK: Sorting Of Systems Based on Score
func sortingOfSystemBasedONScore(item: [String:Any]) -> [[String:Any]] {
    var redColorElememnts : [[String:Any]] = []
    var yellowColorElememnts : [[String:Any]] = []
    var greenColorElememnts : [[String:Any]] = []
    
    let indexValue =  Double(item["score"] as? String ?? "") ?? 0
    if indexValue  > 0 && indexValue <= 75{
        redColorElememnts.append(item)
    }else if indexValue  > 75 && indexValue <= 85{
        yellowColorElememnts.append(item)
    }else{
        greenColorElememnts.append(item)
    }
    
    var finalArray: [[String:Any]] = []
    finalArray.append(contentsOf: redColorElememnts)
    finalArray.append(contentsOf: yellowColorElememnts)
    finalArray.append(contentsOf: greenColorElememnts)
    
    
    return finalArray
}

func isiPhone() -> Bool{
    
    if UIDevice.current.userInterfaceIdiom == .phone {
        return true
    }
    return false
}
//MARK-
func getFontAsPerDeviceSize(fontName:UIFont,fontSize:CGFloat)->UIFont{
    return fontName.withSize(fontSize*DeviceSize.screenWidth/320)
}
//MARK:
func getRowHeightAsPerDeviceSize(height:CGFloat)->CGFloat{
    return height*DeviceSize.screenWidth/320
}
//MARK:-
func getStringToDisplayScore(score:Double)->String{
    let isScoreInteger = score.truncatingRemainder(dividingBy: 1) == 0
    return isScoreInteger ? String(format: "%.0f", score) : String(format: "%.2f", score)
}
func getDateMediumFormat(time:Double)->String{
    
    let date = Date(timeIntervalSince1970: time)
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
    dateFormatter.timeZone = .current
    let localDate = dateFormatter.string(from: date)
    return localDate
    
}
func getDateMediumFormatWithDate(date:Date)->String{
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
    dateFormatter.timeZone = .current
    let localDate = dateFormatter.string(from: date)
    return localDate
    
}
func getDateWithTime(date:Date)->String{
    
    let formatter = DateFormatter()
    formatter.dateFormat = "M/dd/yyyy hh:mm a"
    let localDate = formatter.string(from: date)
    return localDate
    
}
func getDateFromString(date:String)->Date{
    
    let formatter = DateFormatter()
    formatter.dateFormat = "M/dd/yyyy hh:mm a"
    let localDate = formatter.date(from: date)
    return localDate ?? Date()
    
}

func getTimeStampForCurrenTime()->Double{
    let timestamp = Date().timeIntervalSince1970
    return timestamp
}
//MARK: Convert Celcius to fahrenheit
func convertDegCelciusToDahrenheit(temprature:Double)->Double{
    return (temprature * 9/5) + 32
}
//MARK:  mmol/dl  to mg/dL
func convertGlucoseFromMMOLTOMG(glucoseValue:Double)->Double{
    return 18 * glucoseValue
}
//MARK: Daywise Filter
func getNumberOfTimesLoopToExecute(days:SegmentValueForGraph)->[String:AnyObject]{
    let now = MyWellScore.sharedManager.todaysDate
    var component = Calendar.Component.day
    var noOfTimesLoopExecute = 1
    
    switch days {
    case .SevenDays:
        component = .day
        noOfTimesLoopExecute = ValueForMonths.SevenDays.rawValue
    case .ThirtyDays:
        component = .weekOfMonth
        
        let prevmonth = Calendar.current.date(byAdding: .month, value: -1, to: now) ?? Date()
        let weekRange = Calendar.current.dateComponents([.weekOfMonth], from: prevmonth, to: now).weekOfMonth ?? 0
        
        noOfTimesLoopExecute = weekRange
        print("noOfTimesLoopExecute ThirtyDays=====>",noOfTimesLoopExecute)
    case .ThreeMonths:
        component = .month
        noOfTimesLoopExecute = ValueForMonths.ThreeMonths.rawValue
        
    case .OneDay:
        component = .day
        noOfTimesLoopExecute = ValueForMonths.One.rawValue
    }
    let componentAndLoopDictionary = ["component":component,"noOfTimesLoopExecute":noOfTimesLoopExecute] as [String : AnyObject]
    
    return componentAndLoopDictionary
}

func daywiseFilterMetrixsData(days:SegmentValueForGraph,array:[Metrix],metriXType:MetricsType)->[Double]{
    
    var now = MyWellScore.sharedManager.todaysDate
    let getComponentAndLoop = getNumberOfTimesLoopToExecute(days: days)
    let component:Calendar.Component = getComponentAndLoop["component"] as! Calendar.Component
    let noOfTimesLoopExecute:Int = getComponentAndLoop["noOfTimesLoopExecute"] as! Int
    var averageScoreArray:[Double] = []
    for _ in 0...noOfTimesLoopExecute-1{
        
        let day = Calendar.current.date(byAdding: component, value: -1, to: now)!
        
        let timeIntervalByLastMonth:Double = day.timeIntervalSince1970
        //print("timeIntervalByLastMonth",getDateMediumFormat(time:timeIntervalByLastMonth))
        let timeIntervalByNow:Double = now.timeIntervalSince1970
        //print("timeIntervalByNow",getDateMediumFormat(time:timeIntervalByNow))
        now = day
        
        var filteredArray:[Metrix] = []
        
        if metriXType == MetricsType.Sympotms{
            filteredArray = array.filter { item in
                filterMatricsForSymptoms(sampleItem: item, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            }
        }else{
            filteredArray = array.filter { item in
                filterMatricsForVitalOrLab(sampleItem: item, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            }
        }
        let averageScore = (Double(filteredArray.sum(\.score)).isNaN ? 0 :  Double(filteredArray.sum(\.score)))
        averageScoreArray.append(averageScore)
        //print("filteredChestPain",filteredArray)
        
    }
    return averageScoreArray
}

//MARK: Get score for conditions in system
func getScoreForConditions(array:[Metrix],days:SegmentValueForGraph)->[Double]{
    let getComponentAndLoop = getNumberOfTimesLoopToExecute(days: days)
    
    let noOfTimesLoopExecute:Int = getComponentAndLoop["noOfTimesLoopExecute"] as! Int
    var averageScoreArray:[Double] = []
    for _ in 0...noOfTimesLoopExecute-1{
        /*
         Here, it will filter all condition array who has isOn switch on. If isOn switch on in ConditionList VC, it's calculated value will be 1.
         */
        var filteredArray:[Metrix] = []
        filteredArray = array.filter { item in
            return item.calculatedValue == 1
        }
        let averageScore = (Double(filteredArray.sum(\.score)).isNaN ? 0 :  Double(filteredArray.sum(\.score)))
        averageScoreArray.append(averageScore)
    }
    
    return averageScoreArray
}
//MARK: getScoreForMyWellData
func getScoreForMyWellDataWithGivenDateRange(sampleItem:[Metrix],timeIntervalByLastMonth:Double,timeIntervalByNow:Double)->Double{
    var filteredArray:[Metrix] = []
    
    filteredArray = sampleItem.filter { item in
        filterMatricsForVitalOrLab(sampleItem: item, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
    }
    let averageScore = (Double(filteredArray.average(\.value)).isNaN ? 0 :  Double(filteredArray.average(\.value)))
    return averageScore
}
//MARK: getScoreForVitalData
func getScoreForVitalDataWithGivenDateRange(sampleItem:[Metrix],timeIntervalByLastMonth:Double,timeIntervalByNow:Double)->Double{
    var filteredArray:[Metrix] = []
    
    filteredArray = sampleItem.filter { item in
        filterMatricsForVitalOrLab(sampleItem: item, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
    }
    
    let averageScore = (Double(filteredArray.average(\.score)).isNaN ? 0 :  Double(filteredArray.average(\.score)))
    return averageScore
}
//MARK: getScoreForLabData
func getScoreForLabDataWithGivenDateRange(sampleItem:[Metrix],timeIntervalByLastMonth:Double,timeIntervalByNow:Double)->Double{
    var filteredArray:[Metrix] = []
    
    filteredArray = sampleItem.filter { item in
        filterMatricsForVitalOrLab(sampleItem: item, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
    }
    
    let averageScore = (Double(filteredArray.average(\.score)).isNaN ? 0 :  Double(filteredArray.average(\.score)))
    return averageScore
}
//MARK: getScoreForSymptomsData
func getScoreForSymptomsDataWithGivenDateRange(sampleItem:[Metrix],timeIntervalByLastMonth:Double,timeIntervalByNow:Double)->Double{
    var filteredArray:[Metrix] = []
    //print("timeIntervalByLastMonth",timeIntervalByLastMonth)
    //print("timeIntervalByNow",timeIntervalByNow)
    filteredArray = sampleItem.filter { item in
        
        filterMatricsForSymptoms(sampleItem: item, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
    }
    
    let averageScore = (Double(filteredArray.average(\.score)).isNaN ? 0 :  Double(filteredArray.average(\.score)))
    return averageScore
}

func getTimeIntervalBySelectedSegmentOfDays(days:SegmentValueForGraph)->Double{
    let now = MyWellScore.sharedManager.todaysDate
    var component = Calendar.Component.day
    var beforeDaysOrWeekOrMonth = ValueForMonths.One.rawValue
    
    switch days {
    case .SevenDays:
        component = .day
        beforeDaysOrWeekOrMonth = ValueForMonths.SevenDays.rawValue
    case .ThirtyDays:
        component = .month
        beforeDaysOrWeekOrMonth = ValueForMonths.One.rawValue
    case .ThreeMonths:
        component = .month
        beforeDaysOrWeekOrMonth = ValueForMonths.ThreeMonths.rawValue
    case .OneDay:
        component = .day
        break;
    }
    
    let daysAgo = Calendar.current.date(byAdding: component, value: -beforeDaysOrWeekOrMonth, to: now)!
    
    //let startOfDaysAgo = Calendar.current.startOfDay(for: daysAgo)
    let timeIntervalByLastMonth:Double = daysAgo.timeIntervalSince1970
    
    return timeIntervalByLastMonth
}

func filterMatricsForSymptoms(sampleItem:Metrix,timeIntervalByLastMonth:Double,timeIntervalByNow:Double)->Bool{
    let timeIntervalStart = sampleItem.startTimeStamp
    let timeIntervalEnd = sampleItem.endTimeStamp
    if (timeIntervalStart >= timeIntervalByLastMonth && timeIntervalStart <= timeIntervalByNow) || (timeIntervalEnd >= timeIntervalByLastMonth && timeIntervalEnd <= timeIntervalByNow) || (timeIntervalStart <= timeIntervalByNow && timeIntervalEnd >= timeIntervalByNow){
        print("item startTime",sampleItem.startTimeStamp)
        print("item endTimeStamp",sampleItem.endTimeStamp)
        print("sampleItem Symptoms----->",sampleItem.value)
        return true
    }
    return false
}

func filterMatricsForVitalOrLab(sampleItem:Metrix,timeIntervalByLastMonth:Double,timeIntervalByNow:Double)->Bool{
    let timeIntervalStart = sampleItem.startTimeStamp
    /*
     Here it's checking vitals's start time with timeIntervalByNow/Current time and timeIntervalByMonth/Day. So, if vitals's start time is between timeIntervalByNow/Current time and timeIntervalByMonth/Da, you will get filter data.
     */
    if (timeIntervalStart >= timeIntervalByLastMonth && timeIntervalStart <= timeIntervalByNow){
        //print("sampleItem Vitals value----->",sampleItem.value)
        //print("sampleItem Vitals score----->",sampleItem.score)
        return true
    }
    return false
}
