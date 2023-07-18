//
//  SolarSystemControls.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 18/07/2023.
//

import Foundation
import SwiftUI

struct SolarSystemControls: View {
    let module: Module
    @State private var factCount = 0
    @Environment(ViewModel.self) private var model

    var body : some View {
        VStack {
            HStack {
                Button {
                    withAnimation { factCount -= 1 }
                } label: {
                    Label("Previous", systemImage: "chevron.left")
                }
                .disabled(factCount == 0)
                .padding()
                Spacer()
                Text(module.heading)
                    .font(.title)
                Spacer()
                Button {
                    withAnimation { factCount += 1 }
                } label: {
                    Label("Next", systemImage: "chevron.right")
                }
                .disabled(factCount == Module.funFacts.count - 1)
                .padding()
            }
            .labelStyle(.iconOnly)
            ZStack {
                ForEach(Module.funFacts, id: \.self) { facts in
                    Text(facts)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                        .opacity(facts == Module.funFacts[factCount] ? 1 : 0)
                }
            }
            Divider()
                .padding()
            Button {
                model.isShowingSolar = false
            } label: {
                Label("Exit the Solar System", systemImage: "arrow.down.right.and.arrow.up.left")
            }
            .buttonStyle(.borderless)
            .padding(.bottom)
        }
        .frame(width: 400)
        .glassBackgroundEffect(in: .rect(cornerRadius: 40))
    }
}

#Preview {
    SolarSystemControls(module: Module.solar).environment(ViewModel())
}
