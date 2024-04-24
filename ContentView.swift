//
//  ContentView.swift
//  mathApp
//
//  Created by Darian Lee on 4/9/24.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "plus")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}



struct Room{
    var name: String
    var code: String
    var members: [User]
    var leader: User
    var currentQuestion: Question
    var emoji: String


    }

struct UserRoomSettings: Identifiable{
    var id: String // will be room.code
    
    var user: User
    var room: Room
    var isLeader: Bool
    var anwseredYet: Bool = false
    
    
}
struct User{
    var userrooms: [Room]
    var username: String


}
    
struct Answer{
    var caption: String
    var user: User
    var createdAt: Date
        //  var photo: Photo
}
struct Question{
    var question: String
    var date: Date
    var answers: [Answer]
}
struct QuestionStack{
var stack: [Question]
}

private func generateMockRoom() -> Room {
    var user1 = User(userrooms: [], username: "KOLYA_IS_DINOSUAR")
    var user2 = User(userrooms: [], username: "JORAH_IS_BIGGER_DINOSUAR")
    let question = Question(question: "What is the main idea behind implicit differentiation?", date: Date(), answers: [Answer(caption: "From my understanding the main idea is that you are treating y as a function of x rather than a constant, so y' will give you the rate of change of y with respect to x at that point", user: user2, createdAt: Date())])
    
    let mockRoom = Room(name: "Calculus Room", code: "calc1", members: [user1, user2], leader: user1, currentQuestion: question, emoji: "🧑‍🏫")
        return mockRoom
    }


struct MainFeedRow: View{
    var isMocked: Bool
    var userRoomSettings: UserRoomSettings?
    var user2 = User(userrooms: [], username: "JORAH_IS_BIGGER_DINOSUAR")
    init(isMocked: Bool = false,  userRoomSettings: UserRoomSettings? = nil){
        self.isMocked = isMocked
        if isMocked == true{
            let room = generateMockRoom()
            self.userRoomSettings = UserRoomSettings(id: room.code, user: user2, room: room, isLeader: false, anwseredYet: true)
        }
        else{
            self.userRoomSettings = userRoomSettings
        }
    }
    let veryLightGrey = Color(red: 0.9, green: 0.9, blue: 0.9)
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                if let room = userRoomSettings?.room {
                    Text(room.emoji)
                        .font(.system(size: 60))
                        .multilineTextAlignment(.leading)
                    
                    VStack(alignment: .leading) {
                        Text("") //to make the layout right (both padding and spacer are too big
                        Text(room.name)
                                .bold()
                                .multilineTextAlignment(.leading)
                            
                            Text("members: " + String(room.members.count))
                                .multilineTextAlignment(.leading)
                            
                    }
                    
                }
                    
            }
            
            .frame(width: 350, height: 80, alignment: .topLeading)
            .frame(width: geometry.size.width - 2, alignment: .center) // Extend the width of the row to the screen width
            .background(Color.white) // Set background color for the entire HStack
            .cornerRadius(10) // Round edges of the HStack
            .frame(maxWidth: .infinity)
            //.padding()
            
        }
        .padding(.vertical, 20)
        
        
    }
}
    



