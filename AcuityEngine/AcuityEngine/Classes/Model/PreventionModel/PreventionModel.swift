//
//  UserModel.swift
//  AcuityEngine
//
//  Created by DevDigital on 12/10/21.
//

import Foundation
struct PreventionModel: Codable {
    let note : String?
    let specificRecommendations : [SpecificRecommendations]?
    let grades : Grades?
    let generalRecommendations : GeneralRecommendations?
    let tools : Tools?
    let categories : Categories?
    let risks : Risks?

    enum CodingKeys: String, CodingKey {

        case note = "note"
        case specificRecommendations = "specificRecommendations"
        case grades = "grades"
        case generalRecommendations = "generalRecommendations"
        case tools = "tools"
        case categories = "categories"
        case risks = "risks"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        note = try values.decodeIfPresent(String.self, forKey: .note)
        specificRecommendations = try values.decodeIfPresent([SpecificRecommendations].self, forKey: .specificRecommendations)
        grades = try values.decodeIfPresent(Grades.self, forKey: .grades)
        generalRecommendations = try values.decodeIfPresent(GeneralRecommendations.self, forKey: .generalRecommendations)
        tools = try values.decodeIfPresent(Tools.self, forKey: .tools)
        categories = try values.decodeIfPresent(Categories.self, forKey: .categories)
        risks = try values.decodeIfPresent(Risks.self, forKey: .risks)
    }

}
