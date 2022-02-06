//
//  ProductTitleCell.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import UIKit

class ProductTitleCell: UITableViewCell {

    @IBOutlet weak var designerNameLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(designerName: String,
                   productName: String,
                   price:Double) {
        designerNameLabel.text = designerName
        productNameLabel.text = productName
        priceLabel.text = price.formattedPrice
    }
    
}
