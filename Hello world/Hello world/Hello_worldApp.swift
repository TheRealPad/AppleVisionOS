//
//  Hello_worldApp.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 13/07/2023.
//

import SwiftUI
import WorldAssets

@main
struct Hello_worldApp: App {
    @State private var model = ViewModel()
    @State private var orbitImmersionStyle: ImmersionStyle = .mixed
    @State private var solarImmersionStyle: ImmersionStyle = .full
    
    var body: some Scene {
        WindowGroup("Hello world", id: "modules") {
            Modules().environment(model)
        }
        .windowStyle(.plain)
        WindowGroup(id: Module.globe.name) {
            Globe().environment(model)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.6, height: 0.6, depth: 0.6, in: .meters)
        ImmersiveSpace(id: Module.orbit.name) {
            OrbitView()
                .environment(model)
        }
        .immersionStyle(selection: $orbitImmersionStyle, in: .mixed)
        ImmersiveSpace(id: Module.solar.name) {
            SolarSystemView()
                .environment(model)
        }
        .immersionStyle(selection: $solarImmersionStyle, in: .full)
    }
    
    init() {
        RotationComponent.registerComponent()
        TraceComponent.registerComponent()
        SunPositionComponent.registerComponent()
        SunPositionSystem.registerSystem()
    }
}
