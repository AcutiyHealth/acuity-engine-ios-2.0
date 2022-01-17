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
    
    let gender : String?
    let sex : String?
    let ageRange : [Int]?
    
    
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case grade = "grade"
        
        case gender = "gender"
        case sex = "sex"
        case ageRange = "ageRange"
        
    }
    init(id:Int,title:String,grade : String,gender : String,sex : String,ageRange : [Int]){
        self.id = id
        self.title = title
        self.grade = grade
        self.gender = gender
        self.sex = sex
        self.ageRange = ageRange
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        grade = try values.decodeIfPresent(String.self, forKey: .grade)
        
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        sex = try values.decodeIfPresent(String.self, forKey: .sex)
        ageRange = try values.decodeIfPresent([Int].self, forKey: .ageRange)
        
    }
    
}
