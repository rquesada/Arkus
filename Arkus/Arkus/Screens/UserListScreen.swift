//
//  UserListScreen.swift
//  Arkus
//
//  Created by Roy Quesada on 14/6/23.
//

import SwiftUI

struct UserListScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var userListVM:UserListViewModel
    
    init(){
        let httpClient = UserListHTTPClient(urlString: URL.forUser())
        userListVM = UserListViewModel(httpClient)
        if let token = UserCredentials.shared.token
        {
            userListVM.getNextUsers(token)
        }
    }
    
    var body: some View {
        
        VStack{
            List{
                ForEach(self.userListVM.users) { user in
                    Text(user.name)
                    
                }
            }
        }
        .navigationBarItems(leading: Button("Back"){
            presentationMode.wrappedValue.dismiss()
        })
        .navigationBarTitle("Users")
        .embedInNavigationView()
    }
}

struct UserListScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserListScreen()
    }
}
