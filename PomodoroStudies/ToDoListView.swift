//
//  ToDoListView.swift
//  PomodoroStudies
//
//  Created by user264550 on 7/31/24.
//

import SwiftUI

struct ToDoListView: View {
    
    @ObservedObject var viewModel: ToDoViewModel
    
    var body: some View {
        List {
            ForEach($viewModel.todos) { $todo in
                HStack {
                    Toggle(isOn: $todo.completed) {
                        Text(todo.title).font(.headline)
                    }
                }
            }
        }
    }
}
