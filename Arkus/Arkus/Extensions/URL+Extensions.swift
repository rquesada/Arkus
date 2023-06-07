//
//  URL+Extensions.swift
//  Arkus
//
//  Created by Roy Quesada on 31/5/23.
//

import Foundation

extension URL{
    static func forLogin() -> String{
        return "\(Constants.baseURL)\(Constants.loginEndPoint)"
    }
    
    static func forSignup() -> String{
        return "\(Constants.baseURL)\(Constants.signupEndPoint)"
    }
}
