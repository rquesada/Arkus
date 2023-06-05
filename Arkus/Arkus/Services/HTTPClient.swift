//
//  HTTPClient.swift
//  Arkus
//
//  Created by Roy Quesada on 31/5/23.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
    case serverError(String)
}

class HTTPClient {
    
    /// Send a LoginRequest to server
    /// - Parameters:
    ///   - loginRequest: Request with user information
    ///   - completion: Block to excecute after finish
    func login(_ loginRequest: LoginRequest, completion: @escaping (Result <LoginResponse?, NetworkError>) -> Void){
        guard let url = URL.forLogin() else {
            return completion(.failure(.badURL))
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(loginRequest)
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                guard let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) else {
                    return completion(.failure(.decodingError))
                }
                return completion(.failure(.serverError(errorResponse.msg)))
            }
            return completion(.success(loginResponse))
        }.resume()
    }
    
    func signup(_ signupRequest: SignupRequest, completion: @escaping (Result <SignupResponse?, NetworkError>) -> Void){
        guard let url = URL.forSignup() else {
            return completion(.failure(.badURL))
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(signupRequest)
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            guard let signupResponse = try? JSONDecoder().decode(SignupResponse.self, from: data) else {
                guard let signupErrorResponse = try? JSONDecoder().decode(SignupErrorResponse.self, from: data) else {
                    return completion(.failure(.decodingError))
                }
                return completion(.failure(.serverError(signupErrorResponse.errorMessages())))
            }
            return completion(.success(signupResponse))
        }.resume()
    }
}
