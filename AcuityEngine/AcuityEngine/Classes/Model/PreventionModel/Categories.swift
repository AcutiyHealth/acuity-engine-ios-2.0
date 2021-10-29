//
//  Categories.swift
//  AcuityEngine
//
//  Created by DevDigital on 12/10/21.
//

import Foundation
struct Categories : Codable {
    let name : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
