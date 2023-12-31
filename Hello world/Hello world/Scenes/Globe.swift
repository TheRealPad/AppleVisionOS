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

struct Globe: View {
    @Environment(ViewModel.self) private var model
    var body: some View {
        @Bindable var model = model
        ZStack(alignment: Alignment(horizontal: .controlPanelGuide, vertical: .bottom)) {
            EarthView(earthConfiguration: model.globeEarth)
                .dragRotation(pitchLimit: .degrees(90))
                .alignmentGuide(.controlPanelGuide) { context in
                    context[HorizontalAlignment.center]
                }

            EarthViewControle()
        }
        .onChange(of: model.isGlobeRotating) { _, isRotating in
            model.globeEarth.speed = isRotating ? 0.1 : 0
        }
        .onDisappear {
            model.isShowingGlobe = false
        }
    }
}

extension HorizontalAlignment {
    /// A custom alignment to center the control panel under the globe.
    private struct ControlPanelAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
    }

    /// A custom alignment guide to center the control panel under the globe.
    static let controlPanelGuide = HorizontalAlignment(
        ControlPanelAlignment.self
    )
}

#Preview {
    Globe().environment(ViewModel())
}
