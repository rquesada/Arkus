//
//  ActionsScreen.swift
//  Arkus
//
//  Created by Roy Quesada on 8/6/23.
//

import SwiftUI

struct ActionsScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    let menuOptions = MenuOption.allCases
    @ObservedObject private var actionsVM = ActionsViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(menuOptions, id: \.self) { option in
                
                Button(action: {
                    actionsVM.menuOptionSelected(option)
                }){
                    HStack(spacing: 10) {
                        Image(systemName: option.imageName)
                            .foregroundColor(.blue)
                            .font(.title)
                        Text(option.rawValue)
                            .font(.headline)
                    }
                }
                
            }
            Spacer()
        }
        
        .navigationBarItems(leading: Button("Back"){
            presentationMode.wrappedValue.dismiss()
        })
        .navigationBarTitle("Admin Actions")
        .embedInNavigationView()
        
        .fullScreenCover(isPresented: self.$actionsVM.showUserList, content: {
            UserListScreen()
        })
    }
}

struct ActionsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ActionsScreen()
    }
}
