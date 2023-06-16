//
//  LoginViewModel.swift
//  Arkus
//
//  Created by Roy Quesada on 31/5/23.
//

import Foundation

class LoginViewModel: ViewModelBase, LoginViewModelProtocol {
    
    @Published var errorMessage = ""
    @Published var showError = false
    @Published var login:LoginResponse?
    @Published var loginSuccess = false
    
    var loginHTTPClient: LoginHTTPClientProtocol
    
    init(_ loginHTTPClient: LoginHTTPClientProtocol){
        self.loginHTTPClient = loginHTTPClient
    }
    
    
    /// Method to try to login a user
    /// - Parameters:
    ///   - username: Email of the user
    ///   - password: Password of the user
    func login(_ email:String, _ password:String, completion:@escaping (Bool) -> Void){
        
        if !isValidLogin(email, password){
            self.showError = true
            return completion(false)
        }

        self.loadingState = .loading
        let loginRequest = LoginRequest(email: email, password: password)
        self.loginHTTPClient.login(loginRequest){ result in
            switch result {
            case .success(let loginResponse):
                DispatchQueue.main.async {
                    if let login = loginResponse {
                        UserCredentials.shared.setUserCredentials(login)
                    }
                    self.loginSuccess = true
                    self.login = loginResponse
                    self.loadingState = .none
                    completion(true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = LoginUtils.getMessageError(error)
                    self.showError = true
                    self.loadingState = .none
                    completion(false)
                }
            }
        }
    }
    
    
    /// Validate the login form
    /// - Parameters:
    ///   - email: Email of the user
    ///   - password: Password of the user
    /// - Returns: True if is valid login data
    func isValidLogin(_ email:String, _ password:String) ->Bool {
        var returnValue = true
        if !LoginUtils.isValidEmail(email) {
            errorMessage =  "Invalid email format"
            returnValue = false
        } else if !LoginUtils.isValidPassword(password){
            errorMessage =  "Password is too short"
            returnValue = false
        }
        return returnValue
    }
}
