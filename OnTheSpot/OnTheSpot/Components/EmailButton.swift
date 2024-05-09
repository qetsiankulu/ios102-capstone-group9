//
//  ContentView.swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/16/24.
//

import SwiftUI

// Button that takes the user to an instance of the SignUpView
struct EmailButton: View {
    
    @State private var isShowingSignUpScreen = false // State variable to control modal presentation
    
    var body: some View {
        Button (action: {
            // Show the SignUpScreen modally
            isShowingSignUpScreen = true
        }) {
            HStack {
                
                Image("email-icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 30) // Adjust the image size as needed
                
                Text("Continue with Email")
                    .foregroundColor(.black)
                
            }
        }
        .padding()
        .font(.system(size: 20))
        .frame(width: 290)
        .background(Color.gray.opacity(0.15))
        .cornerRadius(10)
        .sheet(isPresented: $isShowingSignUpScreen) {
            // Present the SignUpScreen modally when isShowingSignUpScreen is true
                  SignUpScreen()
        }
        
    }
}

#Preview {
    EmailButton()
}
