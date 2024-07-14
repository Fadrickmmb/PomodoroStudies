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
                    Image("PomodoroNinjaSolo-2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 160)
                }
                .padding(.top)
                
                Text("Welcome to").padding(.top)

                HStack {
                    Image("PomodoroNinjaText-2")
                        .resizable().scaledToFit().frame(width: 240, height: 100)
                }
                .padding(.bottom,10)
                
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
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                )
                .padding(.leading, 30).padding(.trailing,30)
                
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
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                )
                .padding(.leading, 30).padding(.trailing,30).padding(.top,20)
                
                Button(action: {
                    withAnimation {
                        self.currentViewShowing = "signup" //change here to redirect to forgot password
                    }
                }) {
                    Text("Forgot Password?")
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.7))
                }.padding(.top,5).padding(.bottom,40)
                
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
                    Text("Login")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                        .frame(maxWidth: 140, maxHeight: 25)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.red)
                        )
                        .padding(.horizontal)
                }.padding(.bottom,10)
                
                Button(action: {
                    withAnimation {
                        self.currentViewShowing = "signup"
                    }
                }) {
                    Text("Don't have an account? Register here")
                        .font(.system(size: 16))
                        .foregroundColor(.black.opacity(0.7))
                }.padding(.top,5).padding(.bottom,30)
                
                Button(action: {}) {
                    Text("Continue as a Guest")
                        .foregroundColor(.black.opacity(1))
                }
            }
        }
    }
}

