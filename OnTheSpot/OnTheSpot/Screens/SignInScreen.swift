//
//  SignInView.swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/16/24.
//

import SwiftUI

struct SignInScreen: View {
    
    @Environment(AuthManager.self) var authManager  // Access the authManager from the environment
    @State private var showingLoginScreen = false   // State variable to control modal presentation
    
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 5) {
                EmailButton()
                GithubButton(action: authManager.signInWithGithub)
            }
            .padding()
            
            HStack {
                Text("Already on OnTheSpot?")
                
                // Button that opens the LoginScreen modally
                Button(action: {
                    showingLoginScreen = true // Show the LoginScreen as a modal
                }) {
                    Text("Login")
                }
            }
            .font(.system(size: 14))
        }
        // Present the LoginScreen modally when showingLoginScreen is true
        .sheet(isPresented: $showingLoginScreen) {
            LoginScreen()
        }
        // Hide the back button and text in the navigation bar
        .navigationBarBackButtonHidden(true)

    }
    
    

}

#Preview {
    SignInScreen()
        .environment(AuthManager()) // <-- For the preview to work, pass an instance of AuthManager into the environment
}
