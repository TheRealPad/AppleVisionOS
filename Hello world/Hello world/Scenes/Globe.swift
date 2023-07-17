//
//  Globe.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 15/07/2023.
//

import SwiftUI
import RealityKit
import RealityKitContent
import WorldAssets

private let modelDepth: Double = 200

var Padorientation: SIMD3<Double> = .zero

struct Globe: View {

    @State var enlarge = false
    @State private var degrees = 0.0

    var body: some View {
        VStack {
//            EarthView()
        }
    }
}

#Preview {
    Globe()
}
