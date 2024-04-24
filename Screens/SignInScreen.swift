//
//  SignInView.swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/16/24.
//

import SwiftUI

struct SignInScreen: View {
    
    @Environment(AuthManager.self) var authManager  // <-- Access the authManager from the environment
    
    
    var body: some View {
        NavigationStack {
            
            VStack(spacing: 5) {
                EmailButton()
                GithubButton(action: authManager.signInWithGithub)
            }
            .padding()
            
            HStack {
                Text("Already on OnTheSpot?")

                NavigationLink(destination: LoginScreen()){
                    Text("Login")
                        
                }
            }
            .font(.system(size: 14))
        }
    }
}

#Preview {
    SignInScreen()
        .environment(AuthManager()) // <-- For the preview to work, pass an instance of AuthManager into the environment
}
