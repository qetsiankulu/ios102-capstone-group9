//
//  OnTheSpotApp.swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/16/24.
//

import SwiftUI
import FirebaseCore

@main
struct OnTheSpotApp: App {
    
    @State private var authManager: AuthManager     // <-- Create a state managed authManager property
    
    
    init() {
        FirebaseApp.configure()             // <-- Configure Firebase app
        authManager = AuthManager()         // <-- Initialize the authManager property
    }
    
    
    var body: some Scene {
        WindowGroup {
            SignInScreen()
                .environment(authManager)   // <-- Pass the authManager into the environment 
        }
    }
}
