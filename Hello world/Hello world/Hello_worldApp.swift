//
//  Hello_worldApp.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 13/07/2023.
//

import SwiftUI

@main
struct Hello_worldApp: App {
    @State private var model = ViewModel()
    
    var body: some Scene {
        WindowGroup("Hello world", id: "modules") {
            Modules().environment(model)
        }
        .windowStyle(.plain)
        WindowGroup(id: Module.globe.name) {
            Globe()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.6, height: 0.6, depth: 0.6, in: .meters)
    }
}
