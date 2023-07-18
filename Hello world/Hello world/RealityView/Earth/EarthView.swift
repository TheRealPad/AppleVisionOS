//
//  EarthView.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 17/07/2023.
//

import Foundation
import SwiftUI
import RealityKit
import RealityKitContent
import WorldAssets

struct EarthView: View {
    var earthConfiguration: EarthEntity.Configuration = .init()
    var satelliteConfiguration: [SatelliteEntity.Configuration] = []
    var moonConfiguration: SatelliteEntity.Configuration? = nil
    var animateUpdates: Bool = false
    @State private var earthEntity: EarthEntity?
    
    var body: some View {
        RealityView { content in
            let earthEntity = await EarthEntity(
                configuration: earthConfiguration,
                satelliteConfiguration: satelliteConfiguration,
                moonConfiguration: moonConfiguration
            )
            content.add(earthEntity)
            self.earthEntity = earthEntity

        } update: { content in
            earthEntity?.update(
                configuration: earthConfiguration,
                satelliteConfiguration: satelliteConfiguration,
                moonConfiguration: moonConfiguration,
                animateUpdates: animateUpdates)
        }
    }
}

#Preview {
    EarthView(
        earthConfiguration: EarthEntity.Configuration.orbitEarthDefault,
        satelliteConfiguration: [
            SatelliteEntity.Configuration(
                name: "Satellite",
                isVisible: true,
                inclination: .degrees(30),
                speedRatio: 10,
                scale: 1,
                altitude: 0.4,
                traceWidth: 400,
                isTraceVisible: true),
        ]
    ).dragRotation(pitchLimit: .degrees(90))
}
