//
//  ProfileHTTPClientProtocol.swift
//  Arkus
//
//  Created by Roy Quesada on 9/6/23.
//

import Foundation

protocol ProfileHTTPClientProtocol {
    func updateUser(_ userID: String,
                    _ userRequest:UpdateUserRequest,
                    _ token:String,
                    completion: @escaping (Result <UpdateUserResponse?, NetworkError>) -> Void)
}
