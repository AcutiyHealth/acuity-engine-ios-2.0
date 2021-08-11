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
    var metricDictionary: [String:Any]?
    var myWellScoreDataDictionary: [[String:Any]]?
    //MARK: To display data in Pull up...
    func dictionaryRepresentation()->[String:Any]{
        return [Keys.kAcuityId:id ?? "",Keys.kSystemName:name?.rawValue ?? "",Keys.kScore:score ?? "",Keys.kImage:image ?? "",Keys.kMetricDictionary:(metricDictionary ?? []),Keys.kMyWellScoreDataDictionary:(myWellScoreDataDictionary ?? []) ]
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
