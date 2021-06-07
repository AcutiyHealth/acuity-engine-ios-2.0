//
//  CardioLab.swift
//  HealthKitDemo
//
//  Created by Paresh Patel on 05/02/21.
//

import UIKit

class FNELab {
    /*blood glucose
     Sodium
     potassium
     BUN
     Creatinine
     eGFR
     Albumin
     microalbumin/creat ratio
     carbon dioxide
     Anion gap
     Calcium
     chloride
     Urine ketone
     MCV
     AST
     ALT */
    var bloddGlucoseData:[FNELabData] = []
    var sodiumData:[FNELabData]  = []
    var potassiumData:[FNELabData] = []
    
    var BUNData:[FNELabData] = []
    var creatinieData:[FNELabData] = []
    var eGFRData:[FNELabData] = []
    
    var albuminData:[FNELabData] = []
    var microAlbuminData:[FNELabData]  = []
    var carbonDioxideData:[FNELabData] = []
    
    var anionGapData:[FNELabData] = []
    var calciumData:[FNELabData] = []
    var chlorideData:[FNELabData] = []
    
    var urineKenoteData:[FNELabData] = []
    var MCVData:[FNELabData] = []
    var ASTData:[FNELabData] = []
    var ALTData:[FNELabData] = []
    
    var arrayDayWiseScoreTotal:[Double] = []
    
    func totalLabDataScore() -> Double {
        
        return 0;
    }
    
    func getMaxLabDataScore() -> Double {
        
        let bloodGlucose = FNELabRelativeImportance.bloodGlucose.getConvertedValueFromPercentage()
        let sodium = FNELabRelativeImportance.sodium.getConvertedValueFromPercentage()
        let potassiumLevel = FNELabRelativeImportance.potassiumLevel.getConvertedValueFromPercentage()
        
        let BUN = FNELabRelativeImportance.BUN.getConvertedValueFromPercentage()
        let creatinine = FNELabRelativeImportance.creatinine.getConvertedValueFromPercentage()
        let eGFR = FNELabRelativeImportance.eGFR.getConvertedValueFromPercentage()
        
        let albumin = FNELabRelativeImportance.albumin.getConvertedValueFromPercentage()
        let microalbumin = FNELabRelativeImportance.microalbumin.getConvertedValueFromPercentage()
        let carbonDioxide = FNELabRelativeImportance.carbonDioxide.getConvertedValueFromPercentage()
        
        let anionGap = FNELabRelativeImportance.anionGap.getConvertedValueFromPercentage()
        let calcium = FNELabRelativeImportance.calcium.getConvertedValueFromPercentage()
        let chloride = FNELabRelativeImportance.chloride.getConvertedValueFromPercentage()
        
        let urineKetone = FNELabRelativeImportance.urineKetone.getConvertedValueFromPercentage()
        let MCV = FNELabRelativeImportance.MCV.getConvertedValueFromPercentage()
        let AST = FNELabRelativeImportance.AST.getConvertedValueFromPercentage()
        let ALT = FNELabRelativeImportance.ALT.getConvertedValueFromPercentage()
        
        let totalLabScore1 = bloodGlucose + sodium + potassiumLevel
        let totalLabScore2 = BUN + creatinine + eGFR
        let totalLabScore3 = albumin + microalbumin + carbonDioxide
        let totalLabScore4 = anionGap + calcium + chloride
        let totalLabScore5 = urineKetone + MCV + AST + ALT
        
        return Double(totalLabScore1 + totalLabScore2 + totalLabScore3 + totalLabScore4 + totalLabScore5);
    }
    
