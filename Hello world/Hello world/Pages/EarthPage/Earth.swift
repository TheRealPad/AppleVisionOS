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
import WorldAssets

struct EarthPage: View {
    let module: Module
    @Environment(ViewModel.self) private var model
    @State var displayWindow = false
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow

    var body: some View {
        HStack {
            Description(module: module)
            Earth()
                .environment(model)
                .padding()
        }
    }
}

private struct Earth: View {
    
    var body: some View {
        VStack {
            Image("GlobeHero")
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    EarthPage(module: Module.globe).environment(ViewModel())
        .padding()
        .glassBackgroundEffect()

}
