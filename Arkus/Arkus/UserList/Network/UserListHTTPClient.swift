//
//  UserListHTTPClient.swift
//  Arkus
//
//  Created by Roy Quesada on 14/6/23.
//

import Foundation

let pageSize = 20

class UserListHTTPClient {
    
    private var offset = 0
    private var urlSession: URLSession
    private var urlString: String
    
    init(urlString: String, urlSession: URLSession = .shared){
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func getUsers(_ token:String, completion: @escaping (Result<UserList?, NetworkError>) -> Void){
        
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
            
            guard let userList = try? JSONDecoder().decode(UserList.self, from: data) else {
                return completion(.failure(.decodingError))
            }
            
            completion(.success(userList))
            
        }.resume()
    }
}
