//
//  MockSignupWebService.swift
//  ArkusTests
//
//  Created by Roy Quesada on 5/6/23.
//

import Foundation
@testable import Arkus

class MockSignupHTTPClient : SignupHTTPClientProtocol {
    
    var isSignupMethodCalled :Bool = false
    var shouldReturnError : Bool = false
    
    func signup(_ signupRequest: SignupRequest, completion: @escaping (Result <SignupResponse?, NetworkError>) -> Void){
        isSignupMethodCalled = true
        
        if shouldReturnError {
            return completion(.failure(.serverError("Error in Signup process")))
        }else{
            let user = User(name: signupRequest.name,
                            email: signupRequest.name,
                            role: signupRequest.role,
                            status: true,
                            uid: UUID().uuidString)
            let signupResponse = SignupResponse(success: true, user: user)
            completion(.success(signupResponse))
        }
    }
    
}
