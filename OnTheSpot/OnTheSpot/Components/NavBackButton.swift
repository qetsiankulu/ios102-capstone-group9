//
//  CustomBackButton.swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/22/24.
//

import SwiftUI

struct NavBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            
            // Dismiss the modally presented view
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "xmark")
        }
    }
}

#Preview {
    NavBackButton()
}





