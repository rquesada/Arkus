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
    @State var showProfile = false
    
    init(){
        let httpClient = UserListHTTPClient(urlString: URL.forUser())
        userListVM = UserListViewModel(httpClient)
        if let token = UserCredentials.shared.token
        {
            userListVM.getNextUsers(token)
        }
    }
    
    var body: some View {
        ZStack{
            List(self.userListVM.users){ user in
                Button(action: {
                    self.userListVM.selectedUser = user
                    print("\(user.name)")
                    self.showProfile = true
                }){
                    HStack {
                        Text(user.name)
                        Image(systemName: "chevron.right")
                    }
                }
            }
            if self.userListVM.loadingState == .loading{
                LoadingView()
            }
        }
        .navigationBarItems(leading: Button("Back"){
            presentationMode.wrappedValue.dismiss()
        })
        .navigationBarTitle("Users")
        .embedInNavigationView()
        
        .fullScreenCover(isPresented: $showProfile, content: {
            ProfileScreen(self.userListVM.selectedUser!)
        })
    }
}

struct UserListScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserListScreen()
    }
}
