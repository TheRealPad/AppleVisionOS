//
//  ContentView.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 13/07/2023.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct Modules: View {
    @Environment(ViewModel.self) private var model
    @State private var isMainScreen = true
    
    var body: some View {
        @Bindable var model = model
        
        VStack {
            NavigationStack(path: $model.navigationPath) {
                VStack {
                    Image("SunSliver")
                    Spacer(minLength: 120)
                    Title()
                    Navigation()
                        .navigationDestination(for: Module.self) { module in
                            switch module {
                            case .globe: EarthPage(module: module)
                                    .navigationTitle(module.eyebrow)
                            case .orbit: OrbitPage(module: module)
                                    .navigationTitle(module.eyebrow)
                            case .solar: SolarSystemPage(module: module)
                                    .navigationTitle(module.eyebrow)
                            }
                        }
                        .padding(.bottom, 50)
                }
                .padding(.horizontal, 50)
                .background(alignment: Alignment(horizontal: .center, vertical: .earthGuide)) {
                    Image("EarthHalf")
                        .alignmentGuide(.earthGuide) { context in
                            context[VerticalAlignment.top] - 100
                        }
                }
            }
        }
    }
}

extension VerticalAlignment {
    /// A custom alignment that pins the background image to the title.
    private struct EarthAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.top]
        }
    }

    /// A custom alignment guide that pins the background image to the title.
    fileprivate static let earthGuide = VerticalAlignment(
        EarthAlignment.self
    )
}

#Preview {
    Modules().environment(ViewModel())
}
