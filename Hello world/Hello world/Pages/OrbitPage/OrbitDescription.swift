//
//  OrbitDescription.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 17/07/2023.
//

import Foundation
import SwiftUI

struct OrbitDescription: View {
    let module: Module
    @State var displayWindow = false
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(module.heading)
                .font(.headline)
            Text(module.overview)
                .font(.subheadline).padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            Toggle(module.callToAction, isOn: $displayWindow)
                .onChange(of: displayWindow) { wasShowing, isShowing in
                                if isShowing {
                                    openWindow(id: Module.globe.name)
                                } else {
                                    dismissWindow(id: Module.globe.name)
                                }
                            }
                .toggleStyle(.button)
        }.padding(EdgeInsets(top: 10, leading: 50, bottom: 20, trailing: 0))
    }
}

#Preview {
    OrbitDescription(module: Module.orbit)
        .padding()
        .glassBackgroundEffect()
}
