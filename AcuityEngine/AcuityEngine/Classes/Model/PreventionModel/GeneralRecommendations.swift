//
//  GeneralRecommendations.swift
//  AcuityEngine
//
//  Created by DevDigital on 12/10/21.
//


import Foundation
struct GeneralRecommendations : Codable {
    let topicType : String?
    let topicYear : Int?
    let uspstfAlias : String?
    let specific : [Int]?
    let title : String?
    let rationale : String?
    let clinical : String?
    let other : String?
    let discussion : String?
    let topic : String?
    let keywordswords : String?
    let pubDate : String?
    let categories : [String]?
    let tool : [String]?

    enum CodingKeys: String, CodingKey {

        case topicType = "topicType"
        case topicYear = "topicYear"
        case uspstfAlias = "uspstfAlias"
        case specific = "specific"
        case title = "title"
        case rationale = "rationale"
        case clinical = "clinical"
        case other = "other"
        case discussion = "discussion"
        case topic = "topic"
        case keywordswords = "keywords"
        case pubDate = "pubDate"
        case categories = "categories"
        case tool = "tool"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        topicType = try values.decodeIfPresent(String.self, forKey: .topicType)
        topicYear = try values.decodeIfPresent(Int.self, forKey: .topicYear)
        uspstfAlias = try values.decodeIfPresent(String.self, forKey: .uspstfAlias)
        specific = try values.decodeIfPresent([Int].self, forKey: .specific)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        rationale = try values.decodeIfPresent(String.self, forKey: .rationale)
        clinical = try values.decodeIfPresent(String.self, forKey: .clinical)
        other = try values.decodeIfPresent(String.self, forKey: .other)
        discussion = try values.decodeIfPresent(String.self, forKey: .discussion)
        topic = try values.decodeIfPresent(String.self, forKey: .topic)
        keywordswords = try values.decodeIfPresent(String.self, forKey: .keywordswords)
        pubDate = try values.decodeIfPresent(String.self, forKey: .pubDate)
        categories = try values.decodeIfPresent([String].self, forKey: .categories)
        tool = try values.decodeIfPresent([String].self, forKey: .tool)
    }
}
