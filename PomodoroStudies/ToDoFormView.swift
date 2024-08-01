//
//  ToDoFormView.swift
//  PomodoroStudies
//
//  Created by user264550 on 7/31/24.
//

import SwiftUI

struct ToDoFormView: View {
    @ObservedObject var viewModel: ToDoViewModel
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    
    var body: some View {
        Form{
            Section(header: Text("Ad your task:")){
                TextField("Task", text: $viewModel.title)
                Button(action:{viewModel.addToDo()
                    alertTitle = "Task Added"
                    alertMessage = "Congratulations"
                    showAlert = true
                }){
                    Text("Add")
                }.alert(isPresented: $showAlert){
                    Alert(title: Text(alertTitle), message: Text(alertMessage))
                }
            
                Button(action:{viewModel.removeToDo()
                    alertTitle = "Task Removed"
                    alertMessage = "Congratulations"
                    showAlert = true
                }){
                    Text("Remove")
                }.alert(isPresented: $showAlert){
                    Alert(title: Text(alertTitle), message: Text(alertMessage))
                }
                Button(action:{viewModel.clearCompleted()
                    alertTitle = "Cleared All Completed"
                    alertMessage = "Congratulations"
                    showAlert = true
                    
                }){
                    Text("Clear Completed")
                }
                .alert(isPresented: $showAlert){
                    Alert(title: Text(alertTitle), message: Text(alertMessage))
                }
                
                }
            }
        }
    }
