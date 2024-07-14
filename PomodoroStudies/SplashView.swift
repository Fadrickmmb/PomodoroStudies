//
//  SplashView.swift
//  PomodoroStudies
//
//  Created by Fadrick Barroso on 2024-06-09.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack{
            
            if self.isActive{
                AuthView()
            }else{
                Image("PomodoroNinjaLogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                
            }
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                withAnimation{
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
