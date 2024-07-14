//
//  ContentView.swift
//  PomodoroStudies
//
//  Created by Fadrick Barroso on 2024-06-09.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @AppStorage("uid") var userID: String = ""
    
    
    var body: some View {
        
        if userID == ""{
            AuthView()
        }else{
            AuthView()
        }
        
    }
}

#Preview {
    ContentView()
}
