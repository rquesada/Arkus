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
    
    func updateUser(_ updateUserRequest: UpdateUserRequest, _ userId:String, _ token:String, completion: @escaping (Bool) -> Void){
        if !isValid(updateUserRequest) {
            showError = true
            return completion(true)
        }
        
        self.loadingState = .loading
        
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
    
    
    func isValid(_ updateUserRequest: UpdateUserRequest) -> Bool{
        
        //TODO: Implement it and update error message
        
        return true
    }
}
