//
//  AuthView.swift
//  PomodoroStudies
//
//  Created by Fadrick Barroso on 2024-06-09.
//

import SwiftUI

struct AuthView: View {
    
    @State private var currentViewShowing: String = "login"
    
    var body: some View {
        
        if(currentViewShowing == "login"){
            MainView(currentViewShowing: $currentViewShowing)
        }else{
            SignUpView(currentViewShowing: $currentViewShowing)
                .transition(.move(edge: .bottom))
        }
            
        
        
    }
}

#Preview {
    AuthView()
}