struct MainFeed: View{
    let veryLightGrey = Color(red: 0.9, green: 0.9, blue: 0.9)
    var rooms: [UserRoomSettings]
    var body: some View{
        VStack{
            Text("Your Rooms:")
                .font(.title)
                .fontWeight(.bold)
                .frame(width: 350, height: 30, alignment: .topLeading)
            ScrollView{
                ForEach(rooms) { room in
                    MainFeedRow(userRoomSettings: room)
                        .padding()
                }
                
                
            }
            
            
                
            .background(veryLightGrey)
        }
        
    }
}
#Preview {
    MainFeed(rooms:  [
        UserRoomSettings(id: "room1", user: User(userrooms: [], username: "Alice"), room: Room(name: "Room 1", code: "room1", members: [User(userrooms: [], username: "Alice"), User(userrooms: [], username: "Bob")], leader: User(userrooms: [], username: "Alice"), currentQuestion: Question(question: "What's your favorite color?", date: Date(), answers: []), emoji: "🔴"), isLeader: true),
        UserRoomSettings(id: "room2", user: User(userrooms: [], username: "Bob"), room: Room(name: "Room 2", code: "room2", members: [User(userrooms: [], username: "Charlie"), User(userrooms: [], username: "David")], leader: User(userrooms: [], username: "Charlie"), currentQuestion: Question(question: "What's your favorite animal?", date: Date(), answers: []), emoji: "🐱"), isLeader: false),
        UserRoomSettings(id: "room3", user: User(userrooms: [], username: "Charlie"), room: Room(name: "Room 3", code: "room3", members: [User(userrooms: [], username: "Eve")], leader: User(userrooms: [], username: "Eve"), currentQuestion: Question(question: "What's your favorite food?", date: Date(), answers: []), emoji: "🍕"), isLeader: true),
        UserRoomSettings(id: "room4", user: User(userrooms: [], username: "David"), room: Room(name: "Room 4", code: "room4", members: [User(userrooms: [], username: "Alice"), User(userrooms: [], username: "Charlie"), User(userrooms: [], username: "Eve")], leader: User(userrooms: [], username: "Charlie"), currentQuestion: Question(question: "What's your favorite movie?", date: Date(), answers: []), emoji: "🎬"), isLeader: false),
        UserRoomSettings(id: "room5", user: User(userrooms: [], username: "Eve"), room: Room(name: "Room 5", code: "room5", members: [User(userrooms: [], username: "Bob"), User(userrooms: [], username: "David")], leader: User(userrooms: [], username: "Bob"), currentQuestion: Question(question: "What's your favorite sport?", date: Date(), answers: []), emoji: "👩‍🍳"), isLeader: true), UserRoomSettings(id: "room6", user: User(userrooms: [], username: "Alice"), room: Room(name: "Room 6", code: "room6", members: [User(userrooms: [], username: "Alice"), User(userrooms: [], username: "Bob")], leader: User(userrooms: [], username: "Alice"), currentQuestion: Question(question: "What's your favorite color?", date: Date(), answers: []), emoji: "🧶"), isLeader: true),
        UserRoomSettings(id: "room7", user: User(userrooms: [], username: "Bob"), room: Room(name: "Room 7", code: "room7", members: [User(userrooms: [], username: "Charlie"), User(userrooms: [], username: "David")], leader: User(userrooms: [], username: "Charlie"), currentQuestion: Question(question: "What's your favorite animal?", date: Date(), answers: []), emoji: "🎩"), isLeader: false),
        UserRoomSettings(id: "room8", user: User(userrooms: [], username: "Charlie"), room: Room(name: "Room 8", code: "room8", members: [User(userrooms: [], username: "Eve")], leader: User(userrooms: [], username: "Eve"), currentQuestion: Question(question: "What's your favorite food?", date: Date(), answers: []), emoji: "🌹"), isLeader: true),
        UserRoomSettings(id: "room9", user: User(userrooms: [], username: "David"), room: Room(name: "Room 9", code: "room9", members: [User(userrooms: [], username: "Alice"), User(userrooms: [], username: "Charlie"), User(userrooms: [], username: "Eve")], leader: User(userrooms: [], username: "Charlie"), currentQuestion: Question(question: "What's your favorite movie?", date: Date(), answers: []), emoji: "🌈"), isLeader: false),
        UserRoomSettings(id: "room10", user: User(userrooms: [], username: "Eve"), room: Room(name: "Room 10", code: "room10", members: [User(userrooms: [], username: "Bob"), User(userrooms: [], username: "David")], leader: User(userrooms: [], username: "Bob"), currentQuestion: Question(question: "What's your favorite sport?", date: Date(), answers: []), emoji: "🌾"), isLeader: true)
    ])
}


