//
//  ContentView.swift
//  Arkus
//
//  Created by Roy Quesada on 31/5/23.
//

import SwiftUI

struct LoginScreen: View {
    
    private var httpClient: HTTPClient
    @ObservedObject private var loginVM:LoginViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showSignup: Bool = false
    
    init(){
        httpClient = HTTPClient()
        loginVM = LoginViewModel(httpClient)
    }
    
    var body: some View {
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
                loginVM.login(email, password)
            }
            Spacer()
        }
        .padding()
        
        .actionSheet(isPresented: $loginVM.showError) {
            ActionSheet(title: Text("Error"),
                        message: Text(loginVM.errorMessage),
                        buttons: [.default(Text("OK"))])
        }
        .onAppear(){
            //TODO: Remove after finish
            #if DEBUG
            email = "rquesada@arkusnexus.com"
            password = "hola123"
            #endif
        }
        .sheet(isPresented: $showSignup){
            SignupScreen()
        }
        .navigationBarItems(trailing: Button("Signup"){
            self.showSignup = true
        })
        .embedInNavigationView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
