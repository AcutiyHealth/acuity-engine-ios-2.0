//
//  Tools.swift
//  AcuityEngine
//
//  Created by DevDigital on 12/10/21.
//

import Foundation
struct Tools: Codable {
    
    let url : String?
    let title : String?
    let text : String?

    enum CodingKeys: String, CodingKey {

        case url = "url"
        case title = "title"
        case text = "text"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        text = try values.decodeIfPresent(String.self, forKey: .text)
    }

}
