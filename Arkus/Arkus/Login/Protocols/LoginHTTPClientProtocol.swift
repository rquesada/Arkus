//
//  LoginHTTPClientProtocol.swift
//  Arkus
//
//  Created by Roy Quesada on 7/6/23.
//

import Foundation

protocol LoginHTTPClientProtocol {
    func login(_ loginRequest: LoginRequest, completion: @escaping (Result <LoginResponse?, NetworkError>) -> Void)
}
