//
//  Grades.swift
//  AcuityEngine
//
//  Created by DevDigital on 12/10/21.
//

import Foundation
struct Grades : Codable {
	let b : [String]?

	enum CodingKeys: String, CodingKey {

		case b = "B"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		b = try values.decodeIfPresent([String].self, forKey: .b)
	}

}
