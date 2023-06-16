//
//  ContentView.swift
//  Arkus
//
//  Created by Roy Quesada on 31/5/23.
//

import SwiftUI

struct LoginScreen: View {
    
    private var loginHTTPClient: LoginHTTPClient
    @ObservedObject private var loginVM:LoginViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showSignup: Bool = false
    @State private var showHomeScreen = false

    
    init(){
        loginHTTPClient = LoginHTTPClient(urlString: URL.forLogin())
        loginVM = LoginViewModel(loginHTTPClient)
    }
    
    var body: some View {
        ZStack {
            
            VStack() {
                Image("arkus")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.top, 40)
                TextField("First Name", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button("Login") {
                    self.loginVM.login(email, password){ success in
                        showHomeScreen = success
                    }
                }
                Spacer()
            }
            .padding()
            .onAppear(){
                #if DEBUG
                self.email = "rquesada@arkusnexus.com"
                self.password = "hola123"
                #endif
            }
            
            .actionSheet(isPresented: $loginVM.showError) {
                ActionSheet(title: Text("Error"),
                            message: Text(loginVM.errorMessage),
                            buttons: [.default(Text("OK"))])
            }
            .sheet(isPresented: $showSignup){
                SignupScreen()
            }
            .navigationBarItems(trailing: Button("Signup"){
                self.showSignup = true
            })
            .embedInNavigationView()
            
            //Show a Loading
            if self.loginVM.loadingState == .loading{
                LoadingView()
            }
        }
        .fullScreenCover(isPresented: $showHomeScreen, content: {
            HomeScreen()
        })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
