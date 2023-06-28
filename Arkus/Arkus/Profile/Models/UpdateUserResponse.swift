//
//  UpdateUserResponse.swift
//  Arkus
//
//  Created by Roy Quesada on 9/6/23.
//

import Foundation

struct UpdateUserResponse: Codable {
    let name:String
    let email:String
    let role:String
    let status:Bool
    let cv_link:String
    let english_level:Int
    let tech_skills:String
    let updatedAt:String
    let uid:String
}
