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
    
    // Temporal information
    @State private var role:String = ""
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var repeatPassword: String = ""
    @State private var englishLevel: Int = 1
    @State private var techSkills: String = ""
    @State private var cvLink: String = ""
    
    //For UI
    @State private var isPasswordVisible = false
    @State private var isRepeatPasswordVisible = false
    
    // For Delete user
    @State private var showConfirmDelete = false
    
    // To save changes
    let token = UserCredentials.shared.token
    
    init(_ user: UserViewModel, onDismiss: (() -> Void)? = nil){
        self.onDismiss = onDismiss
        let profileHTTPClient = ProfileHTTPClient()
        self.user = user
        self.profileVM = ProfileViewModel(profileHTTPClient)
    }
    
    var body: some View {
        
        ZStack {
            Form {
                
                PersonalInformationSection(user: user,
                                           name: $name,
                                           role: $role)
                
                SkillsSection(englishLevel: $englishLevel,
                              techSkills: $techSkills,
                              cvLink: $cvLink)
                
                PasswordSection(password: $password,
                                repeatPassword: $repeatPassword,
                                isPasswordVisible: $isPasswordVisible,
                                isRepeatPasswordVisible: $isRepeatPasswordVisible)
                
                Section {
                    Button(action: {
                        let userRequest = UpdateUserRequest(name: name,
                                                            role: role,
                                                            english_level: englishLevel,
                                                            tech_skills: techSkills,
                                                            cv_link: cvLink)
                        profileVM.updateUser(userRequest, password, repeatPassword, user.id, token!) { success in
                            if success {
                                if let onDismiss = onDismiss {
                                    onDismiss()
                                }
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }) {
                        Text("Save Changes")
                    }
                }
                
                DeleteSection(name: user.name, showConfirmDelete: $showConfirmDelete)
                
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
            self.role = self.user.role
        }
        
        //Sheet for error
        .actionSheet(isPresented: $profileVM.showError) {
            ActionSheet(title: Text("Error"),
                        message: Text(profileVM.errorMessage),
                        buttons: [
                            .default(Text("OK"))])
        }
        
        //Sheet to confirm delete user
        .actionSheet(isPresented: $showConfirmDelete){
            ActionSheet(title: Text("Delete user"),
                        message: Text("Cofirm that you want delete this user"),
                        buttons: [.destructive(Text("Delete"), action: {
                self.profileVM.deleteUser(user.id, token!){ success in
                    if success {
                        if let onDismiss = onDismiss {
                            onDismiss()
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }),
                            .cancel()
                        ])
        }
        .navigationBarTitle("Edit Profile")
        .navigationBarItems(trailing: Button("Back"){
            presentationMode.wrappedValue.dismiss()
        })
        .embedInNavigationView()
        //Show a Loading
        if self.profileVM.loadingState == .loading{
            LoadingView()
        }
    }
}

struct PersonalInformationSection: View {
    
    let user: UserViewModel
    @Binding var name:String
    @Binding var role:String
    
    var body: some View{
        Section(header: Text("Personal Information")) {
            TextField("Name", text: $name)
                .disableAutocorrection(true)
            Text("Email: \(self.user.email)")
            
            // if current user is common or user to edit is SuperAdmin, the changes are not allow
            if UserCredentials.shared.role == .common ||
                user.role == Roles.superAdmin.rawValue {
                Text("Role: \(self.user.role)")
            }else{
                Picker("", selection: self.$role    ) {
                    ForEach(Constants.roles, id: \.self) { role in
                        Text(role).tag(role)
                    }
                }
                .pickerStyle(WheelPickerStyle()) // or .pickerStyle(MenuPickerStyle())
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .padding(.bottom, 15)
            }
        }
    }
}

struct DeleteSection:View{
    var name: String
    @Binding var showConfirmDelete:Bool
    var body: some View {
        Section(header: Text("Delete User")){
            Button(action: {
                showConfirmDelete.toggle()
            }) {
                HStack{
                    
                    Image(systemName: "trash")
                        .font(.title)
                        .foregroundColor(.red)
                    Text(name).foregroundColor(.red)
                }
                
            }
        }
    }
}

struct SkillsSection: View {
    @Binding var englishLevel: Int
    @Binding var techSkills: String
    @Binding var cvLink: String
    
    var body: some View {
        Section(header: Text("Skills")){
            Stepper("English Level: \(englishLevel)", value: $englishLevel, in: 0...5)
            TextField("Tech Skills", text: $techSkills)
            TextField("CV Link", text: $cvLink)
        }
    }
}

struct PasswordSection: View {
    @Binding var password:String
    @Binding var repeatPassword: String
    @Binding var isPasswordVisible: Bool
    @Binding var isRepeatPasswordVisible : Bool
    
    var body: some View {
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
    }
}
