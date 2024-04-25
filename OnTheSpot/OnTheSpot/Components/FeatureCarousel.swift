//
//  Carousel.swift
//  OnTheSpot
//
//  Created by Qetsia Nkulu  on 4/23/24.
//

import SwiftUI

struct FeatureCarousel: View {
    var body: some View {
        AutoScroller(imageNames: ["github-logo", "different-rooms", "new-topics"], imageCaptions: ["Third-party authentication with Github", "Explore different rooms OnTheSpot", "Discover fun new topics OnTheSpot"])
    }
}


struct AutoScroller: View {
    var imageNames: [String]
    var imageCaptions: [String]
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    // Manage the State of the selectedImageIndex
    @State private var selectedImageIndex: Int = 0
    
    // Manage the State of the selectedCaptionIndex
    @State private var selectedCaptionIndex: Int = 0
    
    
    var body: some View {
        ZStack {
//            // Background color
//            Color.secondary
//                .ignoresSafeArea()
//            
//            
            // Create TabView for Carousel Images
            TabView(selection: $selectedImageIndex) {
                
                // Iterate through Images
                ForEach(0..<imageNames.count, id: \.self) { index in
                    ZStack(alignment: .topLeading) {
                        
                        // Display Image
                        Image("\(imageNames[index])")
                            .resizable()
                            .tag(index)
                            .frame(width: 350, height: 200)
                    }
                    .padding(.bottom, 30)
                    
                }
            }
            .frame(height: 300) // set carousel height
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // customize TabView Style
            .ignoresSafeArea()
            
            // Image captions
            VStack {
                Text(imageCaptions[selectedCaptionIndex])
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
            .offset(y: 120) // Adjust Dots Position
            
            // Navigation Dots
            HStack {
                ForEach(0..<imageNames.count, id: \.self) { index in
                    
                    // Step 13: Create Navigation Dots
                    Capsule()
                        .fill(Color.blue.opacity(selectedImageIndex == index ? 1 : 0.33))
                        .frame(width: 35, height: 8)
                        .onTapGesture {
                            // Handle Navigation Dot Taps
                            selectedImageIndex = index
                        }
                }
                .offset(y: 170) // Adjust Dots Position
            }
       
        }
         .onReceive(timer) { _ in
             // Auto-Scrolling Logic
             withAnimation(.default) {
                 selectedImageIndex = (selectedImageIndex + 1) % imageNames.count
                 selectedCaptionIndex = (selectedCaptionIndex + 1) % imageCaptions.count
             }
         }
    }

    
}

#Preview {
    FeatureCarousel()
}
