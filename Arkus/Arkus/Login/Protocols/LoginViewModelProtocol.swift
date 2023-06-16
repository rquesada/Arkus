//
//  LoginViewModelProtocol.swift
//  Arkus
//
//  Created by Roy Quesada on 7/6/23.
//

import Foundation

protocol LoginViewModelProtocol{
    func login(_ email:String, _ password:String, completion:@escaping (Bool) -> Void)
    func isValidLogin(_ email:String, _ password:String) ->Bool
}
