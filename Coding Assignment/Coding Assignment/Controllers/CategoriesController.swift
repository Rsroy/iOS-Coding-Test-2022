//
//  CategoriesViewController.swift
//  Coding Assignment
//
//  Created by RAHUL SINGHA ROY on 18/10/22.
//

import UIKit
import CoreData

class CategoriesController: UIViewController {
    @IBOutlet weak var categoriesTableView: UITableView!
    var dataModel = [CategoriesModel]()
    var categoriesArray = [String]()
    let cellReuseIdentifier = Constants.categories_tableview_cell_identifier
    var isFirstTimeLoad = true
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        loadTableView()
    }
    
    func loadTableView() {
        if isFirstTimeLoad {
            // Prepare data for tableview
            for dataItems in dataModel {
                let categoryName = dataItems.category_name
                categoriesArray.append(categoryName)
            }
            // Sorting the category names..
            categoriesArray = categoriesArray.sorted(by: { $1 > $0 })
        }

        // Reload TableView..
        categoriesTableView.reloadData()
    }
}

extension CategoriesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        if let cell = self.categoriesTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? CategoriesTableViewCell {
            cell.categoriesLabel.text = categoriesArray[indexPath.row]
            
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activityIndicator.isHidden = false
        loadItemsData(for: categoriesArray[indexPath.row])
    }
    
    func loadItemsData(for item: String) {
        let itemUrlString = getItemsUrl(for: item)
        let url = URL(string: itemUrlString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
                if let data = data, let body = String(data: data, encoding: .utf8) {
                    let jsonData = body.data(using: .utf8)!
                    let decoder = JSONDecoder()
                    print(body)
                    do {
                        
                        if item.lowercased() == "books" {
                            let structModelData = try decoder.decode([Book].self, from: jsonData)
                            self.showBooksScreen(for: structModelData, item: item)
                        } else if item.lowercased() == "houses" {
                            let structModelData = try decoder.decode([House].self, from: jsonData)
                            self.showHouseScreen(for: structModelData, item: item)
                        } else if item.lowercased() == "characters" {
                            let structModelData = try decoder.decode([Character].self, from: jsonData)
                            self.showCharacterScreen(for: structModelData, item: item)
                        }
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } else {
                print(error ?? "API Error")
            }
        }
        
        task.resume()
    }
    
    fileprivate func showBooksScreen(for data: [Book], item: String) {
        DispatchQueue.main.async {
            let itemsView = self.storyboard?.instantiateViewController(withIdentifier: "ItemsListController") as! ItemsListController
            itemsView.item = item
            itemsView.booksDataModel = data
            self.activityIndicator.isHidden = true
            self.navigationController?.pushViewController(itemsView, animated: true)
        }
    }
    
    fileprivate func showHouseScreen(for data: [House], item: String) {
        DispatchQueue.main.async {
            let itemsView = self.storyboard?.instantiateViewController(withIdentifier: "ItemsListController") as! ItemsListController
            itemsView.item = item
            itemsView.housesDataModel = data
            self.activityIndicator.isHidden = true
            self.navigationController?.pushViewController(itemsView, animated: true)
        }
    }
    
    fileprivate func showCharacterScreen(for data: [Character], item: String) {
        DispatchQueue.main.async {
            let itemsView = self.storyboard?.instantiateViewController(withIdentifier: "ItemsListController") as! ItemsListController
            itemsView.item = item
            itemsView.characterDataModel = data
            self.activityIndicator.isHidden = true
            self.navigationController?.pushViewController(itemsView, animated: true)
        }
    }

    /// Function to prepare items url
    /// - Parameter item: item name
    /// - Returns: item url
    func getItemsUrl(for item: String) -> String {
        switch item.lowercased() {
        case "books":
            return API.categoryDetailsUrl + Constants.itemId_books
        case "characters":
            return API.categoryDetailsUrl + Constants.itemId_characters
        case "houses":
            return API.categoryDetailsUrl + Constants.itemId_houses
        default:
            break
        }
        
        return ""
    }
    
}
