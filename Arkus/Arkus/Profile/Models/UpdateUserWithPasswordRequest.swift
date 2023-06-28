//
//  UpdateUserWithPasswordRequest.swift
//  Arkus
//
//  Created by Roy Quesada on 27/6/23.
//

import Foundation

struct UpdateUserWithPasswordRequest : Codable{
    let name:String
    let role:String
    let english_level: Int
    let tech_skills:String
    let cv_link:String
    let password:String
}
