//
//  ProductDetailAccordionCell.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import UIKit

class ProductDetailAccordionCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(descriptionText: String) {
        descriptionLabel.attributedText = descriptionText.htmlToAttributedString
    }
    
}
