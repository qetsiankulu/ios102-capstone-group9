//
//  GithubButtonView.swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/16/24.
//

import SwiftUI

// Button that redirects user to Github authentication
struct GithubButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action){
            HStack {
                
                Image("github-mark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30) // Adjust the image size as needed
                
                Text("Continue with Github")
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
    GithubButton(action: {})
}
