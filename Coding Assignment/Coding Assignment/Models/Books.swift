//
//  Books.swift
//  Coding Assignment
//
//  Created by RAHUL SINGHA ROY on 16/10/22.
//

import Foundation

struct BookElement: Codable {
    let name, isbn: String
    let authors: [String]
    let numberOfPages: Int
    let publisher, country, mediaType, released: String
}

typealias Book = [BookElement]
