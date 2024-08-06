//
//  SignUpView.swift
//  PomodoroStudies
//
//  Created by Fadrick Barroso on 2024-06-09.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct SignUpView: View {
    
    @Binding var currentViewShowing: String
    
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var navigateToHome: Bool = false
    
    var body: some View {
        NavigationView {
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
                    
                    Text("Sign up now and become a").padding(.top)
                    
                    HStack {
                        Image("PomodoroNinjaText-2")
                            .resizable().scaledToFit().frame(width: 240, height: 100)
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        Image(systemName: "person")
                        TextField("Username", text: $username)
                        
                        if(username.count != 0) {
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
                    ).padding(.leading, 30).padding(.trailing, 30)
                    
                    HStack {
                        Image(systemName: "mail")
                        TextField("Email", text: $email)
                        
                        if(email.count != 0) {
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
                    ).padding(.leading, 30).padding(.trailing, 30).padding(.top, 20)
                    
                    HStack {
                        Image(systemName: "lock")
                        SecureField("Password", text: $password)
                        Spacer()
                        
                        if(password.count != 0) {
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
                    ).padding(.leading, 30).padding(.trailing, 30).padding(.top, 20)
                    
                    Button(action: {
                        withAnimation {
                            self.currentViewShowing = "login"
                        }
                    }) {
                        Text("Already have an Account?")
                            .font(.system(size: 14))
                            .foregroundColor(.black.opacity(0.7))
                    }.padding(.top, 5).padding(.bottom, 30)
                    
                    Button {
                        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                            if let error = error {
                                print(error)
                                return
                            }
                            
                            if let authResult = authResult {
                                let user = User(name: username, email: email, password: password)
                                let ref = Database.database().reference()
                                ref.child("users").child(authResult.user.uid).setValue([
                                    "id": user.id,
                                    "name": user.name,
                                    "email": user.email,
                                    "password": user.password
                                ]) { (error, ref) in
                                    if let error = error {
                                        print(error.localizedDescription)
                                    } else {
                                        print("User saved successfully")
                                        self.navigateToHome = true
                                    }
                                }
                            }
                        }
                    } label: {
                        Text("Register")
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()
                            .frame(maxWidth: 140, maxHeight: 25)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.red)
                            ).padding()
                    }.padding(.bottom, 20)
                    
                    NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                        EmptyView()
                    }
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(currentViewShowing: .constant("signup"))
    }
}