    func totalLabScoreForDays(days:SegmentValueForGraph) -> [Double] {
        
        
        arrayDayWiseScoreTotal = []
        /*
         Here We get component is Month/Day and noOfTimesLoopExecute to execute.
         We get selection from Segment Control from Pull up
         When there is & days selected, loop will execute 7 times
         When there is 1 Month selected, loop will execute per weeks count
         When there is 3 month selected, loop will execute 3 times
         */
        var now = MyWellScore.sharedManager.todaysDate
        let getComponentAndLoop = getNumberOfTimesLoopToExecute(days: days)
        let component:Calendar.Component = getComponentAndLoop["component"] as! Calendar.Component
        let noOfTimesLoopExecute:Int = getComponentAndLoop["noOfTimesLoopExecute"] as! Int
        
        for _ in 0...noOfTimesLoopExecute-1{
            
            let day = Calendar.current.date(byAdding: component, value: -1, to: now)!
            
            let timeIntervalByLastMonth:Double = day.timeIntervalSince1970
            //print("timeIntervalByLastMonth",getDateMediumFormat(time:timeIntervalByLastMonth))
            let timeIntervalByNow:Double = now.timeIntervalSince1970
            //print("timeIntervalByNow",getDateMediumFormat(time:timeIntervalByNow))
            now = day
            
            //bloddGlucoseData
            let scoreBloddGlucoseData = getScoreForLabDataWithGivenDateRange(sampleItem: bloddGlucoseData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //sodiumData
            let scoreSodium = getScoreForLabDataWithGivenDateRange(sampleItem: sodiumData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //potassiumData
            let scorePotassium = getScoreForLabDataWithGivenDateRange(sampleItem: potassiumData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //BUNData
            let scoreBUN = getScoreForLabDataWithGivenDateRange(sampleItem: BUNData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //creatinieData
            let scoreCreatinie = getScoreForLabDataWithGivenDateRange(sampleItem: creatinieData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //eGFRData
            let scoreeGFR = getScoreForLabDataWithGivenDateRange(sampleItem: eGFRData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            
            let totalScore = scoreBloddGlucoseData + scoreSodium + scorePotassium + scoreBUN  + scoreCreatinie + scoreeGFR
            
            //albuminData
            let scoreAalbumin = getScoreForLabDataWithGivenDateRange(sampleItem: albuminData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //microAlbuminData
            let scoreMicroAlbumin = getScoreForLabDataWithGivenDateRange(sampleItem: microAlbuminData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //carbonDioxideData
            let scoreCarbonDioxide = getScoreForLabDataWithGivenDateRange(sampleItem: carbonDioxideData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //anionGapData
            let scoreAnionGap = getScoreForLabDataWithGivenDateRange(sampleItem: anionGapData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //calciumData
            let scoreCalcium = getScoreForLabDataWithGivenDateRange(sampleItem: calciumData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore1 = scoreAalbumin + scoreMicroAlbumin + scoreCarbonDioxide + scoreAnionGap  + scoreCalcium
            
            //chlorideData
            let scoreChloride = getScoreForLabDataWithGivenDateRange(sampleItem: chlorideData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //urineKenote
            let scoreUrineKenote = getScoreForLabDataWithGivenDateRange(sampleItem: urineKenoteData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //MCVData
            let scoreMCV = getScoreForLabDataWithGivenDateRange(sampleItem: MCVData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //ASTData
            let scoreAST = getScoreForLabDataWithGivenDateRange(sampleItem: ASTData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            //ALTData
            let scoreALT = getScoreForLabDataWithGivenDateRange(sampleItem: ALTData, timeIntervalByLastMonth: timeIntervalByLastMonth, timeIntervalByNow: timeIntervalByNow)
            
            let totalScore2 = scoreChloride + scoreUrineKenote + scoreMCV + scoreAST  + scoreALT
            
            arrayDayWiseScoreTotal.append(totalScore + totalScore1 + totalScore2)
        }
        print("FNE lab score",arrayDayWiseScoreTotal)
        return arrayDayWiseScoreTotal
    }
    
    
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[LabModel]{
        
        var arrLab:[LabModel] = []
        
        var filterArray:[LabCalculation] = []
        let days = MyWellScore.sharedManager.daysToCalculateSystemScore
        
        //sodiumData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: bloddGlucoseData)
        if filterArray.count > 0{
            let bloddGlucose = filterArray[0]
            arrLab.append(getLabModel(item: bloddGlucose))
        }
        //sodiumData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: sodiumData)
        if filterArray.count > 0{
            let sodium = filterArray[0]
            arrLab.append(getLabModel(item: sodium))
        }
        //potassiumData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: potassiumData)
        if filterArray.count > 0{
            let potassium = filterArray[0]
            arrLab.append(getLabModel(item: potassium))
        }
        //BUNData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: BUNData)
        if filterArray.count > 0{
            let BUN = filterArray[0]
            arrLab.append(getLabModel(item: BUN))
        }
        //creatinieData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: creatinieData)
        if filterArray.count > 0{
            let creatinie = filterArray[0]
            arrLab.append(getLabModel(item: creatinie))
        }
        //eGFRData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: eGFRData)
        if filterArray.count > 0{
            let eGFR = filterArray[0]
            arrLab.append(getLabModel(item: eGFR))
        }
        //albuminData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: albuminData)
        if filterArray.count > 0{
            let albumin = filterArray[0]
            arrLab.append(getLabModel(item: albumin))
        }
        //microAlbuminData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: microAlbuminData)
        if filterArray.count > 0{
            let microAlbumin = filterArray[0]
            arrLab.append(getLabModel(item: microAlbumin))
        }
        //carbonDioxideData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: carbonDioxideData)
        if filterArray.count > 0{
            let carbonDioxide = filterArray[0]
            arrLab.append(getLabModel(item: carbonDioxide))
        }
        
        //anionGapData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: anionGapData)
        if filterArray.count > 0{
            let anionGap = filterArray[0]
            arrLab.append(getLabModel(item: anionGap))
        }
        //calciumData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: calciumData)
        if filterArray.count > 0{
            let calcium = filterArray[0]
            arrLab.append(getLabModel(item: calcium))
        }
        //chlorideData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: chlorideData)
        if filterArray.count > 0{
            let chloride = filterArray[0]
            arrLab.append(getLabModel(item: chloride))
        }
        //urineKenoteData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: urineKenoteData)
        if filterArray.count > 0{
            let urineKenote = filterArray[0]
            arrLab.append(getLabModel(item: urineKenote))
        }
        //MCVData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: MCVData)
        if filterArray.count > 0{
            let MCV = filterArray[0]
            arrLab.append(getLabModel(item: MCV))
        }
        //ASTData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: ASTData)
        if filterArray.count > 0{
            let AST = filterArray[0]
            arrLab.append(getLabModel(item: AST))
        }
        //ALTData
        filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: ALTData)
        if filterArray.count > 0{
            let ALT = filterArray[0]
            arrLab.append(getLabModel(item: ALT))
        }
        return arrLab
    }
    
    //Get list of data for specific Lab in detail screen..
    func getArrayDataForLabs(days:SegmentValueForGraph,title:String) -> [LabModel]{
        
        var arrLab:[LabModel] = []
        let labName = LabType(rawValue: title)
        var filterArray:[LabCalculation] = []
        /*blood glucose
         Sodium
         potassium
         
         BUN
         Creatinine
         eGFR
         
         Albumin
         microalbumin/creat ratio
         carbon dioxide
         
         Anion gap
         Calcium
         chloride
         
         Urine ketone
         MCV
         AST
         ALT */
        switch labName {
        //bloodGlucose
        case .bloodGlucose:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: bloddGlucoseData)
        //sodium
        case .sodium:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: sodiumData)
        //potassiumLevel
        case .potassiumLevel:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: potassiumData)
        //BUN
        case .BUN:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: BUNData)
        //creatinine
        case .creatinine:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: creatinieData)
            
        //eGFR
        case .eGFR:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: eGFRData)
        //albumin
        case .albumin:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: albuminData)
        //microalbuminCreatinineRatio
        case .microalbuminCreatinineRatio:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: microAlbuminData)
        //carbonDioxide
        case .carbonDioxide:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: carbonDioxideData)
        //anionGap
        case .anionGap:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: anionGapData)
            
        //calcium
        case .calcium:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: calciumData)
        //chloride
        case .chloride:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: chlorideData)
        //urineKetone
        case .urineKetone:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: urineKenoteData)
        //MCV
        case .MCV:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: MCVData)
        //AST
        case .AST:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: ASTData)
        //ALT
        case .ALT:
            filterArray = filterLabArrayWithSelectedSegmentInGraph(days: days, array: ALTData)
            
        default:
            break
        }
        for item in filterArray{
            arrLab.append(saveLabsInArray(item: item))
        }
        return arrLab
    }
}

