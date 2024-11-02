//
//  SignInView.swift
//  UXUIDesigningConcepts
//
//  Created by Muhammad Zeeshan on 01/11/2024.
//

import SwiftUI

struct SignInView: View {
    @FocusState var isActive
    @Binding var email: String
    @Binding var Password: String
    @Binding var Remember: Bool
    @Binding var showSignUp: Bool
    @State var showForgotView = false
    var action: () -> Void
    
    var body: some View {
        VStack(spacing: 45) {
            TopView(text: "Wellcome Back", Detail: "Please Sign up into your account")
            
            EmailTF(title: "Email", text: $email)
            
            VStack {
                PasswordTF(title: "Password", text: $Password)
                Button {
                    
                } label: {
                    Text("Forgot Password ?")
                        .font(.footnote.bold())
                        .tint(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            SignButton(title: "Sign In", action: {})
            
            OrView()
            
            HStack(spacing: 65) {
                LoginWithView(image: "apple.logo", width: 40, height: 40) { }
                LoginWithView(image: "g.square.fill", width: 40, height: 40) { }
            }
            Spacer()
            HStack(spacing: 0) {
                Text("Don't have an account? ")
                    .font(.caption)
                Button {
                    email = ""
                    Password = ""
                    withAnimation {
                        showSignUp.toggle()
                    }
                } label: {
                    Text("Sign Up")
                        .font(.callout.bold())
                }
            }
        }
        .padding()
    }
}

#Preview {
//    SignInView()
    HomeView()
}

// MARK: Header View
struct TopView: View {
    var text: String
    var Detail: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(text)
                .font(.title.bold())
            Text(Detail)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: Info Text Field
struct EmailTF: View {
    var title: String
    @Binding var text: String
    @FocusState var isActive
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text)
                .padding(.leading)
                .frame(maxWidth: .infinity)
                .frame(height: 55).focused($isActive)
                .background(.gray.opacity(0.3), in: .rect(cornerRadius: 16))
            
            Text(title).padding(.leading)
                .foregroundStyle(isActive ? .white : .secondary)
                .offset(y: (isActive || !text.isEmpty) ? -50 : 0)
                .animation(.spring, value: isActive)
        }
    }
}

// MARK: Password Text Field
struct PasswordTF: View {
    var title: String
    @Binding var text: String
    @FocusState var isActive
    @State var showPassword = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            if showPassword {
                TextField("", text: $text)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55).focused($isActive)
                    .background(.gray.opacity(0.3), in: .rect(cornerRadius: 16))
            } else {
                SecureField("", text: $text)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55).focused($isActive)
                    .background(.gray.opacity(0.3), in: .rect(cornerRadius: 16))
            }
            
            Text(title).padding(.leading)
                .foregroundStyle(isActive ? .white : .secondary)
                .offset(y: (isActive || !text.isEmpty) ? -50 : 0)
                .animation(.spring, value: isActive)
        }
        .overlay(alignment: .trailing) {
            Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                .font(.system(size: 15))
                .foregroundStyle(.secondary)
                .offset(x: -10)
                .onTapGesture {
                    if !text.isEmpty {
                        showPassword.toggle()
                    }
                }
        }
    }
}

// MARK: Sign In Butotn
struct SignButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.title2.bold())
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(.primary, in: .rect(cornerRadius: 16))
        }
        .tint(.primary)
    }
}

// MARK: Or View
struct OrView: View {
    var body: some View {
        HStack {
            Rectangle()
                .frame(height: 1.5)
                .foregroundColor(.gray.opacity(0.3))
            Text("or")
            Rectangle()
                .frame(height: 1.5)
                .foregroundColor(.gray.opacity(0.3))
        }
    }
}

// MARK: With Other Logins
struct LoginWithView: View {
    var image: String
    var width: CGFloat
    var height: CGFloat
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .foregroundColor(.primary)
                .frame(width: width, height: height)
                .padding(5)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                }
        }
        .tint(.primary)
    }
}



