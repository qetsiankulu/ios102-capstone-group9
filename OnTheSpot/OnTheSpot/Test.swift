//
//  Test.swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/22/24.
//

import SwiftUI

struct Test: View {
    var body: some View {
            NavigationStack {
                Text("SwiftUI")
                    .toolbar {
                        Button("About") {
                            print("About tapped!")
                        }

                        Button("Help") {
                            print("Help tapped!")
                        }
                    }
            }
        }
}

#Preview {
    Test()
}
