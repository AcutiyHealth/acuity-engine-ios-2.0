//
//  AcuityDetailConditionViewModel.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 10/03/21.
//

import Foundation

class AcuityDetailConditionViewModel: NSObject
{
    
    //MARK: Default system data...

    func getConditionData()->[ConditionsModel] {
        var arrConditions:[ConditionsModel] = []
          
        let Condition1 =  ConditionsModel(title: "Hypertension", value: .No)
        let Condition2 =  ConditionsModel(title: "Arrhythmia", value: .Yes)
        let Condition3 =  ConditionsModel(title: "Congestive Heart Failure", value: .No)
        let Condition4 =  ConditionsModel(title: "Coronary Artery Disease", value: .No)
       arrConditions = [Condition1,Condition2,Condition3,Condition4]
       return arrConditions
}
    
    func getLabData()->[LabModel] {
        var arrLabs:[LabModel] = []
          
        let lab1 =  LabModel(title: "Potassium Level", value: "3.3")
        lab1.color = ChartColor.REDCOLOR
        let lab2 =  LabModel(title: "Magnesium Level", value: "2")
        lab2.color = ChartColor.GREENCOLOR
        let lab3 =  LabModel(title: "Blood oxygen level", value: "97%")
        lab3.color = ChartColor.GREENCOLOR
        let lab4 =  LabModel(title: "B-peptide", value: "0")
        lab4.color = ChartColor.GREENCOLOR
        let lab5 =  LabModel(title: "Troponin Level", value: "0.03")
        lab5.color = ChartColor.GREENCOLOR
        let lab6 =  LabModel(title: "Hemoglobin", value: "17.6")
        lab6.color = ChartColor.REDCOLOR
        arrLabs = [lab1,lab2,lab3,lab4,lab5,lab6]
        
       return arrLabs
}
    
    func getSymptomsData()->[SymptomsModel] {
        var arrSymptoms:[SymptomsModel] = []
          
        let symptom1 =  SymptomsModel(title: SymptomsName.chestPain.rawValue, value: .Mild)
        let symptom2 =  SymptomsModel(title: SymptomsName.skippedHeartBeat.rawValue, value: .Not_Present)
        let symptom3 =  SymptomsModel(title: SymptomsName.dizziness.rawValue, value: .Not_Present)
        let symptom4 =  SymptomsModel(title: SymptomsName.fatigue.rawValue, value: .Not_Present)
        let symptom5 =  SymptomsModel(title: SymptomsName.rapidHeartbeat.rawValue, value: .Mild)
        let symptom6 =  SymptomsModel(title: SymptomsName.fainting.rawValue, value: .Not_Present)
        let symptom9 =  SymptomsModel(title: SymptomsName.nausea.rawValue, value: .Mild)
        let symptom10 =  SymptomsModel(title: SymptomsName.vomiting.rawValue, value: .Not_Present)
        let symptom11 =  SymptomsModel(title: SymptomsName.memoryLapse.rawValue, value: .Severe)
        let symptom12 =  SymptomsModel(title: SymptomsName.shortnessOfBreath.rawValue, value: .Mild)
        let symptom13 =  SymptomsModel(title: SymptomsName.headache.rawValue, value: .Moderate)
        let symptom14 =  SymptomsModel(title: SymptomsName.heartburn.rawValue, value: .Present)
        let symptom15 =  SymptomsModel(title: SymptomsName.sleepChanges.rawValue, value: .Not_Present)
        arrSymptoms = [symptom1,symptom2,symptom3,symptom4,symptom5,symptom6,symptom9,symptom10,symptom11,symptom12,symptom13,symptom14,symptom15]
       return arrSymptoms
}
    
    func getVitals()->[VitalsModel] {
        var arrVitals:[VitalsModel] = []
          
        let imp1 =  VitalsModel(title: VitalsName.BloodPressure.rawValue, value: "90")
        imp1.color = ChartColor.GREENCOLOR
        let imp2 =  VitalsModel(title: VitalsName.BloodPressureDiastolic.rawValue, value: "84")
        imp2.color = ChartColor.GREENCOLOR
        let imp3 =  VitalsModel(title: VitalsName.heartRate.rawValue, value: "80")
        imp3.color = ChartColor.GREENCOLOR
        let imp4 =  VitalsModel(title: VitalsName.irregularRhymesNotification.rawValue, value: "No")
        imp4.color = ChartColor.GREENCOLOR
        let imp5 =  VitalsModel(title: VitalsName.highHeartRate.rawValue, value: "Yes")
        imp5.color = ChartColor.REDCOLOR
        let imp6 =  VitalsModel(title: VitalsName.lowHeartRate.rawValue, value: "No")
        imp6.color = ChartColor.GREENCOLOR
        let imp7 =  VitalsModel(title: VitalsName.vo2Max.rawValue, value: "35")
        imp7.color = ChartColor.YELLOWCOLOR
        arrVitals = [imp1,imp2,imp3,imp4,imp5,imp6,imp7]
       return arrVitals
}
}
