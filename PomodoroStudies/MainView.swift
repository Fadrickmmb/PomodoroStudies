//
//  MainView.swift
//  PomodoroStudies
//
//  Created by Fadrick Barroso on 2024-06-09.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    
    @Binding var currentViewShowing: String
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    @AppStorage("uid") var userID: String = ""
    
    var body: some View {
       
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Image("Pomodoro Studies")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                }
                .padding(.top)
                
                Spacer()
                
                HStack {
                    Image(systemName: "mail")
                    TextField("Username", text: $username)
                    Spacer()
                    
                    if username.count != 0 {
                        Image(systemName: "checkmark")
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                )
                .padding()
                
                HStack {
                    Image(systemName: "lock")
                    SecureField("Password", text: $password)
                    Spacer()
                    
                    if password.count != 0 {
                        Image(systemName: "checkmark")
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                )
                .padding()
                
                Button(action: {
                    withAnimation {
                        self.currentViewShowing = "signup"
                    }
                }) {
                    Text("Don't have an account?")
                        .foregroundColor(.black.opacity(0.7))
                }
                
                Spacer()
                
                Button {
                    Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
                        if let error = error {
                            print(error)
                            return
                        }
                        
                        if let authResult = authResult {
                            self.userID = authResult.user.uid // Set the userID upon successful login
                        }
                    }
                } label: {
                    Text("Log In")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                        .frame(maxWidth: 200, maxHeight: 25)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.red)
                        )
                        .padding(.horizontal)
                }
                
                Spacer()
                Spacer()
                
                Button(action: {}) {
                    Text("Continue as a Guest")
                        .foregroundColor(.black.opacity(1))
                }
            }
        }
    }
}

