//
//  SignupScreen.swift
//  Arkus
//
//  Created by Roy Quesada on 2/6/23.
//

import SwiftUI

struct SignupScreen: View {
    
    private var httpClient: SignupHTTPClient
    @ObservedObject private var signupVM:SignupViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(){
        httpClient = SignupHTTPClient(urlString: URL.forSignup())
        signupVM = SignupViewModel(httpClient)
    }
    
    var body: some View {
        ZStack {
            VStack(){
                TextField("Name", text: self.$signupVM.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 15)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                TextField("Email", text: self.$signupVM.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: self.$signupVM.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                SecureField("Repeat password", text: self.$signupVM.repeatPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                VStack {
                    Text("Role:")
                        .padding(.top, 0)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                    
                    Picker("", selection: self.$signupVM.role) {
                        ForEach(Constants.roles, id: \.self) { role in
                            Text(role)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                    .padding(.bottom, 15)
                    
                }
                Button("Signup"){
                    self.signupVM.signup(){ success in
                        if success {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            .actionSheet(isPresented: $signupVM.showError) {
                ActionSheet(title: Text("Error"),
                            message: Text(signupVM.errorMessage),
                            buttons: [.default(Text("OK"))])
            }
            .navigationBarTitle("Signup")
            .embedInNavigationView()
            
            
            //Show a Loading
            if self.signupVM.loadingState == .loading{
                LoadingView()
            }
        }
        
    }
}

struct SignupScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignupScreen()
    }
}
