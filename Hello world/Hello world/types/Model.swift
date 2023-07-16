//
//  Model.swift
//  Hello world
//
//  Created by Pierre-Alexandre Delgado on 15/07/2023.
//

import Foundation
import SwiftUI
import Observation

@Observable
class ViewModel {
    
    // MARK: - Navigation
    var navigationPath: [Module] = []
    var titleText: String = ""
    var isTitleFinished: Bool = false
    var finalTitle: String = "Hello World"
}
