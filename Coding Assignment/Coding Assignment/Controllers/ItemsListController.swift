//
//  ItemsViewController.swift
//  Coding Assignment
//
//  Created by RAHUL SINGHA ROY on 18/10/22.
//

import UIKit

class ItemsListController: UIViewController {
    @IBOutlet weak var itemsTableView: UITableView!
    var item: String!
    var booksDataModel: [Book]?
    var housesDataModel: [House]?
    var characterDataModel: [Character]?
    let cellReuseIdentifier = Constants.items_tableview_cell_identifier
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        loadTableView()
    }
    
    func loadTableView() {
        // Reload TableView..
        itemsTableView.reloadData()
    }

    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ItemsListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch item.lowercased() {
        case Categories.Books.rawValue:
            return booksDataModel?.count ?? 0
        case Categories.Characters.rawValue:
            return characterDataModel?.count ?? 0
        case Categories.Houses.rawValue:
            return housesDataModel?.count ?? 0
        default:
            break
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch item.lowercased() {
        case Categories.Books.rawValue:
            return prepareBooksCell(for: indexPath)
        case Categories.Characters.rawValue:
            return prepareCharacterCell(for: indexPath)
        case Categories.Houses.rawValue:
            return prepareHousesCell(for: indexPath)
        default:
            break
        }
        return UITableViewCell()
    }
    
    /// Function to prepare the tableview cells with json data
    /// - Parameter indexPath: indexpath
    /// - Returns: Items tableview cell object
    fileprivate func prepareBooksCell(for indexPath: IndexPath) -> ItemsTableViewCell {
        if let cell = self.itemsTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? ItemsTableViewCell {
            var bookInfoString = ""
            bookInfoString.append("\n")
            bookInfoString.append("Name - ")
            bookInfoString.append(booksDataModel?[indexPath.row].name ?? "")
            bookInfoString.append("\n")
            bookInfoString.append("ISBN - ")
            bookInfoString.append(booksDataModel?[indexPath.row].isbn ?? "")
            bookInfoString.append("\n")
            bookInfoString.append("Authors - ")
            let authors = booksDataModel?[indexPath.row].authors.joined(separator: ", ")
            bookInfoString.append(authors ?? "")
            bookInfoString.append("\n")
            bookInfoString.append("Number Of Pages - ")
            bookInfoString.append(String(booksDataModel?[indexPath.row].numberOfPages ?? 0))
            bookInfoString.append("\n")
            bookInfoString.append("Publisher - ")
            bookInfoString.append(booksDataModel?[indexPath.row].publisher ?? "")
            bookInfoString.append("\n")
            bookInfoString.append("Country - ")
            bookInfoString.append(booksDataModel?[indexPath.row].country ?? "")
            bookInfoString.append("\n")
            bookInfoString.append("Media Type - ")
            bookInfoString.append(booksDataModel?[indexPath.row].mediaType ?? "")
            bookInfoString.append("\n")
            // Cell label display
            cell.itemDescription.text = bookInfoString
            cell.selectionStyle = .none
            cell.itemLogoWidth.constant = 1
            return cell
        }
        return ItemsTableViewCell()
    }
    
    fileprivate func prepareCharacterCell(for indexPath: IndexPath) -> ItemsTableViewCell {
        if let cell = self.itemsTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? ItemsTableViewCell {
            var characterInfoString = ""
            characterInfoString.append("\n")
            characterInfoString.append("Name - ")
            characterInfoString.append(characterDataModel?[indexPath.row].name ?? "")
            characterInfoString.append("\n")
            characterInfoString.append("Gender - ")
            characterInfoString.append(characterDataModel?[indexPath.row].gender.rawValue ?? "")
            characterInfoString.append("\n")
            characterInfoString.append("Born - ")
            characterInfoString.append(characterDataModel?[indexPath.row].born ?? "")
            characterInfoString.append("\n")
            characterInfoString.append("Died - ")
            characterInfoString.append(characterDataModel?[indexPath.row].died ?? "")
            characterInfoString.append("\n")
            characterInfoString.append("Titles - ")
            characterInfoString.append(characterDataModel?[indexPath.row].died ?? "")
            characterInfoString.append("\n")
            let titles = characterDataModel?[indexPath.row].titles.joined(separator: ", ")
            characterInfoString.append(titles ?? "")
            characterInfoString.append("\n")
            // Cell label display
            cell.itemDescription.text = characterInfoString
            cell.selectionStyle = .none
            cell.itemLogoWidth.constant = 1
            return cell
        }
        return ItemsTableViewCell()
    }
    
    fileprivate func prepareHousesCell(for indexPath: IndexPath) -> ItemsTableViewCell {
        if let cell = self.itemsTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? ItemsTableViewCell {
            var housesInfoString = ""
            housesInfoString.append("\n")
            housesInfoString.append("Name - ")
            housesInfoString.append(housesDataModel?[indexPath.row].name ?? "")
            housesInfoString.append("\n")
            housesInfoString.append("Region - ")
            housesInfoString.append(housesDataModel?[indexPath.row].region ?? "")
            housesInfoString.append("\n")
            housesInfoString.append("Title - ")
            housesInfoString.append(housesDataModel?[indexPath.row].title ?? "")
            housesInfoString.append("\n")
            
            switch housesDataModel?[indexPath.row].region ?? "" {
            case "The North":
                cell.itemLogo.download(from: "https://bit.ly/2Gcq0r4")
            case "The Vale":
                cell.itemLogo.download(from: "https://bit.ly/34FAvws")
            case "The Riverlands OR Iron Islands":
                cell.itemLogo.download(from: "https://bit.ly/3kJrIiP")
            case "The Westerlands":
                cell.itemLogo.download(from: "https://bit.ly/2TAzjnO")
            case "The Reach":
                cell.itemLogo.download(from: "https://bit.ly/2HSCW5N")
            case "Dorne":
                cell.itemLogo.download(from: "https://bit.ly/2HOcavT")
            case "The Stormlands":
                cell.itemLogo.download(from: "https://bit.ly/34F2sEC")
            default:
                break
            }

            // Cell label display
            cell.itemDescription.text = housesInfoString
            cell.selectionStyle = .none
            cell.itemLogoWidth.constant = 124
            return cell
        }
        return ItemsTableViewCell()
    }
    
}

// Mark: - UIImage view extention for smooth image download..
extension UIImageView {
    func download(from url: URL) {
        contentMode = .scaleAspectFit
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }

    func download(from link: String) {
        guard let url = URL(string: link) else { return }
        download(from: url)
    }
}

