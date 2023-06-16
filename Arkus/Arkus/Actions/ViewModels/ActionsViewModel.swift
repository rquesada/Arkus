//
//  ActionsViewModel.swift
//  Arkus
//
//  Created by Roy Quesada on 14/6/23.
//

import Foundation

class ActionsViewModel: ViewModelBase {
    @Published var showUserList = false
    
    func menuOptionSelected(_ option: MenuOption){
        switch option {
        case .managementUsers:
            // Handle Management Users option
            print("Management Users selected")
            self.showUserList = true
        case .managementAccounts:
            // Handle Management Accounts option
            print("Management Accounts selected")
        case .movePeople:
            // Handle Move People option
            print("Move People selected")
        case .checkMoveLog:
            // Handle Check Move Log option
            print("Check Move Log selected")
        }
        
    }
}
