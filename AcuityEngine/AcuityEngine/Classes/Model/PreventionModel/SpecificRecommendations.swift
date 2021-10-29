//
//  UserModel.swift
//  AcuityEngine
//
//  Created by DevDigital on 12/10/21.
//

import Foundation
struct SpecificRecommendations : Codable {
	let id : Int?
	let title : String?
	let grade : String?
	let gradeVer : Int?
	let gender : String?
	let sex : String?
	let ageRange : [Int]?
	let text : String?
	let servFreq : String?
	let riskName : String?
	let risk : [String]?
	let riskText : String?
	let general : String?
	let tool : [String]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case title = "title"
		case grade = "grade"
		case gradeVer = "gradeVer"
		case gender = "gender"
		case sex = "sex"
		case ageRange = "ageRange"
		case text = "text"
		case servFreq = "servFreq"
		case riskName = "riskName"
		case risk = "risk"
		case riskText = "riskText"
		case general = "general"
		case tool = "tool"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		grade = try values.decodeIfPresent(String.self, forKey: .grade)
		gradeVer = try values.decodeIfPresent(Int.self, forKey: .gradeVer)
		gender = try values.decodeIfPresent(String.self, forKey: .gender)
		sex = try values.decodeIfPresent(String.self, forKey: .sex)
		ageRange = try values.decodeIfPresent([Int].self, forKey: .ageRange)
		text = try values.decodeIfPresent(String.self, forKey: .text)
		servFreq = try values.decodeIfPresent(String.self, forKey: .servFreq)
		riskName = try values.decodeIfPresent(String.self, forKey: .riskName)
		risk = try values.decodeIfPresent([String].self, forKey: .risk)
		riskText = try values.decodeIfPresent(String.self, forKey: .riskText)
		general = try values.decodeIfPresent(String.self, forKey: .general)
		tool = try values.decodeIfPresent([String].self, forKey: .tool)
	}

}
