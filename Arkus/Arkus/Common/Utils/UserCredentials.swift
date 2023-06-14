//
//  UserCredentials.swift
//  Arkus
//
//  Created by Roy Quesada on 8/6/23.
//

import Foundation

class UserCredentials{
    static let shared = UserCredentials()

    var token: String?
    var userId: String?
    var role: String?
    
    private init() {}
    
    func setUserCredentials(_ login: LoginResponse){
        if login.success {
            self.token = login.token
            self.userId = login.uid
            self.role = login.role
        }
        
    }
}

