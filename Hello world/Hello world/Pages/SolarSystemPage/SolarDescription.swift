//
//  SolarDescription.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 16/07/2023.
//

import Foundation
import SwiftUI

struct SolarToggle: View {
    var title: String
    var id: String
    @Binding var isShowing: Bool

    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var body: some View {
        Toggle(title, isOn: $isShowing)
            .onChange(of: isShowing) { wasShowing, isShowing in
                Task {
                    if isShowing {
                        await openImmersiveSpace(id: id)
                    } else {
                        await dismissImmersiveSpace()
                    }
                }
            }
            .toggleStyle(.button)
    }
}

struct SolarDescription: View {
    let module: Module
    @Environment(ViewModel.self) private var model
    
    var body: some View {
        @Bindable var model = model
        
        VStack(alignment: .leading) {
            Text(module.heading)
                .font(.headline)
            Text(module.overview)
                .font(.subheadline).padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            SolarToggle(title: module.callToAction, id: module.name, isShowing: $model.isShowingSolar)
        }.padding(EdgeInsets(top: 10, leading: 50, bottom: 20, trailing: 0))
    }
}

#Preview {
    SolarDescription(module: Module.solar)
        .environment(ViewModel())
        .padding()
        .glassBackgroundEffect()
}
