//
//  User.swift
//  Arkus
//
//  Created by Roy Quesada on 2/6/23.
//

import Foundation

struct User : Codable {
    let name:String
    let email:String
    let role:String
    let status:Bool
    let uid:String
}
