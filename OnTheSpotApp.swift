//
//  OnTheSpotApp.swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/16/24.
//

//import SwiftUI
//import FirebaseCore

//@main
//struct OnTheSpotApp: App {
//    
//    @State private var authManager: AuthManager     // <-- Create a state managed authManager property
//    
//    
//    init() {
//        FirebaseApp.configure()             // <-- Configure Firebase app
//        authManager = AuthManager()         // <-- Initialize the authManager property
//    }
//    
//    
//    var body: some Scene {
//        WindowGroup {
//            if authManager.user != nil{
//                if UserRoomManager().rooms != []{
//                    SubscriptionFeed()
//                }
//                else{
//                    UserMainFeedView()
//                }
//            }
//            else{
//                SignInScreen()
//                    .environment(authManager)   // <-- Pass the authManager into the environment
//            }
//        }
//    }
//}
import SwiftUI
import FirebaseCore

@main
struct OnTheSpotApp: App {
    @StateObject var authManager = AuthManager()

    
    init() {
        FirebaseApp.configure()
        
        
            
        }
        
    
    
    
    var body: some Scene {
        WindowGroup {
            if authManager.user != nil {
     
                    UserMainFeedView()
                        .environmentObject(authManager)
                
            } else {
                SignInScreen()
                    .environmentObject(authManager)
            }
        }
    }
}
