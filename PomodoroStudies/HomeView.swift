//
//  HomeView.swift
//  PomodoroStudies
//
//  Created by Fadrick Barroso on 2024-06-21.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @State var selectedTab = 0
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            // Pomodoro Tab - Home
            VStack{
                HStack{
                    VStack{
                        Image("PomodoroNinjaSolo-2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 64)
                    }.padding()
                    
                    VStack{
                        Text("Hello, user!")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 18))
                            .padding(.bottom,5)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                                   alignment: .leading)
                        
                        Text("You are level ?") //add level from database
                            .font(.system(size: 14))
                            .padding(.bottom,5)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                                   alignment: .leading)
                    }.padding()
                    
                    
                    Button(action: {
                        let firebaseAuth = Auth.auth()
                        do {
                            try firebaseAuth.signOut()
                            
                        } catch let signOutError as NSError {
                            print("Error signing out: %@", signOutError)
                        }
                    }){
                        Image(systemName: "rectangle.portrait.and.arrow.right").padding()
                    }
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,maxWidth: .infinity)
                    .padding(.leading,20)
                    .padding(.trailing,20)
                
                Text("Pomodoro Screen")
            }.tabItem {
                Text("Pomodoro")
            }.tag(0)
            
            // Profile Tab
            VStack{
                HStack{
                    VStack{
                        Image("PomodoroNinjaSolo-2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 64)
                    }.padding()
                    
                    VStack{
                        Text("Hello, user!")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 18))
                            .padding(.bottom,5)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                                   alignment: .leading)
                        
                        Text("You are level ?")
                            .font(.system(size: 14))
                            .padding(.bottom,5)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                                   alignment: .leading)
                    }.padding()
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,maxWidth: .infinity)
                    .padding(.leading,20)
                    .padding(.trailing,20)
                
                Text("Profile")
            }.tabItem {
                Text("Profile")
            }.tag(1)
            
            VStack{
                HStack{
                    VStack{
                        Image("PomodoroNinjaSolo-2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 64)
                    }.padding()
                    
                    VStack{
                        Text("Hello, user!")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 18))
                            .padding(.bottom,5)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                                   alignment: .leading)
                        
                        Text("You are level ?")
                            .font(.system(size: 14))
                            .padding(.bottom,5)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                                   alignment: .leading)
                    }.padding()
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,maxWidth: .infinity)
                    .padding(.leading,20)
                    .padding(.trailing,20)
                
                Text("History Screen")
            }.tabItem {
                Text("History")
            }.tag(2)
            
            VStack{
                HStack{
                    VStack{
                        Image("PomodoroNinjaSolo-2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 64)
                    }.padding()
                    
                    VStack{
                        Text("Hello, user!")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 18))
                            .padding(.bottom,5)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                                   alignment: .leading)
                        
                        Text("You are level ?")
                            .font(.system(size: 14))
                            .padding(.bottom,5)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                                   alignment: .leading)
                    }.padding()
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,maxWidth: .infinity)
                    .padding(.leading,20)
                    .padding(.trailing,20)
                
                Text("Achievements screen")
            }.tabItem {
                Text("Achievements")
            }.tag(3)
            
            VStack{
                HStack{
                    VStack{
                        Image("PomodoroNinjaSolo-2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 64)
                    }.padding()
                    
                    VStack{
                        Text("Hello, user!")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 18))
                            .padding(.bottom,5)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                                   alignment: .leading)
                        
                        Text("You are level ?")
                            .font(.system(size: 14))
                            .padding(.bottom,5)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                                   alignment: .leading)
                    }.padding()
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,maxWidth: .infinity)
                    .padding(.leading,20)
                    .padding(.trailing,20)
                
                Text("My studies screen")
            }.tabItem {
                Text("My Studies").padding(.bottom,10)
            }.tag(4)
        }.onAppear(){
                UITabBar.appearance().backgroundColor =  .systemGray5
            }
    }
}

#Preview {
    HomeView()
}
