//
//  ItemsTableViewCell.swift
//  Coding Assignment
//
//  Created by RAHUL SINGHA ROY on 18/10/22.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {
    @IBOutlet weak var itemDescription: UILabel!
    
    @IBOutlet weak var itemLogo: UIImageView!
    @IBOutlet weak var itemLogoWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
