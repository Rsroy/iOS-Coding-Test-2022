//
//  Books.swift
//  Coding Assignment
//
//  Created by RAHUL SINGHA ROY on 16/10/22.
//

import Foundation

struct Book: Codable {
    let name: String
    let isbn: String
    let authors: [String]
    let numberOfPages: Int
    let publisher, country, mediaType, released: String
}
