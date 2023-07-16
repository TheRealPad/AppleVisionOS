//
//  Navigation.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 15/07/2023.
//

import Foundation
import SwiftUI

struct NavigationButton: View {
    var module: Module

    var body: some View {
        NavigationLink(value: module) {
            VStack(alignment: .leading, spacing: 4) {
                Text(module.eyebrow)
                    .font(.callout)
                    .bold()
                    .foregroundStyle(.secondary)
                VStack(alignment: .leading, spacing: 10) {
                    Text(module.heading)
                        .font(.largeTitle)
                    Text(module.abstract)
                }
            }
            .padding(.vertical, 30)
        }
        .buttonStyle(.borderless)
        .buttonBorderShape(.roundedRectangle(radius: 20))
        .frame(minWidth: 200, maxWidth: 380)
    }
}


struct Navigation: View {
    @State private var pressedButton: Module?
    
    var body: some View {
        HStack(alignment: .top) {
            ForEach(Module.allCases) { module in
                NavigationButton(module: module)
            }
        }
    }
}

#Preview {
    Navigation()
}
