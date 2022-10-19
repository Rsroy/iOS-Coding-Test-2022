//
//  ViewController.swift
//  Coding Assignment
//
//  Created by RAHUL SINGHA ROY on 15/10/22.
//

import UIKit
import CoreData

class SplashScreenController: UIViewController {
    fileprivate var isCategoriesLoaded = "false"
    let userDefaults = UserDefaults.standard
    private let httpUtility = HttpUtility()

    override func viewDidLoad() {
        super.viewDidLoad()
        isCategoriesLoaded = userDefaults.string(forKey: Constants.categories_isloaded_key) ?? ""
        if isCategoriesLoaded == "true" {
            loadCategoriesFromUserDefaults()
        } else {
            // API call for categories ..
            loadCategories()
        }
    }
    
    fileprivate func loadCategoriesFromUserDefaults() {
        var categoriesArray = [String]()
        categoriesArray = userDefaults.stringArray(forKey: Constants.categories_data_key) ?? []
        // to make the UX smooth
        do {
            sleep(1)
        }
        let categoriesView = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesController") as! CategoriesController
        categoriesView.categoriesArray = categoriesArray
        categoriesView.isFirstTimeLoad = false
        self.navigationController?.pushViewController(categoriesView, animated: true)
    }
    
    fileprivate func loadCategories() {
        let url = URL(string: API.categoriesUrl)!
        httpUtility.getApiData(requestUrl: url, requestType: [CategoriesModel].self) { result in
            self.savaData(data: result)
        }
    }
    
    fileprivate func savaData(data: [CategoriesModel]) {
        // Save data ..
        var categoriesArray = [String]()
        for dataItem in data {
            categoriesArray.append(dataItem.category_name)
        }
        // Sorting the category names..
        categoriesArray = categoriesArray.sorted(by: { $1 > $0 })
        // Saving categories in userdefaults..
        userDefaults.set(categoriesArray, forKey: Constants.categories_data_key)
        userDefaults.set("true", forKey: Constants.categories_isloaded_key)
        
        // After saving data move to next screen ..
        moveToNextScreen(data: data)
    }
    
    fileprivate func moveToNextScreen(data: [CategoriesModel]) {
        DispatchQueue.main.async {
            let categoriesView = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesController") as! CategoriesController
            categoriesView.dataModel = data
            categoriesView.isFirstTimeLoad = true
            self.navigationController?.pushViewController(categoriesView, animated: true)
        }
    }
}

