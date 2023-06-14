//
//  UserListViewModel.swift
//  Arkus
//
//  Created by Roy Quesada on 14/6/23.
//

import Foundation

class UserListViewModel: ViewModelBase {
    
    @Published var users = [UserResponse]()
    @Published var usersListFull = false
    @Published var errorMessage = ""
    @Published var showError = false
    
    var httpClient:UserListHTTPClient!
    
    init(_ httpClient: UserListHTTPClient){
        self.httpClient = httpClient
    }
    
    func getNextUsers(_ token: String)
    {
        self.loadingState = .loading
        self.httpClient.getUsers(token){ result in 
            switch result {
            case .success(let usersList):
                DispatchQueue.main.async {
                    if let users = usersList?.users{
                        self.usersListFull = users.count < Constants.getUsersPageSize
                        self.users.append(contentsOf: users)
                    }
                    self.loadingState = .none
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = LoginUtils.getMessageError(error)
                    self.showError = true
                    self.loadingState = .none
                }
            }
        }
    }
    
}
