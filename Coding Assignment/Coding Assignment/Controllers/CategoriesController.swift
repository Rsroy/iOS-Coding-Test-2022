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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var dataModel = [CategoriesModel]()
    var categoriesArray = [String]()
    let cellReuseIdentifier = Constants.categories_tableview_cell_identifier
    var isFirstTimeLoad = true
    private let httpUtility = HttpUtility()

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
    // Tableview delegate and datasource methods..
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
    
        if item.lowercased() == Categories.Books.rawValue {
            // Get data for Books...
            httpUtility.getApiData(requestUrl: url, requestType: [Book].self) { result in
                self.showBooksScreen(for: result, item: item)
            }
            
        } else if item.lowercased() == Categories.Houses.rawValue {
            // Get Data for House...
            httpUtility.getApiData(requestUrl: url, requestType: [House].self) { result in
                self.showHouseScreen(for: result, item: item)
            }
            
        } else if item.lowercased() == Categories.Characters.rawValue {
            //Get Data for Character...
            httpUtility.getApiData(requestUrl: url, requestType: [Character].self) { result in
                self.showCharacterScreen(for: result, item: item)
            }
            
        }
    }

    fileprivate func showBooksScreen(for data: [Book], item: String) {
        DispatchQueue.main.async {
            let itemsView = self.getItemViewControllerObj()
            itemsView.item = item
            itemsView.booksDataModel = data
            self.activityIndicator.isHidden = true
            self.navigationController?.pushViewController(itemsView, animated: true)
        }
    }
    
    fileprivate func showHouseScreen(for data: [House], item: String) {
        DispatchQueue.main.async {
            let itemsView = self.getItemViewControllerObj()
            itemsView.item = item
            itemsView.housesDataModel = data
            self.activityIndicator.isHidden = true
            self.navigationController?.pushViewController(itemsView, animated: true)
        }
    }
    
    fileprivate func showCharacterScreen(for data: [Character], item: String) {
        DispatchQueue.main.async {
            let itemsView = self.getItemViewControllerObj()
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
    
    fileprivate func getItemViewControllerObj() -> ItemsListController {
        return self.storyboard?.instantiateViewController(withIdentifier: "ItemsListController") as! ItemsListController
    }
}
