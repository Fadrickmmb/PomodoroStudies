//
//  ToDo.swift
//  PomodoroStudies
//
//  Created by user264550 on 7/31/24.
//

import Foundation

struct ToDo: Identifiable{
    var id = UUID()
    var title: String
    var completed: Bool
    
    init(title: String, completed: Bool = false){
        self.title = title
        self.completed = completed
    }
}
