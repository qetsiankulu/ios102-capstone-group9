//
//  APIClass.swift
//  OnTheSpot
//
//  Created by Darian Lee on 4/26/24.
//

import Foundation

class APIClass{
    
    func fetchTriviaData(roomName: String) async throws -> TriviaResponse {
        print("fetching trivia")
        
        let roomMapping: [String: Int] = [
            "Film": 11,
            "Books": 10,
            "Music": 12,
            "Computers": 18,
            "Mathematics": 19,
            "Politics": 24,
            "History": 23,
            "Geography": 22,
            "Animals": 27
        ]
        
        
        guard let roomInt = roomMapping[roomName] else {
            
            throw FetchTriviaError.invalidRoomName
            
        }
        
        let url = URL(string: "https://opentdb.com/api.php?amount=10&category=" + String(roomInt) + "&type=multiple")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(TriviaResponse.self, from: data)
        return decodedData
    }
}
    
    
struct TriviaResponse: Codable {
    let results: [TriviaQuestion]
}


struct TriviaQuestion: Codable {


    let correctAnswer: String
    let incorrectAnwsers: [String]
    let question: String

    
    


    private enum CodingKeys: String, CodingKey {
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnwsers = "incorrect_answers"
       
        
    }


}

struct IdentifiableTriviaQuestion: Identifiable{
    let trivia: TriviaQuestion
    let id: String
    init(trivia: TriviaQuestion){
        self.trivia = trivia
        self.id = trivia.correctAnswer
        
    }
}

enum FetchTriviaError: Error {
    case invalidRoomName
}
