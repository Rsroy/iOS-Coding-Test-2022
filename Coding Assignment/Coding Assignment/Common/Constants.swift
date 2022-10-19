//
//  Constants.swift
//  Coding Assignment
//
//  Created by RAHUL SINGHA ROY on 16/10/22.
//

import Foundation

struct API {
    static let categoriesUrl: String = "https://private-anon-eed9a06ffe-androidtestmobgen.apiary-mock.com/categories"
    static let categoryDetailsUrl: String = "https://private-anon-0bad31d22c-androidtestmobgen.apiary-mock.com/list/"
}

struct Constants {
    static let categories_isloaded_key: String = "isCategoriesLoaded"
    static let categories_data_key: String = "app.start.categories"
    static let categories_tableview_cell_identifier = "categoriesCell"
    static let items_tableview_cell_identifier = "ItemsCell"
    
    static let itemId_books = "1"
    static let itemId_characters = "3"
    static let itemId_houses = "2"
}

enum Categories: String, Codable {
    case Books = "books"
    case Characters = "characters"
    case Houses = "houses"
}
