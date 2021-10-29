//
//  Risks.swift
//  AcuityEngine
//
//  Created by DevDigital on 12/10/21.
//


import Foundation
struct Risks: Codable {
    let code : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
