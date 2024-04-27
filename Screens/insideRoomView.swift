//
//  insideRoomView.swift
//  OnTheSpot
//
//  Created by Darian Lee on 4/26/24.
//

import SwiftUI

struct insideRoomView: View {
    @State private var questions: [IdentifiableTriviaQuestion] = []
    @State private var currentIndex: Int = 0
    @State private var offset: CGSize = .zero
    var room: Room

    
    init(room: Room){
        self.room = room
        print(questions)
        
    }
    
    var body: some View {
        VStack{
            Text("Swipe right for true, left for false")
                .bold()
                .font(.system(size: 25))
                .padding(.top)
            
            ZStack {
                
                ForEach(questions.indices, id: \.self) { index in
                    QuestionRow(question: questions[index].trivia.question, answer: questions[index].trivia.correctAnswer, incorrect: questions[index].trivia.incorrectAnwsers.randomElement() ?? "nuts")
                        .rotationEffect(.degrees(Double(questions.count - 1 - index) * -1))
                                }
                      
                }
  
                
            }
            
        
                             
                
       
     
        .onAppear {
            Task {
                do {
                    print("fetching data inside the room VC")
                    let fetchedData = try await APIClass().fetchTriviaData(roomName: room.name)
                    DispatchQueue.main.async {
                        let tempquestions = fetchedData.results
                        var identifiableQuestions: [IdentifiableTriviaQuestion] = []
                        for tempquestion in tempquestions{
                            identifiableQuestions.append(IdentifiableTriviaQuestion(trivia: tempquestion))
                        }
                        questions = identifiableQuestions
                        
                        
                    }
                } catch {
                    print("Error fetching or decoding trivia data: \(error)")
                }
            }
        }
    }
}
    
    
    
    
struct QuestionRow: View {
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    private let swipeThreshold: Double = 100
    @State private var offset: CGSize = .zero
    
    @State private var showing: Bool = true
    let question: String
    let answer: String
    let incorrect: String
    let trueCard: Bool
    let colorList: [Color] = [
        Color(red: 211/255, green: 211/255, blue: 211/255), // Light Gray
        Color(red: 173/255, green: 216/255, blue: 230/255), // Light Blue
        Color(red: 144/255, green: 238/255, blue: 144/255), // Light Green
        Color(red: 221/255, green: 160/255, blue: 221/255), // Light Purple
        Color(red: 255/255, green: 182/255, blue: 193/255), // Light Pink

        Color(red: 255/255, green: 255/255, blue: 224/255), // Light Yellow
        Color(red: 255/255, green: 204/255, blue: 153/255), // Light Orange
        Color(red: 230/255, green: 230/255, blue: 250/255), // Light Lavender
        Color(red: 152/255, green: 255/255, blue: 152/255)  // Light Mint
    ]
    let cardColor: Color
    init(question: String, answer: String, incorrect: String) {
        print("initialize question row")
        self.question = question
        self.answer = answer
        self.incorrect = incorrect
        self.cardColor = self.colorList.randomElement()!
        self.trueCard = [true, false].randomElement()!
        print(self.trueCard)
    }
    
    
    var body: some View {

            GeometryReader { geometry in
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0) // <-- Add another card background behind the original
                            .fill(offset.width < 0 ? .red : .green)
                    if showing{
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(cardColor)
                        
                            .shadow(color: .black, radius: 4, x: -2, y: 2)
                            .opacity(1 - abs(offset.width) / swipeThreshold)
                    }
                    
                    VStack(spacing: 20) {
                        Spacer()
                        Text(removeHTMLTags(from: question))
                            
                            .bold()
                            
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                        
                        if trueCard {
                            Text(removeHTMLTags(from: answer))
                                .lineLimit(3)
                                .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(Color(red: 0/255, green: 0/255, blue: 255/255)) }
                        else{
                            
                            Text(removeHTMLTags(from: incorrect))
                                .lineLimit(3)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(Color(red: 0/255, green: 0/255, blue: 255/255))
                        }
                                
                            
                                
                                
                            
                        
                        
                        
                    }
                    .font(.title)
                                .foregroundStyle(.black)
                                .padding()
                    
                }
                .offset(offset) // <-- Use the offset value to set the offset of the card view
                .gesture(DragGesture()
                    .onChanged { gesture in
                        let translation = gesture.translation
                         print(translation)
                        offset = translation
                    }.onEnded { gesture in  // <-- onEnded called when gesture ends

                        if gesture.translation.width > swipeThreshold { // <-- Compare the gesture ended translation value to the swipeThreshold
                            print("👉 Swiped right")
                            showing = false
                            if trueCard == true{
                                showAlert = true
                                                alertMessage = "😃Correct!😃"
                                print("correct")
              
                            }
                            else{
                                showAlert = true
                                                alertMessage = "❌Incorrect!❌"
                            }

                        } else if gesture.translation.width < -swipeThreshold {
                            print("👈 Swiped left")
                            showing = false
                            if trueCard == false{
                                print("correct")
                                showAlert = true
                                                alertMessage = "😃Correct!😃"
           
                            }
                            else{
                                
                                showAlert = true
                                                alertMessage = "❌Incorrect!❌"
                            }
                            

                        } else {
                            print("🚫 Swipe canceled")
                            withAnimation(.bouncy) { // <-- Make updates to state managed property with animation
                                offset = .zero
                            }
                        }
                        
                    }
                         
                )
                
                                
                                    
                     
                        .opacity(3 - abs(offset.width) / swipeThreshold * 3) // <-- Fade the card out as user swipes, beginning fade in the last 1/3 to the threshold
                        .rotationEffect(.degrees(offset.width / 20.0))
                        .offset(CGSize(width: offset.width, height: 0))
                        
                
            }
            .alert(isPresented: $showAlert) {
                        Alert(title: Text(alertMessage))
                    }
            
            .frame(width: 300, height: 400)
            .padding()
            
            
            
            
        }
        
    }
func removeHTMLTags(from string: String) -> String {
    let regex = try! NSRegularExpression(pattern: "<[^>]+>")
    return regex.stringByReplacingMatches(in: string, range: NSRange(string.startIndex..., in: string), withTemplate: "")
}
    
    
    #Preview {
        insideRoomView(room: Room(name: "Film", emoji: "📚"))
    }
    



