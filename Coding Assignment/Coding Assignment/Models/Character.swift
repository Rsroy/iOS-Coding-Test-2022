//
//  Character.swift
//  Coding Assignment
//
//  Created by RAHUL SINGHA ROY on 18/10/22.
//

import Foundation

struct Character: Codable {
    let id, name: String
    let gender: Gender
    let culture, born, died: String
    let titles, aliases: [String]
    let father, mother, spouse: String
    let allegiances: [String]
    let playedBy: [String]
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
}
