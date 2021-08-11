//
//  IngredientsCell.swift
//  BeverageDB
//
//  Created by Gugu Ndaba on 2021/08/04.
//

import UIKit

class IngredientsCell: UITableViewCell {
    @IBOutlet weak var ingrLbl: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var qtyLbl: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
