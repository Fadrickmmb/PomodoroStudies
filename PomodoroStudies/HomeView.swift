//
//  HomeView.swift
//  PomodoroStudies
//
//  Created by Fadrick Barroso on 2024-06-21.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    var body: some View {
        Text("Logged In")
        
        Button(action: {
            let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
                
            } catch let signOutError as NSError {
              print("Error signing out: %@", signOutError)
            }
        }){
            Text("Sign Out")
        }
    }
}

#Preview {
    HomeView()
}
