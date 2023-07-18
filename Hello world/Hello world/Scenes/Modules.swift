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
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @State private var isMainScreen = true
    
    var body: some View {
        @Bindable var model = model
        
        VStack {
            SolarSystemControls(module: Module.solar).opacity(model.isShowingSolar ? 1 : 0)
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
            .opacity(model.isShowingSolar ? 0 : 1)
            
        }
        .animation(.default, value: model.isShowingSolar)
        .onChange(of: model.navigationPath) { _, path in
            if path.isEmpty {
                if model.isShowingGlobe {
                    dismissWindow(id: Module.globe.name)
                    model.isShowingGlobe = false
                }
                if model.isShowingOrbit || model.isShowingSolar {
                    Task {
                        await dismissImmersiveSpace()
                        model.isShowingOrbit = false
                        model.isShowingSolar = false
                    }
                }
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
            if model.isShowingSolar && newPhase == .background {
                Task {
                    await dismissImmersiveSpace()
                    model.isShowingSolar = false
                    openWindow(id: "modules")
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
