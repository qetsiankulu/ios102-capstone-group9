//
//  CustomRightButton.swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/22/24.
//

import SwiftUI

struct NavRightButton<Destination: View>: View {
    
    var destination: Destination  // Accepts a destination view as an argument
    var buttonText: String        // Accepts the button text as an argument
       
    var body: some View {
        NavigationLink(destination: destination) {
            Text(buttonText)
        }
    }
}

#Preview {
    NavRightButton(destination: LoginScreen(), buttonText: "Login")
}
