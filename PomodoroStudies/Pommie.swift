//
//  Pommie.swift
//  PomodoroStudies
//
//  Created by Fadrick Barroso on 2024-08-19.
//

import Foundation

struct Pommie:Identifiable, Codable{
    var id: UUID = UUID()
    var name: String
    var completedPoms: Int
}
