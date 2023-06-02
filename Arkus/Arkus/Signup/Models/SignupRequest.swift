//
//  SignupRequest.swift
//  Arkus
//
//  Created by Roy Quesada on 2/6/23.
//

import Foundation

struct SignupRequest : Encodable {
    let name:String
    let email:String
    let password:String
    let role:String

    private enum CodingKeys: String, CodingKey{
        case name = "name"
        case email = "email"
        case password = "password"
        case role = "role"
    }
    
    
}
