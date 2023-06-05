//
//  HomeScreen.swift
//  Arkus
//
//  Created by Roy Quesada on 5/6/23.
//

import SwiftUI

struct HomeScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Home Screen!")
        }.navigationBarItems(trailing: Button("Logout"){
            presentationMode.wrappedValue.dismiss()
        })
        .navigationBarTitle("Welcome")
        .embedInNavigationView()
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
