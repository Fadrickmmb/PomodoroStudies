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
                Image(systemName: "house").padding(.top,10)
                Text("Home").padding(.bottom,10)
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
                Image(systemName: "person").padding(.top,10)
                Text("Profile").padding(.bottom,10)
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
                Image(systemName: "clock").padding(.top,10)
                Text("History").padding(.bottom,10)
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
                Image(systemName: "star").padding(.top,10)
                Text("Achievements").padding(.bottom,10)
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
                Image(systemName: "book").padding(.top,10)
                Text("My Studies").padding(.bottom,10)
            }.padding(5).tag(4)
        }.onAppear(){
                UITabBar.appearance().backgroundColor =  .systemGray5
            }
    }
}

#Preview {
    HomeView()
}
