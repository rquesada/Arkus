//
//  ProfileHTTPClientProtocol.swift
//  Arkus
//
//  Created by Roy Quesada on 9/6/23.
//

import Foundation

protocol ProfileHTTPClientProtocol {
    
    func deleteUser(_ userID: String,
                    _ token: String,
                    completion: @escaping ( Result<DeleteUserResponse?, NetworkError>) -> Void)
    
    func updateUser(_ userID: String,
                    _ userRequest:UpdateUserRequest,
                    _ token:String,
                    completion: @escaping (Result <UpdateUserResponse?, NetworkError>) -> Void)
    
    func updateUserAndPassword(_ userID: String,
                               _ userRequest:UpdateUserWithPasswordRequest,
                               _ token:String,
                               completion: @escaping (Result <UpdateUserResponse?, NetworkError>) -> Void)
}
