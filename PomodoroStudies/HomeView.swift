import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct HomeView: View {
    @State private var selectedTab = 0
    @State private var name = ""
    @State private var userlevel = 0
    @State private var password = ""
    @State private var newPassword = ""
    @State private var points = "0"
    @State private var sectionname = ""
    @State private var progress: Float = 0.0
    @State private var focusCount = 0
    @State private var restCount = 0
    @StateObject private var vm = ViewModel()
    @State private var currentPommieID: String? = nil
    @State private var pommies: [Pommie] = []

    
    @EnvironmentObject var viewModel: ToDoViewModel
    @Environment(\.presentationMode) var presentationMode

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            // Pomodoro Tab - Home
            VStack {
                HStack {
                    VStack {
                        Image("PomodoroNinjaSolo-2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 64)
                    }.padding()
                    
                    VStack {
                        Text("Hello, " + name + "!")
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                            .padding(.bottom, 5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("You are level " + String(userlevel) + ".")
                            .font(.system(size: 14))
                            .padding(.bottom, 5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.padding()
                    
                    Button(action: {
                        logOut()
                    }) {
                        Image(systemName: "rectangle.portrait.and.arrow.right").padding()
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                
                TextField("", text: $sectionname, prompt: Text("Section's name"))
                    .multilineTextAlignment(.center)
                    .padding(.top, 15)
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                VStack {
                    Text("\(vm.time)")
                        .font(.system(size: 70, weight: .medium))
                        .padding()
                        .frame(width: 280)
                        .background(.thinMaterial)
                        .cornerRadius(40)
                        .overlay(RoundedRectangle(cornerRadius: 40)
                            .stroke(.red, lineWidth: 10))
                    
                    HStack {
                        Button {
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
                        }
                        .disabled(vm.isActive)
                        .padding(.bottom, 20)
                        
                        Button {
                            reset()
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
                        }
                        .disabled(vm.isActive)
                        .padding(.bottom, 20)
                    }
                    
                    HStack {
                        // Focus Button
                        Text("Focus")
                            .foregroundStyle(vm.minutes > 29.45 ? .white : .gray.opacity(0.3))
                            .fontWeight(vm.minutes > 29.45 ? .bold : .regular)
                            .font(.system(size: 24))
                            .padding()
                            .frame(width: 120, height: 40)
                            .background(vm.minutes > 29.45 ? Color.red : Color.gray.opacity(0.3))
                            .cornerRadius(30)
                        
                        // Rest Button
                        Text("Rest")
                            .foregroundStyle(vm.minutes <= 29.45 && vm.minutes > 29.30 ? .white : .gray.opacity(0.3))
                            .fontWeight(vm.minutes <= 29.45 && vm.minutes > 29.30 ? .bold : .regular)
                            .font(.system(size: 24))
                            .padding()
                            .frame(width: 120, height: 40)
                            .background(vm.minutes <= 29.45 && vm.minutes > 29.30 ? Color.red : Color.gray.opacity(0.3))
                            .cornerRadius(30)
                    }

                }
                .onReceive(timer) { _ in
                    vm.upDateCountdown()
                    
                    if vm.time == "29:45"{
                        addOrUpdatePommie()
                        focusCount += 1
                    }
                    if vm.time == "29:30"{
                        restCount += 1
                        vm.reset()
                    }
                    
                }
                
                HStack {
                    VStack {
                        Text("\(focusCount)")
                            .foregroundStyle(Color.gray.opacity(0.8))
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                        Text("Focus")
                            .foregroundStyle(Color.gray.opacity(0.8))
                            .font(.system(size: 24))
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                    }.padding()
                    
                    Divider()
                        .frame(width: 3, height: 100)
                        .overlay(.gray)
                        .padding(.top, 20)
                    
                    VStack {
                        Text("\(restCount)")
                            .foregroundStyle(Color.gray.opacity(0.8))
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                        Text("Rest")
                            .foregroundStyle(Color.gray.opacity(0.8))
                            .font(.system(size: 24))
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                    }.padding()
                }
                .padding(.top, 30)
                .padding(.bottom, 30)
                .frame(width: 400, height: 100)
            }
            .tabItem {
                Image(systemName: "house").padding(.top, 10)
                Text("Home").padding(.bottom, 10)
            }.tag(0)
            
            // Profile Tab
            ZStack {
                Color.red.opacity(1.0).ignoresSafeArea()
                VStack {
                    HStack {
                        Image("BlackMask")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                    }.padding(40)
                    
                    VStack(alignment: .leading) {
                        Text("Name")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                            .padding(.bottom, 10)
                        
                        TextField("", text: $name, prompt: Text("First Name")
                            .foregroundColor(.white)
                            .font(.system(size: 16)))
                        .foregroundColor(.white)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                        
                        Divider().frame(height: 2)
                            .overlay(.white)
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                            .padding(.bottom, 20)
                        
                    
                        Text("New Password")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                            .padding(.bottom, 10)
                        
                        SecureField("", text: $newPassword, prompt: Text("New Password")
                            .foregroundColor(.white)
                            .font(.system(size: 16)))
                        .foregroundColor(.white)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                        
                        Divider().frame(height: 2)
                            .overlay(.white)
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                            .padding(.bottom, 20)
                    }
                    
                    VStack {
                        Button(action: saveUserDetails) {
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
                        }.padding(.bottom, 20)
                        
                        Button(action: logOut) {
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
                        }.padding(.bottom, 20)
                    }
                }
            }
            .tabItem {
                Image(systemName: "person").padding(.top, 10)
                Text("Profile").padding(.bottom, 10)
            }.tag(1)
            
            // History tab
            ZStack {
                ScrollView {
                    Spacer(minLength: 30)
                    VStack {
                        Text("Your Last Pommies")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding()
                        
                        ForEach(pommies, id: \.id) { pommie in
                            HStack {
                                Text(pommie.name)
                                    .font(.headline)
                                    .padding(.leading)

                                Spacer()

                                Text("Completed Poms: \(pommie.completedPoms)")
                                    .padding(.trailing)
                                }
                                .padding(.vertical)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    
                    }
                }
            }.tabItem {
                Image(systemName: "clock").padding(.top, 10)
                Text("History").padding(.bottom, 10)
            }
            .tag(2)
            .onAppear{
                fetchUserData()
                fetchLast10Pommies()
            }
            
            
            // Achievements Tab
            VStack {
                HStack(alignment: .center) {
                    VStack {
                        HStack {}.background(Color.black)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                        Text("Hello " + name)
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 60)
                        Image(getImageForLevel())
                            .resizable()
                            .scaledToFill()
                            .frame(width: 260, height: 240)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .background(LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .bottom, endPoint: .top))
                .padding(.top, 20)
                
                HStack {
                    VStack {
                        HStack {
                            Text("Level ")
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                            Text(String(userlevel))
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                        }.padding(40)
                        
                        
                        Text("Points missing to Level \(userlevel + 1)")
                            
                            let splitPoints = points.split(separator: "/")
                            if splitPoints.count == 2,
                               let currentXP = Float(splitPoints[0].trimmingCharacters(in: .whitespacesAndNewlines)),
                               let totalXP = Float(splitPoints[1].trimmingCharacters(in: .whitespacesAndNewlines)) {
                                
                                ProgressView(value: currentXP, total: totalXP)
                                    .padding(20)
                            } else {
                                Text("Invalid XP data").foregroundColor(.red)
                            }
                            
                            Text(points)
                        }.padding()
                }
            }.tabItem {
                Image(systemName: "star").padding(.top, 10)
                Text("Achievements").padding(.bottom, 10)
            }.tag(3)
            
            // Commenting out My Studies Tab
            /*
            ZStack {
                VStack(alignment: .center) {
                    HStack {
                        Image("MyStudiesLogo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .padding(10)
                        
                        Text("My Studies")
                            .font(.title)
                            .fontWeight(.bold)
                    }.padding(30)
                    
                    VStack {
                        //ToDoFormView(viewModel: viewModel)
                        //ToDoListView(viewModel: viewModel)
                    }
                }
            }.tabItem {
                Image(systemName: "book").padding(.top, 10)
                Text("My Studies").padding(.bottom, 10)
            }.tag(4)
            */
        }
        .onAppear() {
            UITabBar.appearance().backgroundColor = .systemGray5
            fetchUserData()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func reset() {
        vm.reset()
        currentPommieID = nil
        focusCount = 0
        restCount = 0
        sectionname = ""
    }

    
    func fetchUserData() {
        guard let user = Auth.auth().currentUser else { return }
        let ref = Database.database().reference().child("users").child(user.uid)
        
        ref.observeSingleEvent(of: .value) { snapshot in
            if let data = snapshot.value as? [String: Any] {
                self.name = data["name"] as? String ?? ""
                let xp = data["xp"] as? Double ?? 0
                self.userlevel = calculateUserLevel(from: xp)
                let nextLevelXP = xpForNextLevel(currentLevel: self.userlevel)
                self.points = "\(Int(xp)) / \(Int(nextLevelXP))"
            }
        }
    }

    
    func calculateUserLevel(from xp: Double) -> Int {
        switch xp {
        case 0..<800:
            return 1
        case 800..<1500:
            return 2
        case 1500..<2700:
            return 3
        case 2700..<3800:
            return 4
        case 3800..<123456:
            return 5
        default:
            return 1
        }
    }
    
    func xpForNextLevel(currentLevel: Int) -> Double {
        switch currentLevel {
        case 1:
            return 800
        case 2:
            return 1500
        case 3:
            return 2700
        case 4:
            return 3800
        case 5:
            return 123456
        default:
            return 800
        }
    }

    
    func getImageForLevel() -> String {
        switch userlevel {
        case 1:
            return "01"
        case 2:
            return "02"
        case 3:
            return "03"
        case 4:
            return "04"
        case 5:
            return "05"
        default:
            return "01"
        }
    }

    
    
    func saveUserDetails() {
        guard let user = Auth.auth().currentUser else { return }
        let ref = Database.database().reference().child("users").child(user.uid)
        
        var updates = ["name": name]
        
        if !newPassword.isEmpty {
            user.updatePassword(to: newPassword) { error in
                if let error = error {
                    print("Failed to update password: \(error.localizedDescription)")
                } else {
                    print("Password updated successfully.")
                }
            }
        }
        
        ref.updateChildValues(updates) { error, _ in
            if let error = error {
                print("Failed to update name: \(error.localizedDescription)")
            } else {
                print("Name updated successfully.")
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            self.presentationMode.wrappedValue.dismiss()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func addOrUpdatePommie() {
        guard let user = Auth.auth().currentUser else { return }
        let ref = Database.database().reference().child("pommies").child(user.uid)
        
        if let currentPommieID = currentPommieID {
            let currentPommieRef = ref.child(currentPommieID)
            currentPommieRef.runTransactionBlock({ currentData in
                if var pommieData = currentData.value as? [String: AnyObject] {
                    var completedPoms = pommieData["completedPoms"] as? Int ?? 0
                    completedPoms += 1
                    pommieData["completedPoms"] = completedPoms as AnyObject
                    currentData.value = pommieData
                    return TransactionResult.success(withValue: currentData)
                }
                return TransactionResult.success(withValue: currentData)
            }) { error, _, _ in
                if let error = error {
                    print("Failed to update Pommie: \(error.localizedDescription)")
                } else {
                    print("Pommie updated successfully.")
                    increaseUserXP(by: 100)
                }
            }
        } else {
            let newPommie = Pommie(name: sectionname, completedPoms: 1)
            let newPommieData = [
                "id": newPommie.id.uuidString,
                "name": newPommie.name,
                "completedPoms": newPommie.completedPoms
            ] as [String : Any]
            
            ref.child(newPommie.id.uuidString).setValue(newPommieData) { error, _ in
                if let error = error {
                    print("Failed to add new Pommie: \(error.localizedDescription)")
                } else {
                    currentPommieID = newPommie.id.uuidString
                    print("New Pommie added successfully.")
                    increaseUserXP(by: 100)
                }
            }
        }
    }
    
    func increaseUserXP(by xp: Double) {
        guard let user = Auth.auth().currentUser else { return }
        let ref = Database.database().reference().child("users").child(user.uid)
        
        ref.runTransactionBlock({ currentData in
            if var userData = currentData.value as? [String: AnyObject] {
                var currentXP = userData["xp"] as? Double ?? 0
                currentXP += xp
                userData["xp"] = currentXP as AnyObject
                currentData.value = userData
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }, andCompletionBlock: { error, committed, snapshot in
            if let error = error {
                print("Failed to update user XP: \(error.localizedDescription)")
            } else {
                print("User XP updated successfully.")
            }
        })
    }
    
    
    func fetchLast10Pommies() {
        guard let user = Auth.auth().currentUser else { return }
        let ref = Database.database().reference().child("pommies").child(user.uid)
        
        ref.queryOrdered(byChild: "completedPoms").queryLimited(toLast: 10).observe(.value) { snapshot in
            var pommies: [Pommie] = []
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                if let pommieData = child.value as? [String: Any],
                   let name = pommieData["name"] as? String,
                   let completedPoms = pommieData["completedPoms"] as? Int {
                    let pommie = Pommie(name: name, completedPoms: completedPoms)
                    pommies.append(pommie)
                }
            }
            self.pommies = pommies.reversed()
        }
    }


    
}

#Preview {
    HomeView()
}
