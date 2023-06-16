//
//  SignupWebServiceProtocol.swift
//  Arkus
//
//  Created by Roy Quesada on 5/6/23.
//

import Foundation

protocol SignupHTTPClientProtocol {
    func signup(_ signupRequest: SignupRequest, completion: @escaping (Result <SignupResponse?, NetworkError>) -> Void)
}
