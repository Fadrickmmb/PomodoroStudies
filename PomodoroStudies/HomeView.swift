//
//  HomeView.swift
//  PomodoroStudies
//
//  Created by Fadrick Barroso on 2024-06-21.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @State private var selectedTab = 0
    @State private var name = ""
    @State private var userlevel = 0
    @State private var username = ""    //email provided by user
    @State private var points = "0"
    @State private var sectionname = ""
    @State private var progress: Float = 0.0
    @StateObject private var vm = ViewModel()
    
    @EnvironmentObject var viewModel: ToDoViewModel

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
                        Text("Hello, " + name + "!")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 18))
                            .padding(.bottom,5)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                                   alignment: .leading)
                        
                        Text("You are level " + String(userlevel) + ".") //add level from database
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
                
                
                TextField("", text: $sectionname, prompt: Text("Section's name")).multilineTextAlignment(.center).padding(.top,15).font(.system(size: 24)).fontWeight(.bold).padding(.bottom,20)
                
                VStack{
                    Text("\(vm.time)")
                        .font(.system(size: 70, weight: .medium))
                        .padding()
                        .frame(width: 280)
                        .background(.thinMaterial)
                        .cornerRadius(40)
                        .overlay(RoundedRectangle(cornerRadius: 40)
                            .stroke(.red, lineWidth: 10))
                        /*.alert("Pomodoro done!", isPresented:$vm.showingAlert) {
                            Button("Continue", role: .cancel){
                                
                            }
                        }.padding()*/
                    
                    HStack{
                        Button{
                            vm.start(minutes: vm.minutes)
                        } label: {
                            Text("START")
                                .foregroundColor(.white)
                                .font(.system(size: 22))
                                .bold()
                                .frame(maxWidth: 90, maxHeight: 20)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color.black)
                                )
                                .padding(.horizontal)
                            }.disabled(vm.isActive).padding(.bottom,20)
                        
                        Button{
                            vm.reset()
                        } label: {
                            Text("RESET")
                                .foregroundColor(.white)
                                .font(.system(size: 22))
                                .bold()
                                .frame(maxWidth: 90, maxHeight: 20)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color.black)
                                )
                                .padding(.horizontal)
                            }.disabled(vm.isActive).padding(.bottom,20)
                    }
                    
                    if(vm.minutes > 5.00){
                        HStack{
                            Text("Focus")
                                .foregroundStyle(.white)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .font(.system(size: 24))
                                .padding()
                        }.frame(width: 200,height: 40)
                            .background(Color.red)
                            .cornerRadius(30)
                        HStack{
                            Text("Rest")
                                .foregroundStyle(.white)
                                .font(.system(size: 24))
                                .padding()
                        }.frame(width: 120,height: 40)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(30)
                    } else {
                        if(vm.minutes < 5.00) {
                            HStack{
                                Text("Focus")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 24))
                                    .padding()
                            }.frame(width: 120,height: 40)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(30)
                            HStack{
                                Text("Rest")
                                    .foregroundStyle(.white)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .font(.system(size: 24))
                                    .padding()
                            }.frame(width: 200,height: 40)
                                .background(Color.red)
                                .cornerRadius(30)
                        }
                    }
                 }.onReceive(timer){ _ in
                    vm.upDateCountdown()
                }
                
                HStack{
                    VStack{
                        Text("1")
                            .foregroundStyle(Color.gray.opacity(0.8))
                            .font(.system(size: 40))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("Focus")
                            .foregroundStyle(Color.gray.opacity(0.8))
                            .font(.system(size: 24))
                            .padding(.leading,10)
                            .padding(.trailing,10)
                    }.padding()
                    Divider()
                        .frame(width: 3,height: 100)
                        .overlay(.gray)                        .padding(.top,20)
                    VStack{
                        Text("1")
                            .foregroundStyle(Color.gray.opacity(0.8))
                            .font(.system(size: 40))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("Rest")
                            .foregroundStyle(Color.gray.opacity(0.8))
                            .font(.system(size: 24))
                            .padding(.leading,20)
                            .padding(.trailing,20)
                    }.padding()
                }.padding(.top,30)
                    .padding(.bottom,30)
                    .frame(width: 400,height: 100)
                
                
            }.tabItem {
                Image(systemName: "house").padding(.top,10)
                Text("Home").padding(.bottom,10)
            }.tag(0)
            
            // Profile Tab
            ZStack{
                Color.red.opacity(1.0).ignoresSafeArea()
                VStack{
                    HStack{
                        Image("BlackMask")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120,height: 120)
                    }.padding(40)
                    VStack(alignment: .leading){
                        Text("Name")
                            .foregroundColor(.white)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 18))
                            .padding(.leading,40)
                            .padding(.trailing,40)
                            .padding(.bottom,10)
                        
                        TextField("", text: $name, prompt: Text("user's name")
                            .foregroundColor(.white)
                            .font(.system(size: 16)))
                        .foregroundColor(.white)
                        .padding(.leading,40)
                        .padding(.trailing,40)
                        
                        Divider().frame(height: 2)
                            .overlay(.white)
                            .padding(.leading,40)
                            .padding(.trailing,40)
                            .padding(.bottom,20)
                        
                        Text("Email")
                            .foregroundColor(.white)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 18))
                            .padding(.leading,40)
                            .padding(.trailing,40)
                            .padding(.bottom,10)
                        
                        TextField("", text: $username, prompt: Text("user's email")
                            .foregroundColor(.white)
                            .font(.system(size: 16)))
                        .foregroundColor(.white)
                        .padding(.leading,40)
                        .padding(.trailing,40)
                        
                        Divider().frame(height: 2)
                            .overlay(.white)
                            .padding(.leading,40)
                            .padding(.trailing,40)
                            .padding(.bottom,60)
                    }
                    
                    Button{
                        
                    } label: {
                        Text("Save")
                            .foregroundColor(.white)
                            .font(.system(size: 22))
                            .bold()
                            .frame(maxWidth: 100, maxHeight: 24)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color.black)
                            )
                            .padding(.horizontal)
                    }.padding(.bottom,20)
                    
                    Button{
                        
                    } label: {
                        Text("Log Out")
                            .foregroundColor(.white)
                            .font(.system(size: 22))
                            .bold()
                            .frame(maxWidth: 100, maxHeight: 24)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color.black)
                            )
                            .padding(.horizontal)
                    }.padding(.bottom,20)
                }
            }.tabItem {
                Image(systemName: "person").padding(.top,10)
                Text("Profile").padding(.bottom,10)
            }.tag(1)
            
            // History tab
            ZStack{
                ScrollView{
                    Spacer(minLength: 30)
                    VStack{
                        HStack{
                            CalendarView(interval: DateInterval(start: .distantPast, end:.distantFuture))
                                .navigationTitle("CalendarView")
                        }
                        
                        Text("Selected Date").font(.system(size: 24)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(.red).padding(.bottom,30) //retrieve from clicked date on calendar
                        
                        Text("History List View here")
                    }
                }
            }.tabItem {
                Image(systemName: "clock").padding(.top,10)
                Text("History").padding(.bottom,10)
            }.tag(2)
            
            // Achivements Tab
            
            VStack{
                HStack(alignment: .center){
                    VStack{
                        HStack{}.background(Color.black).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: 200)
                        Text("Hello " + name)
                            .font(.system(size: 50))
                            .fontWeight(.bold).foregroundColor(.white)
                            .padding(.top,60)
                        Image("02")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 260,height: 240)                    }
                    //i think here we can use the ninja of the actual level of the user
                }.frame(maxWidth: .infinity,maxHeight: 300)
                    .background(LinearGradient(gradient: Gradient(colors:[.white,.black]), startPoint: .bottom,endPoint: .top))
                    .padding(.top,20)
                HStack{
                    VStack{
                        HStack{
                            Text("Level ").font(.system(size: 40)).fontWeight(.bold)
                            Text(String(userlevel)).font(.system(size: 40))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(.red)
                        }.padding(40)
                        let ul = userlevel + 1
                        Text("Points missing to Level " + String(ul))
                        ProgressView(value: 0,total: 100).padding(20)
                        Text("220 / 400") // add points from user
                    }.padding()
                }
            }.tabItem {
                Image(systemName: "star").padding(.top,10)
                Text("Achievements").padding(.bottom,10)
            }.tag(3)
            
            // My Studies Tab
            ZStack{
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                    HStack{
                        Image("MyStudiesLogo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60,height: 60)
                            .padding(10)
                        
                        Text("My Studies")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }.padding(30)
                    
                    VStack{
                        ToDoFormView(viewModel: viewModel)
                        ToDoListView(viewModel: viewModel)
                    }
                }
            }.tabItem {
                Image(systemName: "book").padding(.top,10)
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
