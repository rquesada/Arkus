//
//  HomeHTTPClientProtocol.swift
//  Arkus
//
//  Created by Roy Quesada on 7/6/23.
//

import Foundation


protocol HomeHTTPClientProtocol {
    func getUserById(_ userID: String, _ token:String,completion: @escaping (Result <User?, NetworkError>) -> Void)
}
