//
//  Helper.swift
//  HealthKitDemo
//
//  Created by Bhoomi Jagani on 17/02/21.
//

import Foundation
import JGProgressHUD

//MARK: Show Indicator
func showIndicatorInView(view:UIView)->JGProgressHUD{
    let hud = JGProgressHUD()
    hud.textLabel.text = "Loading"
    hud.show(in: view)
    return hud
}

func hideIndicator(){
    let hud = JGProgressHUD()
    hud.dismiss()
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

func isiPhone() -> Bool{
    
    if UIDevice.current.userInterfaceIdiom == .phone {
        return true
    }
    return false
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

//MARK: Daywise Filter
func daywiseFilterMetrixsData(days:SegmentValueForGraph,array:[Metrix],metriXType:MetricsType)->[Double]{
    
    var now = MyWellScore.sharedManager.todaysDate
    var component = Calendar.Component.day
    var noOfTimesLoopExecute = 1
    var averageScoreArray:[Double] = []
    switch days {
    case .SevenDays:
        component = .day
        noOfTimesLoopExecute = 7
    case .ThirtyDays:
        component = .weekOfMonth
        let calendar = Calendar.current
        let weekRange = calendar.range(of: .weekOfMonth,
                                       in: .month,
                                       for: now)
        noOfTimesLoopExecute = weekRange?.count ?? 0
        print("noOfTimesLoopExecute ThirtyDays=====>",noOfTimesLoopExecute)
    case .ThreeMonths:
        component = .month
        noOfTimesLoopExecute = 3
        
    case .OneDay:
        component = .day
        noOfTimesLoopExecute = 1
    }
    
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
                filterConditionForSymptoms(sampleItem: item, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            }
        }else{
            filteredArray = array.filter { item in
              filterConditionForOtherMetrix(sampleItem: item, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            }
        }
        let averageScore = (Double(filteredArray.average(\.score)).isNaN ? 0 :  Double(filteredArray.average(\.score)))
        averageScoreArray.append(averageScore)
        //print("filteredChestPain",filteredArray)
        
    }
    return averageScoreArray
}

func getTimeIntervalBySelectedSegmentOfDays(days:SegmentValueForGraph)->Double{
    let now = MyWellScore.sharedManager.todaysDate
    var component = Calendar.Component.day
    var beforeDaysOrWeekOrMonth = 1
    
    switch days {
    case .SevenDays:
        component = .day
        beforeDaysOrWeekOrMonth = 7
    case .ThirtyDays:
        component = .month
        beforeDaysOrWeekOrMonth = 1
    case .ThreeMonths:
        component = .month
        beforeDaysOrWeekOrMonth = 3
        
        
    case .OneDay:
        break
    }
    
    let daysAgo = Calendar.current.date(byAdding: component, value: -beforeDaysOrWeekOrMonth, to: now)!
    
    let startOfDaysAgo = Calendar.current.startOfDay(for: daysAgo)
    let timeIntervalByLastMonth:Double = startOfDaysAgo.timeIntervalSince1970
    
    return timeIntervalByLastMonth
}

func filterConditionForSymptoms(sampleItem:Metrix,timeIntervalByLastMonth:Double,timeIntervalByNow:Double)->Bool{
    let timeIntervalStart = sampleItem.startTimeStamp
    let timeIntervalEnd = sampleItem.endTimeStamp
    if (timeIntervalStart >= timeIntervalByLastMonth && timeIntervalStart <= timeIntervalByNow) || (timeIntervalEnd >= timeIntervalByLastMonth && timeIntervalEnd <= timeIntervalByNow) || (timeIntervalStart <= timeIntervalByNow && timeIntervalEnd >= timeIntervalByNow){
        print("sampleItem Symptoms----->",sampleItem.value)
        return true
    }
    return false
}

func filterConditionForOtherMetrix(sampleItem:Metrix,timeIntervalByLastMonth:Double,timeIntervalByNow:Double)->Bool{
    let timeIntervalStart = sampleItem.startTimeStamp
    if (timeIntervalStart >= timeIntervalByLastMonth && timeIntervalStart <= timeIntervalByNow){
        print("sampleItem Vitals value----->",sampleItem.value)
        print("sampleItem Vitals score----->",sampleItem.score)
        return true
    }
    return false
}
