//
//  Orbit.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 16/07/2023.
//

import Foundation
import SwiftUI
import RealityKit
import RealityKitContent
import WorldAssets

private let modelDepth: Double = 200

/// The list of 3D models to display in the winow.
private enum Item: String, CaseIterable, Identifiable {
    case satellite, moon, telescope
    var id: Self { self }
    var name: String { rawValue.capitalized }
}

struct OrbitPage: View {
    let module: Module
    @Environment(ViewModel.self) private var model
    @State private var selection: Item = .satellite

    var body: some View {
        HStack {
            OrbitDescription(module: module)
            VStack(spacing: 100) {
                Color.clear
                    .overlay {
                        ObjectInOrbit(item: .satellite, orientation: [0.15, 0, 0.15])
                            .opacity(selection == .satellite ? 1 : 0)
                    }
                    .overlay {
                        ObjectInOrbit(item: .moon)
                            .opacity(selection == .moon ? 1 : 0)
                    }
                    .overlay {
                        ObjectInOrbit(item: .telescope, orientation: [-0.3, 0, 0])
                            .opacity(selection == .telescope ? 1 : 0)
                    }
                    
                    .offset(z: modelDepth)
                Picker("Satellite", selection: $selection) {
                    ForEach(Item.allCases) { item in
                        Text(item.name)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 350)
            }
        }
    }
}

private struct ObjectInOrbit: View {
    var item: Item
    var orientation: SIMD3<Double> = .zero

    var body: some View {
        Model3D(named: item.name, bundle: worldAssetsBundle) { model in
            model.resizable()
                .scaledToFit()
                .rotation3DEffect(
                    Rotation3D(
                        eulerAngles: .init(angles: orientation, order: .xyz)
                    )
                )
                .frame(depth: modelDepth)
                .offset(z: -modelDepth / 2)
        } placeholder: {
            ProgressView()
                .offset(z: -modelDepth * 0.75)
        }
    }
}

#Preview {
    OrbitPage(module: Module.orbit)
        .padding()
        .glassBackgroundEffect()
        .environment(ViewModel())
}
