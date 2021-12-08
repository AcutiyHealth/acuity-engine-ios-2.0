//
//  HistoryModels.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 28/09/21.
//

import Foundation


class HistoryInputModel {
    
    var id: OtherHistoryId?
    var name: OtherHistory?
    var description: String?
    
    //MARK: To display data in textfield views...
    init(id:OtherHistoryId,name:OtherHistory,description:String) {
        self.id = id;
        self.name = name
        self.description = description
    }
}
class HistoryDataDisplayModel {
    
    var id: OtherHistoryId?
    var name: OtherHistory?
    var txtValue: String?
    var timeStamp: Double?
    init(){
        
    }
    init(id:OtherHistoryId,txtValue:String,timeStamp:Double){
        self.id = id;
        self.txtValue = txtValue;
        self.timeStamp = timeStamp
        self.name = getHistoryName(id: id)
    }
    init(id:OtherHistoryId,name:OtherHistory,txtValue:String,timeStamp:Double){
        self.id = id;
        self.name = name;
        self.txtValue = txtValue;
        self.timeStamp = timeStamp
        
    }
    
}

func getHistoryName(id:OtherHistoryId)->OtherHistory{
    switch id {
    case OtherHistoryId.otherConditionsId:
        return OtherHistory.otherConditions
    case OtherHistoryId.familyHistoryId:
        return OtherHistory.familyHistory
    case OtherHistoryId.surgicalHistoryId:
        return OtherHistory.surgicalHistory
    case OtherHistoryId.socialHistoryId:
        return OtherHistory.socialHistory
    case OtherHistoryId.allergiesId:
        return OtherHistory.allergies
        
    }
}
