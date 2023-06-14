//
//  UserResponse.swift
//  Arkus
//
//  Created by Roy Quesada on 8/6/23.
//

import Foundation

struct UserResponse : Decodable, Identifiable {
    let id:String
    let name:String
    let email:String
    let role:String
    let status:Bool
    let cvLink:String?
    let englishLevel:Int?
    let techSkills:String?
    let updatedAt:String?
    let createdAt: String?
    let team:String?
    
    private enum CodingKeys: String, CodingKey {
        case name, email, role, status, updatedAt, createdAt, team
        case id = "uid"
        case cvLink = "cv_link"
        case englishLevel = "english_level"
        case techSkills = "tech_skills"
        
    }
}

