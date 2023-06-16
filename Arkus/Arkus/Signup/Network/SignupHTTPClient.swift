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

class SignupHTTPClient: SignupHTTPClientProtocol {
    
    private var urlSession: URLSession
    private var urlString: String
    
    init(urlString: String, urlSession: URLSession = .shared){
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    /// Call endpoint to try signup USer
    /// - Parameters:
    ///   - signupRequest: User signup request
    ///   - completion: Clousoure to excecute at the end of the signup
    func signup(_ signupRequest: SignupRequest, completion: @escaping (Result <SignupResponse?, NetworkError>) -> Void){
        guard let url = URL(string: self.urlString) else {
            return completion(.failure(.badURL))
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(signupRequest)
        urlSession.dataTask(with: request){ data, response, error in
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
