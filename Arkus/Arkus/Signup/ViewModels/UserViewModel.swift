//
//  UserViewModel.swift
//  Arkus
//
//  Created by Roy Quesada on 14/6/23.
//

import Foundation

class UserViewModel: ViewModelBase, Identifiable {
    private var user:User
    
    
    init(user: User) {
        self.user = user
    }
    var userRaw:User {
        user
    }
    
    var id:String {
        user.id
    }
    
    var name:String{
        user.name
    }
    
    var email:String{
        user.email
    }
    
    var role:String{
        user.role
    }
    
    var status:Bool{
        user.status
    }
    
    var cvLink:String?{
        user.cvLink
    }
    
    var englishLevel:Int?{
        user.englishLevel
    }
    
    var techSkills:String?{
        user.techSkills
    }
    
    var updatedAt:String?{
        user.updatedAt
    }
    
    var createdAt:String?{
        user.createdAt
    }
    
    var team:String?{
        user.team
    }
}
