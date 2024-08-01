//
//  ToDoViewModel.swift
//  PomodoroStudies
//
//  Created by user264550 on 7/31/24.
//

import Foundation

class ToDoViewModel: ObservableObject{
    
    @Published var todos: [ToDo] = []
    @Published var title: String = ""
    
    
    func addToDo(){
        let newToDo = ToDo(title: title)
        todos.append(newToDo)
        title = ""
    }
    
    func removeToDo(){
        todos.removeLast()
    }
    
    func clearCompleted() {
            todos.removeAll { $0.completed }
        }

    
}
