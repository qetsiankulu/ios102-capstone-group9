//
//  Header.swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/16/24.
//

import SwiftUI

struct NavigationBar: View {
    
    let backButtonDestination : SignInScreen
    
    var body: some View {
        NavigationView {
            VStack {
                // Your content here
            }
            .navigationBarItems(
                leading: CustomBackButton(),
                trailing: CustomRightButton()
            )
        }
    }
}

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    

    var body: some View {
        NavigationLink(destination: Text("Previous Screen")) {
            Image(systemName: "xmark")
        }
    }
}

struct CustomRightButton: View {
    
    let rightNavLinkText: String = "Done"
    
    var body: some View {
        NavigationLink(destination: Text("Next Screen")) {
            Text(rightNavLinkText)
        }
    }
}

#Preview {
    NavigationBar(backButtonDestination: SignInScreen())
}

