//
//  SignUpView.swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/16/24.
//

import SwiftUI

struct SignUpScreen: View {
    
    @Environment(AuthManager.self) var authManager  // <-- Access the authManager from the environment 
    
    @State private var email: String  = ""
    @State private var password: String  = ""
    
    var body: some View {
        
        NavigationStack { 
            VStack {                // <-- VStack containing SignUpScreen content
                Text("Sign up")
                    .font(.largeTitle)
                    .bold()
                
                // Email + password fields
                VStack {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                    
                    Text("Password should at least be 6 characters")
                        .foregroundColor(.gray)
                        .font(.system(size: 10))
                        .padding(.top, 10)
                }
                .textFieldStyle(.roundedBorder) // <-- Style text fields (applies to both text fields within the VStack)
                .textInputAutocapitalization(.never) // <-- No auto capitalization (can be annoying for emails and passwords)
                .padding(40)
                
                
                // Sign up the user when the continue button is tapped
                // If the email and password fields are not empty, show an active Continue button
                if !email.isEmpty && !password.isEmpty {
                    ActiveContinueButton(action: {
                        // Call the signUp method with captured email and password
                        authManager.signUp(email: email, password: password)
                        
                        // Print a message to the console indicating successful user creation
                        print("User successfully created in Firebase")
                        
                    })
                } else {
                    DisabledContinueButton()
                }
                
                // Add a spacer to align the content of the SignUpScreen closer to the top
                Spacer()
            }
            .toolbar {
                 ToolbarItem(placement: .navigationBarLeading) {
                     NavBackButton()
                 }
                 ToolbarItem(placement: .navigationBarTrailing) {
                     NavRightButton(destination: LoginScreen(), buttonText: "Login")
                 }
            }
            // Hide the default back button and text in the navigation bar
            .navigationBarBackButtonHidden(true)
        }
    }
}



#Preview {
    SignUpScreen()
        .environment(AuthManager()) // <-- For the preview to work, pass an instance of AuthManager into the environment
}
