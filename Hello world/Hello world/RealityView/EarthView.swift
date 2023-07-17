//
//  Earth.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 17/07/2023.
//

import Foundation
import SwiftUI
import RealityKit
import RealityKitContent
import WorldAssets

private let modelDepth: Double = 200

var orientation: SIMD3<Double> = .zero

struct EarthView: View {
    @State var enlarge = false
    @State private var degrees = 0.0
    
    var body: some View {
        VStack {
            Model3D(named: "Earth", bundle: worldAssetsBundle) { model in
                model.resizable()
                    .scaledToFit()
                    .rotation3DEffect(
                        .degrees(degrees), axis: (x: 1, y: 1, z: 1)
                    )
                    .frame(depth: modelDepth)
                    .offset(z: -modelDepth / 2)
            } placeholder: {
                ProgressView()
                    .offset(z: -modelDepth * 0.75)
            }
        }
    }
}

#Preview {
    EarthView()
}
