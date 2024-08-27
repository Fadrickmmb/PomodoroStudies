//
//  ForgotPasswordView.swift
//  PomodoroStudies
//
//  Created by Fadrick Barroso on 2024-08-05.
//

import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    
    @Binding var currentViewShowing: String
    @State private var email: String = ""
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            Text("Reset Password")
                .font(.largeTitle)
                .padding(.bottom, 20)
            
            TextField("Enter your email", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 30)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 10)
            }
            
            Button(action: {
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                    } else {
                        self.errorMessage = "Password reset email sent!"
                    }
                }
            }) {
                Text("Send Email")
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                    .frame(maxWidth: 200, maxHeight: 25)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.red)
                    )
                    .padding(.horizontal)
            }
            .padding(.top, 20)
            
            Button(action: {
                withAnimation {
                    self.currentViewShowing = "login"
                }
            }) {
                Text("Back to Login")
                    .font(.system(size: 16))
                    .foregroundColor(.black.opacity(0.7))
            }
            .padding(.top, 20)
        }
        .padding()
    }
}

