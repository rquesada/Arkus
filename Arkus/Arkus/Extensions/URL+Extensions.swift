//
//  URL+Extensions.swift
//  Arkus
//
//  Created by Roy Quesada on 31/5/23.
//

import Foundation

extension URL{
    static func forLogin() -> URL?{
        return URL(string: "\(Constants.baseURL)\(Constants.loginEndPoint)")
    }
    
    static func forSignup() -> URL?{
        return URL(string: "\(Constants.baseURL)\(Constants.signupEndPoint)")
    }
}
