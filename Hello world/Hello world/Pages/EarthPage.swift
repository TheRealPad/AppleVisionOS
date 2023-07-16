//
//  EarthPage.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 15/07/2023.
//

import Foundation
import SwiftUI
import RealityKit
import RealityKitContent

struct EarthPage: View {
    let module: Module
    @State var displayWindow = false
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("Module Details")
                    .font(.title)
                    .padding()
                
                Text("Name: \(module.name)")
                    .font(.headline)
                    .padding()
                Toggle("View Globe", isOn: $displayWindow)
                    .onChange(of: displayWindow) { wasShowing, isShowing in
                                    if isShowing {
                                        openWindow(id: Module.globe.name)
                                    } else {
                                        dismissWindow(id: Module.globe.name)
                                    }
                                }
                    .toggleStyle(.button)
            }
            Spacer()
            VStack {
                RealityView { content in
                    if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                        content.add(scene)
                    }
                } update: { content in
                    if let scene = content.entities.first {
                        let uniformScale: Float = 2
                        scene.transform.scale = [uniformScale, uniformScale, uniformScale]
                    }
                }
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    EarthPage(module: Module.globe)
}
