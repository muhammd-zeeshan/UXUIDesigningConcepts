//
//  HomeView.swift
//  UXUIDesigningConcepts
//
//  Created by Muhammad Zeeshan on 01/11/2024.
//

import SwiftUI

struct HomeView: View {
    @State var email = ""
    @State var Password = ""
    @State var Remember = false
    @State var showSignUp = false
    
    var body: some View {
        ScrollView {
            if showSignUp {
                SignUpView(email: $email, Password: $Password, Remember: $Remember, showSignIn: $showSignUp) {}
                    .transition(.asymmetric(insertion: .move(edge: .trailing),
                                            removal: .move(edge: .trailing)))
            } else {
                SignInView(email: $email, Password: $Password, Remember: $Remember, showSignUp: $showSignUp) {}
                    .transition(.asymmetric(insertion: .move(edge: .leading),
                                            removal: .move(edge: .leading)))
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    HomeView()
}
