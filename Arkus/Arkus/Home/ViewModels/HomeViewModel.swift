//
//  HomeViewModel.swift
//  Arkus
//
//  Created by Roy Quesada on 7/6/23.
//

import Foundation

class HomeViewModel : ViewModelBase {
    
    var homeHTTPClient: HomeHTTPClientProtocol
    @Published var errorMessage = ""
    @Published var showError = false
    @Published var user:UserViewModel?
    
    init(_ homeHTTPClient: HomeHTTPClientProtocol){
        self.homeHTTPClient = homeHTTPClient
    }
    
    func getUserInfo(_ userID:String, token: String){
        self.loadingState = .loading
        
        self.homeHTTPClient.getUserById(userID, token){ result in
            switch result {
            case .success(let userReponse):
                DispatchQueue.main.async {
                    if let user = userReponse{
                        self.user = UserViewModel(user: user)
                    }
                    self.loadingState = .none
                }
                
            case .failure(let error ):
                DispatchQueue.main.async {
                    self.errorMessage = LoginUtils.getMessageError(error)
                    self.showError = true
                    self.loadingState = .none
                }
            }
        }
    }
}
