//
//  Hello_worldApp.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 13/07/2023.
//

import SwiftUI

@main
struct Hello_worldApp: App {
    var body: some Scene {
        WindowGroup("Hello world", id: "modules") {
            ContentView()
        }
        .windowStyle(.plain)
    }
}
