//
//  SubscribeToRooms.swift
//  OnTheSpot
//
//  Created by Darian Lee on 4/21/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
struct MainFeedRow: View{
    
    let veryLightGrey = Color(red: 0.9, green: 0.9, blue: 0.9)
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authManager: AuthManager
    @State private var showAlert = false // for showing button alerts
    @State private var alertMessage = ""
    @State var manualUIChangeAdded: Bool = false
    var room: Room
    var alreadyThere: Bool?
    var subscriptionView: Bool
    init(room: Room, subscriptionView: Bool, alreadyThere: Bool?){
        print("INIT IS RUNNING")
        self.room = room
        self.subscriptionView = subscriptionView
        self.alreadyThere = alreadyThere
        
        
    }
        
    
    var body: some View {
        
        
        GeometryReader { geometry in
            HStack {
                
                
                    Text(room.emoji)
                        .font(.system(size: 60))
                        .multilineTextAlignment(.leading)
                HStack{
                    VStack(alignment: .leading) {
                        Text("") //to make the layout right (both padding and spacer are too big
                        Text(room.name)
                            .bold()
                            .multilineTextAlignment(.leading)
                        
                        Text("")
                            .multilineTextAlignment(.leading)
                        
                        
                    }
                    if !subscriptionView {
                            NavigationLink(destination: insideRoomView(room: room)) {
                                Spacer()
                                
                                Image(systemName: "arrow.right")
                                    .padding()
                                
                            }
                        }
                    }
                
                if subscriptionView {
                    
                    
                    if alreadyThere! || manualUIChangeAdded {
                        
                            
                            Spacer()
                        Button(action: {
                            
                            alertMessage = "Room removed 🥲"
                            showAlert = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){ // so that the alert shows for 1 second
                                UserRoomManager().removeRoom(userID: Auth.auth().currentUser!.uid, room: room) { error in
                                    if let error = error {
                                        print("Error removing room: \(error.localizedDescription)")
                                    } else {
                                        print("Room removed successfully!")
                                        
                                        //presentationMode.wrappedValue.dismiss()
                                        
                                        RoomCountManager().decreaseCount(subject: room.name)
                                        
                                    }
                                }
                                
                                //manualUIChangeAdded = false
                            }
                        }
                                   
                            ) {
                                Image(systemName: "minus.circle")
                                    .foregroundColor(.red)
                                    .font(Font.system(size: 30))
                            }
                        
                        }
                        if !alreadyThere!{
                            Spacer()
                            Button(action: {
                                alertMessage = "Room added successfully! 😄"
                                showAlert = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    UserRoomManager().addRoom(userID: Auth.auth().currentUser!.uid, room: room) { error in
                                        if let error = error {
                                            print("Error adding room: \(error.localizedDescription)")
                                        } else {
                                            print("Room added successfully!")
                                            alertMessage = "Room added successfully! 😄"
                                            showAlert = true
                                            //presentationMode.wrappedValue.dismiss()
                                            print("Room added successfully")
                                            RoomCountManager().incrementCount(subject: room.name)
                                        }
                                    }
                                    
                                    
                                    //manualUIChangeAdded = true
                                }
                            }
                                   
                            ) {
                                
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.green)
                                .font(Font.system(size: 30))}
                            
                            
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
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertMessage))
                }
            }
            
            func showAlert(message: String) {
                alertMessage = message
                showAlert = true
            }
        }

struct SubscriptionFeed: View{
    let veryLightGrey = Color(red: 0.9, green: 0.9, blue: 0.9)
    @ObservedObject var rooms = globalRoomsVar()
    @EnvironmentObject var authManager: AuthManager
    @State private var isDoneTapped = false
    @State var userRoomManager: UserRoomManager = UserRoomManager()
    
    
    
    
    
    var body: some View{
        NavigationView {
            VStack{
                Text("Manage Rooms:")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(width: 350, height: 30, alignment: .topLeading)
                ScrollView{
                    ForEach(userRoomManager.rooms) { room in
                        MainFeedRow(room: room, subscriptionView: true, alreadyThere: true)
                            .padding()
                            .environmentObject(authManager)
                    }
                    ForEach(userRoomManager.nonRooms) { room in
                        MainFeedRow(room: room, subscriptionView: true, alreadyThere: false)
                            .padding()
                            .environmentObject(authManager)
                    }
                    
                    
                }
                
                
                
                
                .background(veryLightGrey)
                //                Button(action: {
                //                    print("done tapped!")
                //                    isDoneTapped = true
                //                }
                //                       
                //                ) {
                //                    Text("Done ✔️")
                //                        .foregroundColor(.black)
                //                                                .font(Font.system(size: 20))
                //                                        }
                //                                        .background(veryLightGrey)
                //                                    }
                //                                    .background(veryLightGrey)
                //                                    
                //                                    .navigationBarItems(trailing:
                //                                        NavigationLink(destination: UserMainFeedView(), isActive: $isDoneTapped) {
                //                                            EmptyView()
                //                                            .navigationBarTitle("", displayMode: .inline)
                //                                                .navigationBarBackButtonHidden(true) // Hide the back button
                //                                                
                //                                        }
                //                                    )
            }
            .background(veryLightGrey)
        }
    }
}

struct Room: Identifiable, Encodable, Decodable, Equatable, Hashable {
    var id: String
    
    var members: Int
    let name: String
    let emoji: String
    init(name: String, emoji: String) {
        
            self.id = name
            self.name = name
            self.emoji = emoji
        self.members = max(RoomCountManager().getCount(subject: self.name),0)
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
    
    func decreaseCount(subject: String) {
        
        let database = Firestore.firestore()
        let subjectRef = database.collection("RoomCounts").document(subject)
        subjectRef.setData(["count": getCount(subject: subject) - 1]) { error in
            if let error = error {
                print("Error saving document: \(error)")
            } else {
                print("Document successfully saved with initial count 0.")
                if let index = globalRoomsVar.shared.rooms.firstIndex(where: { $0.name == subject }) {
                    
                    var updatedRoom = globalRoomsVar.shared.rooms[index]
                    updatedRoom.members -= 1
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

