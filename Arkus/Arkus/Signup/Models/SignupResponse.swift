//
//  SignupResponse.swift
//  Arkus
//
//  Created by Roy Quesada on 2/6/23.
//

import Foundation

struct SignupResponse : Codable {
    let success:Bool
    let user: User
}
