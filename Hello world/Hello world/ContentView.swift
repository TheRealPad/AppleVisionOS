//
//  ContentView.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 13/07/2023.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State private var isMainScreen = true
    
    var body: some View {
        NavigationStack {
            Spacer()
            Title()
            Navigation()
                .navigationDestination(for: Module.self) { module in
                    EarthPage(module: module)
                        .navigationTitle(module.title)
                }.padding(30)
        }
    }
}

#Preview {
    ContentView()
}
