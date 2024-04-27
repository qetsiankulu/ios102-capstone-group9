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
        Text("OnTheSpot")
            .font(.largeTitle)
            .bold()
        
        NavigationStack {
            VStack(spacing: 5) {
                FeatureCarousel()
                    .padding(.bottom, 70)
                
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
            
            Spacer()
        }
        // Present the LoginScreen modally when showingLoginScreen is true
        .sheet(isPresented: $showingLoginScreen) {
            LoginScreen()
        }
        // Hide the back button and text in the navigation bar
        .navigationBarBackButtonHidden(true)

    }
    
}
