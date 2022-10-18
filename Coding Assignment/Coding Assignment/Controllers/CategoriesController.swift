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
    
}
