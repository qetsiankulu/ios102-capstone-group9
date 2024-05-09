//
//  UserLoggedInScreen.swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/19/24.
//

import SwiftUI

struct UserLoggedInScreen: View {
    
    @Environment(AuthManager.self) var authManager  // <-- Access the authManager from the environment
    @State private var shouldNavigateToSignIn = false  // State variable to control navigation

    
    var body: some View {
        NavigationStack {
            Text("user is logged in")
                .toolbar {
                     ToolbarItem(placement: .navigationBarTrailing) {
                         Button(action: {
                                        // Call the signOut method
                                        authManager.signOut()
                                        
                                        // Set the state variable to true to trigger navigation
                                        shouldNavigateToSignIn = true
                                    }) {
                                        Text("Sign out")
                                    }
                                }
                            }
                            // Trigger navigation to SignInScreen when shouldNavigateToSignIn is true
                            .navigationDestination(isPresented: $shouldNavigateToSignIn) {
                                SignInScreen()
                            }
                     }
                }
    
    
}

#Preview {
    UserLoggedInScreen()
        .environment(AuthManager()) // <-- For the preview to work, pass an instance of AuthManager into the environment
}
