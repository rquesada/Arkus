//
//  ProfileHTTPClient.swift
//  Arkus
//
//  Created by Roy Quesada on 9/6/23.
//

import Foundation

class ProfileHTTPClient: ProfileHTTPClientProtocol {
    
    private var urlSession: URLSession
    
    init(urlSession: URLSession = .shared){
        self.urlSession = urlSession
    }
    
    func deleteUser(_ userID: String, _ token: String, completion: @escaping ( Result<DeleteUserResponse?, NetworkError>) -> Void){
        guard let url = URL(string: URL.forUser( userId: userID )) else {
            return completion(.failure(.badURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        self.urlSession.dataTask(with: request){ data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            guard let userResponse = try? JSONDecoder().decode(DeleteUserResponse.self, from: data) else {
                guard let signupErrorResponse = try? JSONDecoder().decode(SignupErrorResponse.self, from: data) else {
                    return completion(.failure(.decodingError))
                }
                return completion(.failure(.serverError(signupErrorResponse.errorMessages())))
            }
            
            completion(.success(userResponse))
            
        }.resume()
    }
    
    func updateUser(_ userID: String, _ userRequest:UpdateUserRequest, _ token:String,completion: @escaping (Result <UpdateUserResponse?, NetworkError>) -> Void){
        guard let url = URL(string: URL.forUser( userId: userID )) else {
            return completion(.failure(.badURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(userRequest)
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        self.urlSession.dataTask(with: request){ data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            guard let userResponse = try? JSONDecoder().decode(UpdateUserResponse.self, from: data) else {
                guard let signupErrorResponse = try? JSONDecoder().decode(SignupErrorResponse.self, from: data) else {
                    return completion(.failure(.decodingError))
                }
                return completion(.failure(.serverError(signupErrorResponse.errorMessages())))
            }
            
            completion(.success(userResponse))
            
        }.resume()
        
    }
    
    
    func updateUserAndPassword(_ userID: String, _ userRequest:UpdateUserWithPasswordRequest, _ token:String,completion: @escaping (Result <UpdateUserResponse?, NetworkError>) -> Void){
        guard let url = URL(string: URL.forUser( userId: userID )) else {
            return completion(.failure(.badURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(userRequest)
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        self.urlSession.dataTask(with: request){ data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            guard let userResponse = try? JSONDecoder().decode(UpdateUserResponse.self, from: data) else {
                guard let signupErrorResponse = try? JSONDecoder().decode(SignupErrorResponse.self, from: data) else {
                    return completion(.failure(.decodingError))
                }
                return completion(.failure(.serverError(signupErrorResponse.errorMessages())))
            }
            
            completion(.success(userResponse))
            
        }.resume()
        
    }
}
