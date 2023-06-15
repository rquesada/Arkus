//
//  ProfileScreen.swift
//  Arkus
//
//  Created by Roy Quesada on 8/6/23.
//

import SwiftUI

struct ProfileScreen: View {
    
    let onDismiss: (() -> Void)?
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var profileVM:ProfileViewModel
    var user:UserViewModel
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var repeatPassword: String = ""
    @State private var englishLevel: Int = 1
    @State private var techSkills: String = ""
    @State private var cvLink: String = ""
    @State private var isPasswordVisible = false
    @State private var isRepeatPasswordVisible = false
    let userId = UserCredentials.shared.userId
    let token = UserCredentials.shared.token
    
    init(_ user: UserViewModel, onDismiss: (() -> Void)? = nil){
        self.onDismiss = onDismiss
        let profileHTTPClient = ProfileHTTPClient(urlString: URL.forUser(userId: userId!))
        self.user = user
        self.profileVM = ProfileViewModel(profileHTTPClient)
    }
    
    var body: some View {
        
        ZStack {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                        .disableAutocorrection(true)
                    Text("Email: \(self.user.email)")
                    Text("Role: \(self.user.role)")
                }
                
                Section(header: Text("Skills")) {
                    Stepper("English Level: \(englishLevel)", value: $englishLevel, in: 0...5)
                    TextField("Tech Skills", text: $techSkills)
                    TextField("CV Link", text: $cvLink)
                }
                
                Section(header: Text("Password")) {
                    
                    /* Password */
                    HStack(){
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                        }else{
                            SecureField("Password", text: $password)
                        }
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        }
                    }
                    
                    /* Repeat Password */
                    HStack(){
                        if isRepeatPasswordVisible {
                            TextField("Repeat Password", text: $repeatPassword)
                        }else {
                            SecureField("Repeat Password", text: $repeatPassword)
                        }
                        Button(action: {
                            isRepeatPasswordVisible.toggle()
                        }) {
                            Image(systemName: isRepeatPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        }
                    }
                    
                }
                
                Section {
                    Button("Save Changes") {
                        let userRequest = UpdateUserRequest(name: name, email: self.user.email, password: password, role: self.user.role, english_level: englishLevel, tech_skills: techSkills, cv_link: cvLink)
                        self.profileVM.updateUser(userRequest, self.userId!, self.token!){ success in
                            if success {
                                if let onDismiss = onDismiss {
                                    onDismiss()
                                }
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                }
            }
            //Show a Loading
            if self.profileVM.loadingState == .loading{
                LoadingView()
            }
        }
        
        .onAppear(){
            self.name = self.user.name
            self.techSkills = self.user.techSkills ?? ""
            self.englishLevel = self.user.englishLevel ?? 1
            self.cvLink = self.user.cvLink ?? ""
        }
        .navigationBarTitle("Edit Profile")
        .navigationBarItems(trailing: Button("Back"){
            presentationMode.wrappedValue.dismiss()
        })
        .embedInNavigationView()
    }
}
