//
//  ProfileHTTPClient.swift
//  Arkus
//
//  Created by Roy Quesada on 9/6/23.
//

import Foundation

class ProfileHTTPClient: ProfileHTTPClientProtocol {
    
    private var urlSession: URLSession
    private var urlString: String
    
    init(urlString: String, urlSession: URLSession = .shared){
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func updateUser(_ userID: String, _ userRequest:UpdateUserRequest, _ token:String,completion: @escaping (Result <UpdateUserResponse?, NetworkError>) -> Void){
        guard let url = URL(string: self.urlString) else {
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
            
            /*guard let userResponse = try? JSONDecoder().decode(UpdateUserResponse.self, from: data) else {
                return completion(.failure(.decodingError))
            }*/
            
            completion(.success(nil))
            
        }.resume()
        
    }
    
}
