//
//  SignupViewModelProtocol.swift
//  Arkus
//
//  Created by Roy Quesada on 5/6/23.
//

import Foundation

protocol SignupViewModelProtocol {
    func signup(completion: @escaping (Bool) -> Void)
    func isValidSignup() ->Bool
    func matchPassword(_ password: String, _ repeatPassword: String) -> Bool
}
