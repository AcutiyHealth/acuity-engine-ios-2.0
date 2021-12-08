//
//  Medications.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 08/10/21.
//

import Foundation


class MedicationInputModel {
    
    var id: MedicationId?
    var name: Medication?
    var description: String?
    
    //MARK: To display data in textfield views...
    init(id:MedicationId = MedicationId.Medication,name:Medication,description:String) {
        self.id = id;
        self.name = name
        self.description = description
    }
}
class MedicationDataDisplayModel {
    
    var id: MedicationId?
    var name: Medication?
    var txtValue: String?
    var timeStamp: Double?
    
    init(id:MedicationId = MedicationId.Medication,txtValue:String,timeStamp:Double){
        self.id = id;
        self.name = getMedicationName(id: id);
        self.txtValue = txtValue;
        self.timeStamp = timeStamp
    }
    
}

func getMedicationName(id:MedicationId)->Medication{
    return Medication.Medication
}
