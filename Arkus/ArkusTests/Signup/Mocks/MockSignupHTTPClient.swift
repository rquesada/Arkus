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
            
            let user = User(id: UUID().uuidString,
                            name: signupRequest.name,
                            email: signupRequest.email,
                            role: signupRequest.role,
                            status: true,
                            cvLink: nil,
                            englishLevel: nil,
                            techSkills: nil,
                            updatedAt: nil,
                            createdAt: nil,
                            team: nil)
            let signupResponse = SignupResponse(success: true, user: user)
            completion(.success(signupResponse))
        }
    }
    
}
