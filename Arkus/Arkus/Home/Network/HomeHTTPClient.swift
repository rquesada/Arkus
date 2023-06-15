//
//  HomeHTTPClient.swift
//  Arkus
//
//  Created by Roy Quesada on 7/6/23.
//

import Foundation

class HomeHTTPClient : HomeHTTPClientProtocol {
    private var urlSession: URLSession
    private var urlString: String
    
    init(urlString: String, urlSession: URLSession = .shared){
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func getUserById(_ userID: String, _ token:String,completion: @escaping (Result <User?, NetworkError>) -> Void){
        
        guard let url = URL(string: self.urlString) else {
            return completion(.failure(.badURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(token, forHTTPHeaderField: "Authorization")
        self.urlSession.dataTask(with: request){ data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            guard let userResponse = try? JSONDecoder().decode(User.self, from: data) else {
                return completion(.failure(.decodingError))
            }
            
            completion(.success(userResponse))
            
        }.resume()
        
    }
}
