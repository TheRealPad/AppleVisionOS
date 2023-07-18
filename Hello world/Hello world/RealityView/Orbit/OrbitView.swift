//
//  GroupView.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 18/07/2023.
//

import Foundation
import SwiftUI
import RealityKit
import RealityKitContent
import WorldAssets

struct OrbitView: View {
    @Environment(ViewModel.self) private var model
    var body: some View {
        EarthView(
            earthConfiguration: model.orbitEarth,
            satelliteConfiguration: [model.orbitSatellite],
            moonConfiguration: model.orbitMoon
        )
        .placementGestures(initialPosition: Point3D([475, -1800.0, -1200.0]))
    }
}
