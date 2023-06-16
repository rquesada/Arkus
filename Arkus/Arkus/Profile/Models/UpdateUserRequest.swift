//
//  UpdateUserRequest.swift
//  Arkus
//
//  Created by Roy Quesada on 9/6/23.
//

import Foundation

struct UpdateUserRequest : Codable{
    let name:String
    let email:String
    let password:String
    let role:String
    let english_level: Int
    let tech_skills:String
    let cv_link:String
}
