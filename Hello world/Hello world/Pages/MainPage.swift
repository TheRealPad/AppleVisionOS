//
//  MainPage.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 15/07/2023.
//

import Foundation
import SwiftUI

struct Title: View {
    @State private var textToShow = ""
    @State private var currentIndex = 0
        
    let text = "Hello, world!"
    var body: some View {
    
        VStack {
            Text(textToShow)
                .monospaced()
                .font(.system(size: 50, weight: .bold))
                .onAppear {
                    startTypingAnimation()
                }
                .foregroundColor(.white)
            Text("Discover a new way of looking at the world.")
                .foregroundColor(.white)
        }
    }

    private func startTypingAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            guard currentIndex < text.count else {
                timer.invalidate()
                return
            }
                
            let index = text.index(text.startIndex, offsetBy: currentIndex)
            textToShow += String(text[index])
            currentIndex += 1
        }
    }
}

#Preview {
    Title()
        .padding()
        .glassBackgroundEffect()
}
