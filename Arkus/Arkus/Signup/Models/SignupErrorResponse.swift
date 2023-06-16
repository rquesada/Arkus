//
//  SignupErrorResponse.swift
//  Arkus
//
//  Created by Roy Quesada on 2/6/23.
//

import Foundation

struct SignupErrorResponse : Codable {
    let errors:[SignupError]
    
    func errorMessages() -> String {
        return errors.map { $0.msg }.joined(separator: "\n")
    }
}
