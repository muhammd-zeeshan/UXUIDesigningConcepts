//
//  SignUpView.swift
//  UXUIDesigningConcepts
//
//  Created by Muhammad Zeeshan on 01/11/2024.
//

import SwiftUI

struct SignUpView: View {
    @FocusState var isActive
    @Binding var email: String
    @Binding var Password: String
    @Binding var Remember: Bool
    @Binding var showSignIn: Bool
    var action: () -> Void
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

