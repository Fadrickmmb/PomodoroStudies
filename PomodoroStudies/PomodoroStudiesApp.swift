//
//  PomodoroStudiesApp.swift
//  PomodoroStudies
//
//  Created by Fadrick Barroso on 2024-06-09.
//

import SwiftUI
import FirebaseCore

@main
struct PomodoroStudiesApp: App {
    @StateObject private var viewModel = ToDoViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
