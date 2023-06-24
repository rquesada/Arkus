//
//  MockLoginHTTPClient.swift
//  ArkusTests
//
//  Created by Roy Quesada on 7/6/23.
//

import Foundation
@testable import Arkus

class MockLoginHTTPClient: LoginHTTPClientProtocol {
    
    var isLoginMethodCalled :Bool = false
    var shouldReturnError : Bool = false
    
    func login(_ loginRequest: Arkus.LoginRequest, completion: @escaping (Result<Arkus.LoginResponse?, Arkus.NetworkError>) -> Void) {
        isLoginMethodCalled = true
        
        if shouldReturnError {
            return completion(.failure(.serverError("Error in Signup process")))
        }else{
            let loginResponse = LoginResponse(success: true, token: UUID().uuidString, role: Roles.common.rawValue, uid: UUID().uuidString)
            return completion(.success(loginResponse))
        }
    }
}
