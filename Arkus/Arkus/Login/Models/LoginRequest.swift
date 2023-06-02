//
//  LoginRequest.swift
//  Arkus
//
//  Created by Roy Quesada on 1/6/23.
//

import Foundation

struct LoginRequest : Encodable{
    let email: String
    let password: String
}
