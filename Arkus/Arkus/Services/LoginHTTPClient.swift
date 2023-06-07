//
//  LoginHTTPClient.swift
//  Arkus
//
//  Created by Roy Quesada on 5/6/23.
//

import Foundation

class LoginHTTPClient{
    
    private var urlSession: URLSession
    private var urlString: String
    
    init(urlString: String, urlSession: URLSession = .shared){
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    /// Send a LoginRequest to server
    /// - Parameters:
    ///   - loginRequest: Request with user information
    ///   - completion: Block to excecute after finish
    func login(_ loginRequest: LoginRequest, completion: @escaping (Result <LoginResponse?, NetworkError>) -> Void){
        guard let url = URL(string: self.urlString) else {
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
}
