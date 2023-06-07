//
//  SignupError.swift
//  Arkus
//
//  Created by Roy Quesada on 2/6/23.
//

import Foundation

struct SignupError : Codable {
    let type:String
    let value: String
    let msg:String
    let path:String
    let location:String
}
