//
//  LoginResponse.swift
//  Arkus
//
//  Created by Roy Quesada on 31/5/23.
//

import Foundation

struct LoginResponse : Codable {
    let success:Bool
    let token: String
    let role: String
    let uid: String
}
