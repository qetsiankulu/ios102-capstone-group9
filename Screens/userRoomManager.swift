
//  userStruct.swift
//  OnTheSpot
//
//  Created by Darian Lee on 4/21/24.


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth


class UserRoomManager: ObservableObject{
    @Published var rooms: [Room] = []
    let database = Firestore.firestore()
    
    func getRooms(completion: @escaping (Error?) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        // there is a different collection for each user. The collection contains the sub collection "rooms" which stores all their saved rooms
        print(userID)
        database.collection("Users").document(userID).collection("SavedRooms")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error fetching documents: \(error)")
                    completion(error)
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                            print("No documents found")
                        completion(nil)
                            return
                        }
                        
                        var fetchedRoomStructs: [Room] = []
                        for document in documents {
                            let data = document.data()
                               if let name = data["name"] as? String,
                               let emoji = data["emoji"] as? String {
                                let room = Room(name: name, emoji: emoji) // by only setting the emoji and name, we allow the members to update automatically by fetching the member count associated with that room
                                fetchedRoomStructs.append(room)
                            }
                        }
                
                
                self.rooms = fetchedRoomStructs
                            completion(nil)
            }
    }
    
    func addRoom(room: Room, completion: @escaping (Error?) -> Void){
        
            guard let userID = Auth.auth().currentUser?.uid else {return}
            // there is a different collection for each user. The collection contains the sub collection "rooms" which stores all their saved rooms
            
  
        let roomDict: [String: String] = ["name": room.name, "emoji": room.emoji] // we will only need the name and emoji when fetching the rooms

            
        self.database.collection("Users").document(userID).collection("SavedRooms").document(room.name).setData(roomDict) { error in // we are alkways saving the data under the document id which is equal to the room name
            completion(error)
        }
        
            
        }
        

    func removeRoom(room: Room, completion: @escaping (Error?) -> Void){
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        database.collection("Users").document(userID).collection("SavedRooms").document(room.name)
        }
    
}

