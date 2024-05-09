//
//  AuthManager.swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/17/24.
//

import Foundation
import FirebaseAuth
import AuthenticationServices

@Observable                 // <-- changes in the authentication status of your user to be instantly observable to any view
class AuthManager {
    
    // A property to store the logged in user.  User is an object provided by FirebaseAuth framework
    var user: User?
    
    // an instance of OAuthProvider initialized with "github.com"
    var provider = OAuthProvider(providerID: "github.com")
    
    
    // https://firebase.google.com/docs/auth/ios/start#sign_up_new_users
    func signUp(email: String, password: String) {
        Task {
            do {
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                user = authResult.user    // <-- Set the user
            } catch {
                print (error)
            }
        }
    }
    
    
    func signIn(email: String, password: String) {
        Task {
            do {
                let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
                user = authResult.user  // <-- Set the user
            } catch {
                print(error)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            
            user = nil  // Set user to nil after sign out
            
            print ("The user has been signed out")
            
            
        } catch {
            print(error)
        }
    }
    
    // signs the user in by asking for Github credentials
    func signInWithGithub() {
           provider.getCredentialWith(nil) { credential, error in
               if let error = error {
                   print("Error getting GitHub credential: \(error)")
                   return
               }
               
               if let credential = credential {
                   Auth.auth().signIn(with: credential) { authResult, error in
                       if let error = error {
                           print("Error signing in with GitHub credential: \(error)")
                           return
                       }
                       
                       if let user = authResult?.user {
                           self.user = user
                           
                           
                       }
                   }
               }
           }
       }
    
    
}

