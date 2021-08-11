//
//  BevCell.swift
//  BeverageDB
//
//  Created by Gugu Ndaba on 2021/08/04.
//

import UIKit

class BevCell: UITableViewCell {

    @IBOutlet weak var bevCellImageView: UIImageView!
    @IBOutlet weak var bevCellLabel: UILabel!
    
    var drink: BeverageInfo?
    
    func setBeverage(drink: BeverageInfo) {
        bevCellImageView.downloadImage(from: drink.strDrinkThumb!)
        bevCellLabel.text = drink.strDrink
        bevCellImageView.layer.cornerRadius = bevCellImageView.frame.size.width/2
    }
}
