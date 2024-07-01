//
//  User.swift
//  PomodoroStudies
//
//  Created by Fadrick Barroso on 2024-06-21.
//

import Foundation

struct User:Identifiable, Codable{
    var id: String = UUID().uuidString
    var name: String
    var password: String
}
