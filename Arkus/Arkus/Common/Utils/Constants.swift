//
//  Constants.swift
//  Arkus
//
//  Created by Roy Quesada on 31/5/23.
//

import Foundation

struct Constants {
    
    //Login + Signup
    static let roles = ["COMMON","ADMIN"]
    static let nameMinLength = 3
    static let passwordMinLength = 5
    static let baseURL = "https://mind.asalcido.com/api/v1/"
    static let loginEndPoint = "auth/sign-in"
    static let signupEndPoint = "auth/sign-up"
    static let userEndPoint = "users/"
    static let getUsersPageSize = 10
}
