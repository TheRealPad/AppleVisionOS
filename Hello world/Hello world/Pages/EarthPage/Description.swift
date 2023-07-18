//
//  Description.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 16/07/2023.
//

import Foundation
import SwiftUI

struct Description: View {
    let module: Module
    @Environment(ViewModel.self) private var model
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View {
        @Bindable var model = model
        VStack(alignment: .leading) {
            Text(module.heading)
                .font(.headline)
            Text(module.overview)
                .font(.subheadline).padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            Toggle(module.callToAction, isOn: $model.isShowingGlobe)
                .onChange(of: model.isShowingGlobe) { wasShowing, isShowing in
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
    Description(module: Module.globe).environment(ViewModel())
        .padding()
        .glassBackgroundEffect()
}
