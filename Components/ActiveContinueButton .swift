//
//  ContinueButton .swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/16/24.
//

import SwiftUI

struct ActiveContinueButton: View {
    
    let action: () -> Void
    var body: some View {
        Button(action: action){
            Text("Continue")
                .foregroundColor(.white)
        }
        .padding()
        .font(.system(size: 20))
        .frame(width: 290)
        .background(Color.blue)
        .cornerRadius(10)
        
    }
}

#Preview {
    ActiveContinueButton(action: {})
}
