//
//  MoreActionsEnum.swift
//  Arkus
//
//  Created by Roy Quesada on 14/6/23.
//

import Foundation

// Enum representing the menu options
enum MenuOption: String, CaseIterable {
    case managementUsers = "Management Users"
    case managementAccounts = "Management Accounts"
    case movePeople = "Move People"
    case checkMoveLog = "Check Move Log"
    
    var imageName: String {
        switch self {
        case .managementUsers:
            return "person.3.fill"
        case .managementAccounts:
            return "dollarsign.circle.fill"
        case .movePeople:
            return "person.crop.circle.fill"
        case .checkMoveLog:
            return "list.bullet.rectangle.fill"
        }
    }
    
    // Additional properties or methods related to menu options can be added here
}
