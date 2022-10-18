//
//  Constants.swift
//  Coding Assignment
//
//  Created by RAHUL SINGHA ROY on 16/10/22.
//

import Foundation

struct API {
    static let categoriesUrl: String = "https://private-anon-eed9a06ffe-androidtestmobgen.apiary-mock.com/categories"
    static let booksUrl: String = "https://private-anon-0bad31d22c-androidtestmobgen.apiary-mock.com/list/1"
}

struct Constants {
    static let categories_isloaded_key: String = "isCategoriesLoaded"
    static let categories_data_key: String = "app.start.categories"
    
    static let categories_tableview_cell_identifier = "categoriesCell"
}
