//
//  SubscribeToRooms.swift
//  OnTheSpot
//
//  Created by Darian Lee on 4/21/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
struct MainFeedRow: View{
    
    let veryLightGrey = Color(red: 0.9, green: 0.9, blue: 0.9)
    @ObservedObject var userRoomManager = UserRoomManager()
    var room: Room
    var personal: Bool
    init(room: Room, personal: Bool){
        self.room = room
        self.personal = personal
    }
    var body: some View {
        
        GeometryReader { geometry in
            HStack {
                
                
                    Text(room.emoji)
                        .font(.system(size: 60))
                        .multilineTextAlignment(.leading)
                    
                    VStack(alignment: .leading) {
                        Text("") //to make the layout right (both padding and spacer are too big
                        Text(room.name)
                                .bold()
                                .multilineTextAlignment(.leading)
                            
                            Text("members: " + String(room.members))
                                .multilineTextAlignment(.leading)
                        
                        
                    }
                if personal {
                    if userRoomManager.rooms.contains(room) {
                        Spacer()
                        Button(action: {
                            
                            userRoomManager.removeRoom(room: room) { error in
                                if let error = error {
                                    
                                    print("Error removing room:", error.localizedDescription)
                                } else {
                                    // Room removal was successful
                                    print("Room removed successfully")
                                }
                            }
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.green)
                                .font(Font.system(size: 30))
                        }
                    }
                    else{
                        Spacer()
                        Button(action: {
                            
                            userRoomManager.addRoom(room: room) { error in
                                if let error = error {
                                    
                                    print("Error removing room:", error.localizedDescription)
                                } else {
                                    // Room removal was successful
                                    print("Room removed successfully")
                                }
                            }
                        }) {
                            Image(systemName: "minus.circle")
                                .foregroundColor(.red)
                            .font(Font.system(size: 30))                    }
                        
                        
                    }
                }
                    
                }
                    
            
            
            .frame(width: 350, height: 80, alignment: .topLeading)
            .frame(width: geometry.size.width - 2, alignment: .center)
            .background(Color.white)
            .cornerRadius(10)
            .frame(maxWidth: .infinity)
            
            
        }
        .padding(.vertical, 20)
        
        
    }
}
struct SubscriptionFeed: View{
    let veryLightGrey = Color(red: 0.9, green: 0.9, blue: 0.9)
    @ObservedObject var rooms = globalRoomsVar()
    
    
    var body: some View{
        VStack{
            Text("Manage Rooms:")
                .font(.title)
                .fontWeight(.bold)
                .frame(width: 350, height: 30, alignment: .topLeading)
            ScrollView{
                ForEach(globalRoomsVar.shared.rooms) { room in
                    MainFeedRow(room: room, personal: true)
                        .padding()
                }
                
                
            }
            
            
            
                
            .background(veryLightGrey)
            Button(action: {}
                
                ) {
                Text("Done ✔️")
                    .foregroundColor(.black)
                    
                    .font(Font.system(size: 20))                 
            }
                
            
        }
        .background(veryLightGrey)
        
        
    }
}

struct Room: Identifiable, Encodable, Decodable, Equatable {
    var id: String
    
    var members: Int
    let name: String
    let emoji: String
    init(name: String, emoji: String) {
        
            self.id = name
            self.name = name
            self.emoji = emoji
        self.members = RoomCountManager().getCount(subject: self.name)
        }
    }
class globalRoomsVar: ObservableObject{
    
    static let shared = globalRoomsVar()


        @Published var rooms: [Room] = [Room(name: "Mathematics", emoji: "👩‍🏫"), Room(name: "Computers", emoji: "💻"), Room(name: "History", emoji: "👑"), Room( name: "Politics", emoji: "🏛️"), Room(name: "Geography", emoji: "🗺️"), Room(name: "Film", emoji: "🎬"), Room(name: "Books", emoji: "📚"), Room(name: "Music", emoji: "🪇"), Room(name: "Animals", emoji: "🪿")]
}

class RoomCountManager{
    func incrementCount(subject: String) {
        
        let database = Firestore.firestore()
        let subjectRef = database.collection("RoomCounts").document(subject)
        subjectRef.setData(["count": getCount(subject: subject) + 1]) { error in
            if let error = error {
                print("Error saving document: \(error)")
            } else {
                print("Document successfully saved with initial count 0.")
                if let index = globalRoomsVar.shared.rooms.firstIndex(where: { $0.name == subject }) {
                    
                    var updatedRoom = globalRoomsVar.shared.rooms[index]
                    updatedRoom.members += 1
                    globalRoomsVar.shared.rooms[index] = updatedRoom
                }
            }
        }
        
    }
    
    
    func getCount(subject: String) -> Int {
        var roomCount = 0
        let database = Firestore.firestore()
        let subjectRef = database.collection("RoomCounts").document(subject)
        subjectRef.getDocument { document, error in
            if let document = document, document.exists {
                // Subject exists: retrieve the integer associated with it
                if let count = document.data()?["count"] as? Int {
                    roomCount = count
                }
            } else {
                // subject does exist yet: save it as 0
                subjectRef.setData(["count": 0]) { error in
                    if let error = error {
                        print("Error saving document: \(error)")
                    } else {
                        print("Document successfully saved with initial count 0.")
                    }
                }
            }
        }
        
        return roomCount
    }
    
    // NOTE: this function will not be used in the final code. This is just for debugging purposes
    func clearAll(completion: @escaping (Error?) -> Void) {
        let database = Firestore.firestore()
        let collectionRef = database.collection("RoomCounts")
        

        collectionRef.getDocuments { querySnapshot, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                completion(nil)
                return
            }
            
      
            let batch = database.batch()
            documents.forEach { document in
                batch.deleteDocument(collectionRef.document(document.documentID))
            }
            

            batch.commit { error in
                completion(error)
            }
        }
    }
}
    

#Preview {
    SubscriptionFeed()
}

