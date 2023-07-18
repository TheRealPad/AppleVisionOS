//
//  EartViewControle.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 18/07/2023.
//

import Foundation
import SwiftUI
import RealityKit
import RealityKitContent
import WorldAssets

struct EarthViewControle: View {
    @Environment(ViewModel.self) private var model
    @State private var isTiltPickerVisible: Bool = false
    
    var body: some View {
        @Bindable var model = model
        
        VStack() {
            HStack(spacing: 17) {
                Toggle(isOn: $model.globeEarth.showSun) {
                    Label("Sun", systemImage: "sun.max")
                }
                .help("Sun")

                Toggle(isOn: $model.globeEarth.showPoles) {
                    Label("Poles", systemImage: "mappin.and.ellipse")
                }
                .help("Poles")

                Toggle(isOn: $model.isGlobeRotating) {
                    Label("Rotate", systemImage: "arrow.triangle.2.circlepath")
                }
                .help("Rotate")

                Toggle(isOn:$isTiltPickerVisible) {
                    Label("Tilt", systemImage: "cloud.sun.fill")
                }
                .help("Tilt")
            }
            .toggleStyle(.button)
            .buttonStyle(.borderless)
            .labelStyle(.iconOnly)
            .padding(12)
            .glassBackgroundEffect(in: .rect(cornerRadius: 50))
        }

        // Update the date that controls the Earth's tilt.
//        .onChange(of: model.globeTilt) { _, tilt in
//            model.globeEarth.date = tilt.date
//        }
    }
}

enum EarthTilt: String, CaseIterable, Identifiable {
    case none, march, june, september, december
    var id: Self { self }

    var date: Date? {
        let month = switch self {
        case .none: 0
        case .march: 3
        case .june: 6
        case .september: 9
        case .december: 12
        }

        if month == 0 {
            return nil
        } else {
            return Calendar.autoupdatingCurrent.date(from: .init(month: month, day: 21))
        }
    }

    var name: String {
        switch self {
        case .none: "None"
        case .march: "March equinox"
        case .june: "June solstice"
        case .september: "September equinox"
        case .december: "December solstice"
        }
    }
}

#Preview {
    EarthViewControle()
        .environment(ViewModel())
}
