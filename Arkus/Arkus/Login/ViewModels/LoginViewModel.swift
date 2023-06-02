//
//  LoginViewModel.swift
//  Arkus
//
//  Created by Roy Quesada on 31/5/23.
//

import Foundation

class LoginViewModel: ViewModelBase {
    
    @Published var errorMessage = ""
    @Published var showError = false
    @Published var login:LoginResponse?
    @Published var loginSuccess = false
    
    /// Method to try to login a user
    /// - Parameters:
    ///   - username: Email of the user
    ///   - password: Password of the user
    func login(_ email:String, _ password:String){
        
        if !isValidLogin(email, password){
            self.showError = true
            return
        }
        
        let loginRequest = LoginRequest(email: email, password: password)
        
        self.httpClient.login(loginRequest){ result in
            switch result {
            case .success(let login):
                DispatchQueue.main.async {
                    self.loginSuccess = true
                    self.login = login
                    self.loadingState = .success
                    
                    //TODO: Remove it after presentation #1
                    self.errorMessage = "Success Login!!!!!"
                    self.showError = true
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = self.getMessageError(error)
                    self.showError = true
                    self.loadingState = .failed
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
    
    
    /// Convert a NetworkError in string
    /// - Parameter error: The type of error to convert
    /// - Returns: String with error description
    func getMessageError(_ error: NetworkError) -> String{
        switch error {
        case .badURL:
            return "Wrong url"
        case .decodingError:
            return "Deconding retuned data"
        case .noData:
            return "No data returned"
        case .serverError:
            return "Incorrect email or password"
        }
    }
}
