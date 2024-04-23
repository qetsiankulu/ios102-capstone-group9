//
//  LoginScreen.swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/17/24.
//

import SwiftUI

struct LoginScreen: View {
    @Environment(AuthManager.self) var authManager  // <-- Access the authManager from the environment
    
    @State private var email: String  = ""
    @State private var password: String  = ""
    
    var body: some View {
        VStack {
            
            Text("Login")
                .font(.largeTitle)
                .bold()
            
            GithubButton(action: authManager.signInWithGithub)
            
            Divider()
            
            
            // Email + password fields
            VStack {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
            }
            .textFieldStyle(.roundedBorder) // <-- Style text fields (applies to both text fields within the VStack)
            .textInputAutocapitalization(.never) // <-- No auto capitalization (can be annoying for emails and passwords)
            .padding(40)
            
            // Sign In the user when the continue button is tapped
            // If the email and password fields are not empty, show an active Continue button
            if !email.isEmpty && !password.isEmpty {
                ActiveContinueButton(action: {
                    // Call the signIn method with captured email and password
                    authManager.signIn(email: email, password: password)
                    
                    // Print a message to the console indicating successful user creation
                    print("User successfully signed in")
                })
            } else {
                DisabledContinueButton()
            }
            
        }
        
    }
}

#Preview {
    LoginScreen()
        .environment(AuthManager()) // <-- For the preview to work, pass an instance of AuthManager into the environment
}
