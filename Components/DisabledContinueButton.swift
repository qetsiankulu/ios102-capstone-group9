//
//  DisabledContinueButton.swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/17/24.
//

import SwiftUI

struct DisabledContinueButton: View {
    
    var body: some View {
        Button(action: {}){
            Text("Continue")
                .foregroundColor(.gray)
        }
        .padding()
        .font(.system(size: 20))
        .frame(width: 290)
        .background(Color.gray.opacity(0.15))
        .cornerRadius(10)
        
    }
    
}


#Preview {
    DisabledContinueButton()
}
