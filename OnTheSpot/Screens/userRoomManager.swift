
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
    var lifetimescore: Int = 0
    var scoreBoard: [ScoreBoardData] = []
    
    
    
    init(){
        
        self.database = Firestore.firestore()
        getRooms()
        getLifetimeScore()
        fetchScoreBoard()
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
        let scoreDict: [String: Any] = ["score": 0]
        database.collection("Users").document(userID).collection("Score").document("lifetimeScore").setData(scoreDict) { error in // we are always saving the data under the document id which is equal to the room name
            print(error?.localizedDescription)
            
        }
        
        let userScoreBoard: [String: Any] = ["name": Auth.auth().currentUser?.email ?? "unknown user", "score": 0]
        database.collection("scoreBoard").document(userID).setData(userScoreBoard) { error in // we are always saving the data under the document id which is equal to the room name
            print(error?.localizedDescription)
            
        }
        
    }
    
    func getLifetimeScore() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No user ID found inside fetch rooms functions")
            return
        }
        
        database.collection("Users").document(userID).collection("Score")
            .addSnapshotListener { querySnapshot, error in
                // Handle errors
                if let error = error {
                    print("Error fetching documents: \(error)")
                    return
                }
                
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    
                    self.lifetimescore = 0
                    let data: [String: Any] = ["score": 0]
                    
                    
                    self.database.collection("Users").document(userID).collection("Score").document("lifetimeScore").setData(data) { error in
                        if let error = error {
                            print("Error updating score:", error.localizedDescription)
                        } else {
                            print("Score updated successfully")
                            
                        }
                        
                        return
                    }
                    return
                }
                
                
                guard documents.count == 1 else {
                    print("More than one document found")
                    return
                }
                
                
                let data = documents[0].data()
                
                
                if let score = data["score"] as? Int {
                    print("This is the score we fetched:", score)
                    self.lifetimescore = score
                } else {
                    print("Unable to decode score as an integer")
                }
            }
    }
    
    
    func fetchScoreBoard() {
        print("calling scoreboard😈😈😈😈")
        database.collection("scoreBoard").getDocuments { querySnapshot, error in
                
                if let error = error {
                    print("😈😈Error fetching documents: \(error)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("😈😈No documents found")
                    return
                }
            
            
            print("😈😈")
            print("😈😈", documents)
            
            
            
            var scoreStructs: [ScoreBoardData] = []
            
            
            for document in documents {
                print("😈😈", document)
                let data = document.data()
                print("😈😈", data)
                if let name = data["name"] as? String, let score = data["score"] as? Int {
                    let scoreStruct = ScoreBoardData(name: name, score: score)
                    scoreStructs.append(scoreStruct)
                    print("😈😈", scoreStructs)
                }
            }
            
            
            
            scoreStructs.sort { struct1, struct2 in
                guard let score1 = struct1.score as? Int, let score2 = struct2.score as? Int else {
                    return false
                }
                return score1 > score2
            }
            print("\n\n\n\n\n\nthese are the scoreBoard Structs:", scoreStructs)
            self.scoreBoard = scoreStructs
            
            
        }
    }
    
    
    
    func incrementLifetimeScore(completion: @escaping (Error?) -> Void) {
        print("Adding to score!")
        
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No user ID found")
            return
        }
        
        database.collection("Users").document(userID).collection("Score").getDocuments { querySnapshot, error in
            
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
            
            guard documents.count == 1 else {
                print("More than one document found")
                completion(nil)
                return
            }
            
            let document = documents[0]
            var data = document.data()
            
            if let score = data["score"] as? Int {
                print("This is the score we fetched:", score)
                let newScore = score + 1
                data["score"] = newScore
                
                // Update score in Firestore
                self.database.collection("Users").document(userID).collection("Score").document("lifetimeScore").setData(data) { error in
                    if let error = error {
                        print("Error updating score:", error.localizedDescription)
                    } else {
                        print("Score updated successfully")
                        self.getLifetimeScore()
                        
                        self.database.collection("scoreBoard").document(userID).getDocument { document, error in
                            
                            if let error = error {
                                print("Error fetching document: \(error)")
                                return
                            }
                            
                            guard let document = document, document.exists else {
                                print("Document does not exist")
                                return
                            }
                            
                            guard let score = document.data()?["score"] as? Int, let name = document.data()?["name"] as? String else {
                                print("couldn't find score or name")
                                return
                            }
                            let newScore = score + 1
                            let newScoreBoardDict = ["name": name, "score": newScore]
                            self.database.collection("scoreBoard").document(userID).setData(newScoreBoardDict) { error in
                                if let error = error {
                                    print("Error updating score:", error.localizedDescription)
                                } else {
                                    print("ScoreBoard updated successfully")
                                    self.fetchScoreBoard()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    func decrementLifetimeScore(completion: @escaping (Error?) -> Void) {
        print("Adding to score!")
        
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No user ID found")
            return
        }
        
        database.collection("Users").document(userID).collection("Score").getDocuments { querySnapshot, error in
            
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
            
            guard documents.count == 1 else {
                print("More than one document found")
                completion(nil)
                return
            }
            
            let document = documents[0]
            var data = document.data()
            
            if let score = data["score"] as? Int {
                print("This is the score we fetched:", score)
                let newScore = score - 1
                data["score"] = newScore
                
                // Update score in Firestore
                self.database.collection("Users").document(userID).collection("Score").document("lifetimeScore").setData(data) { error in
                    if let error = error {
                        print("Error updating score:", error.localizedDescription)
                    } else {
                        print("Score updated successfully")
                        self.getLifetimeScore()
                        self.database.collection("scoreBoard").document(userID).getDocument { document, error in
                            
                            if let error = error {
                                print("Error fetching document: \(error)")
                                return
                            }
                            
                            guard let document = document, document.exists else {
                                print("Document does not exist")
                                return
                            }
                            
                            guard let score = document.data()?["score"] as? Int, let name = document.data()?["name"] as? String else {
                                print("couldn't find score or name")
                                return
                            }
                            let newScore = score - 1
                            let newScoreBoardDict = ["name": name, "score": newScore]
                            
                            self.database.collection("scoreBoard").document(userID).setData(newScoreBoardDict) { error in
                                if let error = error {
                                    print("Error updating score:", error.localizedDescription)
                                } else {
                                    print("ScoreBoard updated successfully")
                                    self.fetchScoreBoard()
                                }
                            }
                        }
                    }
                }
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
            


struct ScoreBoardData: Identifiable {
    let id = UUID().uuidString
    let name: String
    let score: Int
    

}
