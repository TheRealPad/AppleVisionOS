//
//  ContentView.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 13/07/2023.
//

import SwiftUI
import RealityKit
import RealityKitContent

//struct ContentView: View {
//    var body: some View {
//        NavigationSplitView {
//            List {
//                Text("Item")
//            }
//            .navigationTitle("Sidebar")
//        } detail: {
//            VStack {
//                Model3D(named: "Scene", bundle: realityKitContentBundle)
//                    .padding(.bottom, 50)
//
//                Text("Hello, world!")
//            }
//            .navigationTitle("Content")
//            .padding()
//        }
//    }
//}

struct Module: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let title: String
    let titleDescription: String

    static func == (lhs: Module, rhs: Module) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ModuleDetail: View {
    let module: Module

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("Module Details")
                    .font(.title)
                    .padding()
                
                Text("Name: \(module.name)")
                    .font(.headline)
                    .padding()
            }
            Spacer()
            VStack {
                Model3D(named: "Scene", bundle: realityKitContentBundle)
                    .padding(.bottom, 50)
            }
            .padding()
            Spacer()
        }
    }
}

struct NavigationButton: View {
    let module: Module
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(module.title)                                    .font(.body)
                .opacity(0.5)
                .foregroundColor(.white)
            Text(module.name)                                    .font(.headline)
                .foregroundColor(.white)
            Text(module.titleDescription)
                .font(.subheadline)
                .foregroundColor(.white)
        }.padding()
    }
}

struct TableOfContents: View {
    let modules = [
        Module(name: "Planet Earth", title: "A Day in the life", titleDescription: "A lot goes into making a day happen on Planet Earth! Discover how our globe turns and tilts to give us hot summer days, chilly autumn nights, and more."),
        Module(name: "Objects in Orbit", title: "Our nearby Neighbors", titleDescription: "Get up close with different types of orbits to learn more about how satellites and other objects move in space relative to the Earth."),
        Module(name: "The Solar System", title: "Soaring Through Space", titleDescription: "Take a trip to the solar system and watch how the Earth, Moon, and its satellites are in constant mation rotating around the Sun.")
    ]
    @State private var pressedButton: Module?
    
    var body: some View {
        HStack {
            Spacer(minLength: 50)
            ForEach(modules) { module in
                NavigationLink(value: module) {
                    NavigationButton(module: module)
                    Spacer(minLength: 50)
                }
                
                .buttonStyle(PlainButtonStyle())
                .background(
                    Group {
                        if pressedButton == module {
                            RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white.opacity(0.1))
                        }
                    }
                )
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            self.pressedButton = module
                        }
                        .onEnded { _ in
                            self.pressedButton = nil
                        }
                )
                Spacer()
            }
        }
    }
}

struct Title: View {
    @State private var textToShow = ""
    @State private var currentIndex = 0
        
    let text = "Hello, world!"
    var body: some View {
    
        VStack {
            Text(textToShow)
                .font(.largeTitle)
                .onAppear {
                    startTypingAnimation()
                }
                .foregroundColor(.white)
            Text("Discover a new way of looking at the world.")
                .foregroundColor(.white)
        }
    }

    private func startTypingAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            guard currentIndex < text.count else {
                timer.invalidate()
                return
            }
                
            let index = text.index(text.startIndex, offsetBy: currentIndex)
            textToShow += String(text[index])
            currentIndex += 1
        }
    }
}

struct ContentView: View {
    @State private var isMainScreen = true
    
    var body: some View {
        NavigationStack {
            Spacer()
            Title()
            TableOfContents()
                .navigationDestination(for: Module.self) { module in
                    ModuleDetail(module: module)
                        .navigationTitle(module.title)
                }.padding(30)
        }
    }
}

#Preview {
    ContentView()
}
