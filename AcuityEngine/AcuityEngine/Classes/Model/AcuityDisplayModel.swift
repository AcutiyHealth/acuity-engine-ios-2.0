//
//  AcuityDisplayModel.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 25/02/21.
//

import Foundation
class AcuityDisplayModel {
    
    var id: String?
    var name: String?
    var score: String?
    var index: String?
    var image: String?
    var metricCardio: [[String : Any]]?
    
    func dictionaryRepresentation()->[String:Any]{
        return ["id":id ?? "","name":name ?? "","score":score ?? "","index":index ?? "","image":image ?? "","metricCardio":(metricCardio ?? []) ]
    }
}
