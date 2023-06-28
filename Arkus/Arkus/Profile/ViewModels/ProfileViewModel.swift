//
//  ProfileViewModel.swift
//  Arkus
//
//  Created by Roy Quesada on 9/6/23.
//

import Foundation

class ProfileViewModel: ViewModelBase {
    var profileHTTPClient: ProfileHTTPClientProtocol
    @Published var errorMessage = ""
    @Published var showError = false
    
    init(_ profileHTTPClient: ProfileHTTPClientProtocol){
        self.profileHTTPClient = profileHTTPClient
    }
    
    func deleteUser(_ userId:String, _ token:String, completion: @escaping (Bool) -> Void){
     
        self.loadingState = .loading
        
        self.profileHTTPClient.deleteUser(userId, token){ result in
            switch result {
            case .success(_):
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
    
    func updateUser(_ updateUserRequest: UpdateUserRequest, _ password:String,  _ repeatPassword:String, _ userId:String, _ token:String, completion: @escaping (Bool) -> Void){
        if !isValid(updateUserRequest, password, repeatPassword) {
            showError = true
            return completion(false)
        }
        
        self.loadingState = .loading
        
        if needUpdatePassword(password, repeatPassword){
            let userPasswordRequest = UpdateUserWithPasswordRequest(name: updateUserRequest.name,
                                                                    role: updateUserRequest.role,
                                                                    english_level: updateUserRequest.english_level,
                                                                    tech_skills: updateUserRequest.tech_skills,
                                                                    cv_link: updateUserRequest.cv_link,
                                                                    password: password)
            
            self.profileHTTPClient.updateUserAndPassword(userId, userPasswordRequest, token) { result in
                switch result {
                case .success(_):
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
        }else{
            self.profileHTTPClient.updateUser(userId, updateUserRequest, token){ result in
                
                switch result {
                case .success(_):
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
    }
    
    
    /// Used to know if user want to change the current password
    /// - Parameters:
    ///   - password: New password
    ///   - repeatPassword: New repeated password
    func needUpdatePassword(_ password:String,  _ repeatPassword:String) -> Bool{
        
        return (!password.isEmpty || !repeatPassword.isEmpty)
        
    }
    
    func isValid(_ updateUserRequest: UpdateUserRequest, _ password:String,  _ repeatPassword:String) -> Bool{
        var returnValue = true
        
        if (needUpdatePassword(password, repeatPassword)){
            if !LoginUtils.isValidPassword(password){
                errorMessage =  "Password is too short"
                returnValue = false
            }
            
            if password != repeatPassword {
                errorMessage =  "Password and repeat password are different"
                returnValue = false
            }
        }
        
        
        return returnValue
    }
}
