//
//  SignupViewModel.swift
//  Arkus
//
//  Created by Roy Quesada on 2/6/23.
//

import Foundation

class SignupViewModel: ViewModelBase, SignupViewModelProtocol {
    
    @Published var errorMessage = ""
    @Published var showError = false
    
    var name:String = ""
    var email:String = ""
    var role:String = Roles.common.rawValue
    var password:String = ""
    var repeatPassword:String = ""
    var signupHTTPClient: SignupHTTPClientProtocol
    
    init(_ signupHTTPClient: SignupHTTPClientProtocol){
        self.signupHTTPClient = signupHTTPClient
    }
    
    func signup(completion: @escaping (Bool) -> Void){
        
        if !isValidSignup(){
            showError = true
            return completion(false)
        }
        
        self.loadingState = .loading
        let signupRequest = SignupRequest(name: name, email: email, password: password, role: role)
        signupHTTPClient.signup(signupRequest) { result in
            switch result {
            case .success( _):
                DispatchQueue.main.async {
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
    
    /// Validate the signup form
    /// - Returns: Return true if the form is OK
    func isValidSignup() ->Bool {
        var returnValue = true
        if name.isEmpty {
            errorMessage =  "Name can not be empty"
            returnValue = false
        }else if !LoginUtils.isValidEmail(email) {
            errorMessage =  "Invalid email format"
            returnValue = false
        }else if !LoginUtils.isValidPassword(password){
            errorMessage =  "Password is too short"
            returnValue = false
        }else if !matchPassword(password, repeatPassword){
            errorMessage =  "Passwords doesn't match"
            returnValue = false
        }
        return returnValue
    }
    
    /// Validate password and repeat password match
    /// - Parameters:
    ///   - password: password user
    ///   - repeatPassword: repeat password user
    /// - Returns: true if password are equal
    func matchPassword(_ password: String, _ repeatPassword: String) -> Bool{
        return password == repeatPassword
    }
}
