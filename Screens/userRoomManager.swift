
//  userStruct.swift
//  OnTheSpot
//
//  Created by Darian Lee on 4/21/24.


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseCore
import SwiftUI

@Observable
class UserRoomManager {
    
    let database: Firestore
    var rooms: [Room] = []
    var nonRooms: [Room] = []

    
    init(){
        
        self.database = Firestore.firestore()
        getRooms()
    }
    func initializeNewUser(){
        guard let userID = Auth.auth().currentUser?.uid else {
            print("no user id found inside fetch rooms functions")
            
            return
        }
        print("auth.auth!", userID)
        for room in globalRoomsVar.shared.rooms{
            let roomDict: [String: String] = ["name": room.name, "emoji": room.emoji]
            database.collection("Users").document(userID).collection("NonRooms").document(room.name).setData(roomDict) { error in // we are always saving the data under the document id which is equal to the room name
                print(error?.localizedDescription)
                
            }
        }
        
    }
    func getRooms() {
        print("WE ARE RUNNING GET ROOMS ✨ ✨✨ ✨✨ ✨✨ ✨✨ ✨✨ ✨✨ ✨\n\n")
        guard let userID = Auth.auth().currentUser?.uid else {
            print("no user id found inside fetch rooms functions")
            
            return
        }
        print("auth.auth!", userID)
        
        database.collection("Users").document(userID).collection("SavedRooms")
        
            .addSnapshotListener { querySnapshot, error in
                
                // Get the documents for the messages collection (a document represents a message in this case)
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(String(describing: error))")
                    return
                }
                
                
                
                var fetchedRoomStructs: [Room] = []
                for document in documents {
                    let data = document.data()
                    if let name = data["name"] as? String, let emoji = data["emoji"] as? String {
                        let room = Room(name: name, emoji: emoji)
                        fetchedRoomStructs.append(room)
                    }
                }
                print("these are the rooms we fetched in the get rooms function:", fetchedRoomStructs)
                self.rooms = fetchedRoomStructs
                
                
                
                
            }
        database.collection("Users").document(userID).collection("NonRooms")
        
            .addSnapshotListener { querySnapshot, error in
                
                // Get the documents for the messages collection (a document represents a message in this case)
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(String(describing: error))")
                    return
                }
                
                
                
                var nonRoomStructs: [Room] = []
                for document in documents {
                    let data = document.data()
                    if let name = data["name"] as? String, let emoji = data["emoji"] as? String {
                        let room = Room(name: name, emoji: emoji)
                        nonRoomStructs.append(room)
                    }
                }
                print("these are the NON rooms we fetched in the get rooms function:", nonRoomStructs)
                self.nonRooms = nonRoomStructs
                
            }
    }

    
    func addRoom(userID: String, room: Room, completion: @escaping (Error?) -> Void){
         print("adding a room!")
        
            
            // there is a different collection for each user. The collection contains the sub collection "rooms" which stores all their saved rooms
         print("printing user id 🥲🥲🥲")
        print(userID)
  
        let roomDict: [String: String] = ["name": room.name, "emoji": room.emoji] // we will only need the name and emoji when fetching the rooms

            
        self.database.collection("Users").document(userID).collection("SavedRooms").document(room.name).setData(roomDict) { error in // we are always saving the data under the document id which is equal to the room name
            print(error?.localizedDescription)
            completion(error)
        }
        database.collection("Users").document(userID).collection("NonRooms").document(room.name)
        .delete { error in
                if let error = error {
                    print("Error removing room from Firestore:", error.localizedDescription)
                    completion(error)
                } else {
                    print("Room removed from Firestore successfully")
                    completion(nil)
                }
            }
        getRooms()
        
            
        }
        

    func removeRoom(userID: String, room: Room, completion: @escaping (Error?) -> Void){
        print("removing a room!")
        print(userID)
        print("printing user id 🥲🥲🥲")
        database.collection("Users").document(userID).collection("SavedRooms").document(room.name)
        .delete { error in
                if let error = error {
                    print("Error removing room from Firestore:", error.localizedDescription)
                    completion(error)
                } else {
                    print("Room removed from Firestore successfully")
                    completion(nil)
                }
            }
        
        let roomDict: [String: String] = ["name": room.name, "emoji": room.emoji] // we will only need the name and emoji when fetching the rooms

            
        self.database.collection("Users").document(userID).collection("NonRooms").document(room.name).setData(roomDict) { error in // we are always saving the data under the document id which is equal to the room name
            print(error?.localizedDescription)
            completion(error)
        }
        getRooms()
        
        }
    
}

