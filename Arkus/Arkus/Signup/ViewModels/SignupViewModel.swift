//
//  SignupViewModel.swift
//  Arkus
//
//  Created by Roy Quesada on 2/6/23.
//

import Foundation

class SignupViewModel: ViewModelBase {
    
    @Published var errorMessage = ""
    @Published var showError = false
    
    var name:String = ""
    var email:String = ""
    var role:String = "Common"
    var password:String = ""
    var repeatPassword:String = ""
    
    /// Try to signup a new user 
    func signup(){
        if !isValidSignup(){
            showError = true
            return
        }
        
        let signupRequest = SignupRequest(name: name, email: email, password: password, role: role)
    }
    
    
    /// Validate the signup form
    /// - Returns: Return true if the form is OK
    func isValidSignup() ->Bool {
        var returnValue = true
        if !LoginUtils.isValidEmail(email) {
            errorMessage =  "Invalid email format"
            returnValue = false
        }else if !LoginUtils.isValidPassword(password){
            errorMessage =  "Password is too short"
            returnValue = false
        }else if !LoginUtils.matchPassword(password, repeatPassword){
            errorMessage =  "Passwords doesn't match"
            returnValue = false
        }
        return returnValue
    }
}
