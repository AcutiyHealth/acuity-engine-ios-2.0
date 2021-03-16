//
//  AcuityDisplayModel.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 25/02/21.
//

import Foundation
class AcuityDisplayModel {
    
    var id: String?
    var name: SystemName?
    var score: String?
    var index: String?
    var image: String?
    var metricCardio: [String:Any]?
    
    func dictionaryRepresentation()->[String:Any]{
        return ["id":id ?? "","name":name?.rawValue ?? "","score":score ?? "","image":image ?? "","metricCardio":(metricCardio ?? []) ]
    }
}

class AcuityDetailPulllUpModel {
    
    var title: String?
    var value: String?
    var metrixType: MetricsType?
   
    init(title:String,value:String,metrixType:MetricsType) {
        self.title = title
        self.value = value
        self.metrixType = metrixType
    }
}
