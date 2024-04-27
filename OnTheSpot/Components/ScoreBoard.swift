//
//  ScoreBoard.swift
//  OnTheSpot
//
//  Created by Darian Lee on 4/27/24.
//

import SwiftUI

struct ScoreBoard: View {
    
    @State var userRoomManager: UserRoomManager = UserRoomManager()

    var body: some View {
            VStack {
                Text("Score Board")
                    .font(.title)
                    .padding(.top, 20) // Add top padding to the title
                
                ScrollView {
                    ForEach(userRoomManager.scoreBoard.indices, id: \.self) { index in
                        VStack {
                            HStack {
                                Text(userRoomManager.scoreBoard[index].name)
                                    .font(.headline) // Use a larger font for the name
                                    .foregroundColor(.blue) // Change the text color
                                    .padding(.leading, 20) // Add some left padding
                                Spacer()
                                Text(String(userRoomManager.scoreBoard[index].score))
                                    .font(.headline) // Use a larger font for the score
                                    .foregroundColor(.black) // Change the text color
                                    .padding(.trailing, 20) // Add some right padding
                            }
                            .padding(.vertical, 10) // Add vertical padding between rows
                            
                            if index != userRoomManager.scoreBoard.indices.last {
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.gray) // Change the color of the line
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity) // Expand the ScrollView to the full width
            }
            .padding() // Add some padding to the VStack
            .background(Color.gray.opacity(0.1)) // Add a background color to the scoreboard
            .cornerRadius(10) // Apply rounded corners to the scoreboard
        }
    }

#Preview {
    ScoreBoard()
}


