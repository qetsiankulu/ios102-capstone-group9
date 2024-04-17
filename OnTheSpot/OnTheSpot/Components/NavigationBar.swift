//
//  Header.swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/16/24.
//

import SwiftUI

struct NavigationBar: View {
    
    let backButtonAction: () -> Void
    let rightButtonAction: () -> Void
    let rightButtonText: String
    
    var body: some View {
        NavigationView {
            VStack {
            
            }
            .navigationBarItems(
                leading: CustomBackButton(), // Custom back button
                trailing: CustomRightButton() // Custom right button
            )
        }
    }
}

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            self.backButtonAction
        }) {
            Image(systemName: "xmark")
        }
    }
}

struct CustomRightButton: View {
    var body: some View {
        Button(action: {
            self.rightButtonAction()
        }) {
            Text(rightButtonText)
        }
    }

}

#Preview {
    NavigationBar(backButtonAction: {}, rightButtonAction: {}, rightButtonText: "Done")
}
