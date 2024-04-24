//
//  UserMainFeedView.swift
//  OnTheSpot
//
//  Created by Darian Lee on 4/21/24.
//

import SwiftUI

struct UserMainFeedView: View{
    
    @Environment(AuthManager.self) var authManager  // <-- Access the authManager from the environment
    @ObservedObject var userRoomManager = UserRoomManager()
    let veryLightGrey = Color(red: 0.9, green: 0.9, blue: 0.9)

    
    var body: some View{
        VStack{
            Text("Your Rooms:")
                .font(.title)
                .fontWeight(.bold)
                .frame(width: 350, height: 30, alignment: .topLeading)
            ScrollView{
                ForEach(userRoomManager.rooms) { room in
                    MainFeedRow(room: room, personal: false)
                        .padding()
                }
                
                
            }
            
            
                
            .background(veryLightGrey)
        }
        
    }
}

#Preview {
    UserMainFeedView()
        .environment(AuthManager())
}
