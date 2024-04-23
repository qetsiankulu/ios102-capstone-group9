//
//  ContentView.swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/16/24.
//

import SwiftUI

// Button that takes the user to an instance of the SignUpView
struct EmailButton: View {
    
    var body: some View {
        NavigationLink(destination: SignUpScreen()){
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
      
    }
}

#Preview {
    EmailButton()
}
