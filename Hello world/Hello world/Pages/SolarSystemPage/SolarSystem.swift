//
//  SolarSystem.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 16/07/2023.
//

import Foundation
import SwiftUI
import RealityKit
import RealityKitContent
import WorldAssets

struct SolarSystemPage: View {
    let module: Module
    @State var displayWindow = false
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow

    var body: some View {
        HStack {
            SolarDescription(module: module)
            Earth()
        }
    }
}

private struct Earth: View {
    
    var body: some View {
        VStack {
            Image("SolarHero")
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    SolarSystemPage(module: Module.solar)
        .padding()
        .glassBackgroundEffect()
}

