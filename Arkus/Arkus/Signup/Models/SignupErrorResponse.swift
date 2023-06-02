//
//  SignupErrorResponse.swift
//  Arkus
//
//  Created by Roy Quesada on 2/6/23.
//

import Foundation

struct SignupErrorResponse : Decodable {
    let errors:[SignupError]
}
