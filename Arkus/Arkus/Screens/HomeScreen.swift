//
//  HomeScreen.swift
//  Arkus
//
//  Created by Roy Quesada on 5/6/23.
//

import SwiftUI

struct HomeScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var homeVM:HomeViewModel
    @State private var showActionsScreen = false
    @State private var showProfileScreen = false
    let userId = UserCredentials.shared.userId
    let homeHTTPClient = HomeHTTPClient(urlString: URL.forUser(userId: UserCredentials.shared.userId!))
    let token = UserCredentials.shared.token
    init(){
        let homeHTTPClient = HomeHTTPClient(urlString: URL.forUser(userId: userId!))
        homeVM = HomeViewModel(homeHTTPClient)
        self.homeVM.getUserInfo(userId!, token: token!)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("Name:")
                    .bold()
                    .padding(.top, 40)
                Text(self.homeVM.user?.name ?? "")
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                    .padding(.bottom, 5)
                
                Text("Email:")
                    .bold()
                Text(self.homeVM.user?.email ?? "")
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                    .padding(.bottom, 5)
                
                Text("Role:")
                    .bold()
                Text(self.homeVM.user?.role ?? "")
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                    .padding(.bottom, 5)
                
                HStack{
                    Button("Edit Profile"){
                        showProfileScreen = true
                    }
                    .padding()
                    
                    if UserCredentials.shared.isAdmin{
                        Button("More Actions"){
                            showActionsScreen = true
                        }
                        .padding()
                    }
                    
                }.padding()
                Spacer()
                
            }
            .actionSheet(isPresented: $homeVM.showError) {
                ActionSheet(title: Text("Error"),
                            message: Text(homeVM.errorMessage),
                            buttons: [.default(Text("OK"), action: {
                    
                    // If error, logout
                    //presentationMode.wrappedValue.dismiss()
                    
                })])
            }
            .navigationBarItems(trailing: Button("Logout"){
                presentationMode.wrappedValue.dismiss()
            })
            .navigationBarTitle("Welcome")
            .embedInNavigationView()
            if self.homeVM.loadingState == .loading{
                LoadingView()
            }
        }
        .fullScreenCover(isPresented: $showActionsScreen, content: {
            ActionsScreen()
        })
        
        .fullScreenCover(isPresented: $showProfileScreen, content: {
            if let user = self.homeVM.user {
                ProfileScreen(user,onDismiss: {
                    self.homeVM.getUserInfo(userId!, token: token!)
                })
            }else{
                EmptyView() 
                    .onAppear {
                        self.showProfileScreen = false
                    }
            }
        })
    }
    
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
