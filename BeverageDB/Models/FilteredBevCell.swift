//
//  FilteredBevCell.swift
//  BeverageDB
//
//  Created by Gugu Ndaba on 2021/08/04.
//

import UIKit

class FilteredBevCell: UITableViewCell {
    @IBOutlet weak var filteredBevImageView: UIImageView!
    @IBOutlet weak var filteredBevLabel: UILabel!
    
    var drink: BeverageInfo?
    
    func setFilteredBev(drink: BeverageInfo) {
        filteredBevImageView.downloadImage(from: drink.strDrinkThumb!)
        filteredBevLabel.text = drink.strDrink
        filteredBevImageView.layer.cornerRadius = filteredBevImageView.frame.size.width/2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
