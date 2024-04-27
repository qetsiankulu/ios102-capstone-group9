//
//  UserMainFeedView.swift
//  OnTheSpot
//
//  Created by Darian Lee on 4/21/24.
//

import SwiftUI

struct UserMainFeedView: View {
    @Environment(AuthManager.self) var authManager
    @State var userRoomManager: UserRoomManager
    let veryLightGrey = Color(red: 0.9, green: 0.9, blue: 0.9)
    @State private var isScoreBoardPresented = false
    
    
    
    init() {
        
        
        
        
        self.userRoomManager = UserRoomManager()
        
    }
    
    
    @State private var isSubscriptionFeedPresented = false
    
    
    @State private var isSignInScreenPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                if userRoomManager.rooms != [] {
                    ScrollView {
                        ForEach(userRoomManager.rooms) { room in
                            
                            MainFeedRow(room: room, subscriptionView: false, alreadyThere: nil)
                                .padding()
                            
                        }
                    }
                    .background(veryLightGrey)
                } else {
                    Text("No rooms yet")
                }
                Spacer()
                HStack{
                    Text("Life time score: " + String(userRoomManager.lifetimescore))
                        .bold()
                        .padding(.horizontal)
                    Button(action: {
                                        // Navigate to ScoreBoard()
                                        isScoreBoardPresented = true // Declare isScoreBoardPresented as @State variable
                                    }) {
                                        Text("See Score Board")
                                    }
                                    .sheet(isPresented: $isScoreBoardPresented) {
                                        ScoreBoard()
                                    }
                                }
                            }

            .navigationBarTitle("", displayMode: .inline) // Hide the navigation title
            .navigationBarBackButtonHidden(true) // Hide the back button
            .navigationBarItems(
                leading:
                    Button(action: {
           
                        authManager.signOut()
                        
                       
                        isSignInScreenPresented = true
                    }) {
                        Text("Sign out")
                    },
                trailing:
                    Button(action: {
                        
                        
                      
                        isSubscriptionFeedPresented = true
                    }) {
                        Text("Manage Rooms")
                    }
                    
            )
            .overlay(
                NavigationLink(
                    destination: SubscriptionFeed(),
                    isActive: $isSubscriptionFeedPresented
                ) {
                    EmptyView()
                }
                    .buttonStyle(PlainButtonStyle())
            )
        }
        .environmentObject(authManager)
        .sheet(isPresented: $isSignInScreenPresented) {
            SignInScreen()
                .navigationBarBackButtonHidden(true) // Hide the back button
        }
    }
}

#Preview {
    UserMainFeedView()
        .environment(AuthManager())
}
