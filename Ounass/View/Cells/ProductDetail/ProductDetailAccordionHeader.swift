//
//  ProductDetailAccordionHeader.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import UIKit

class ProductDetailAccordionHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerArrowImageView: UIImageView!
    
    func setupHeader(title: String, isOpen:Bool) {
        headerTitleLabel.text = title
        headerArrowImageView.setRotation(angle: isOpen ? 180 : 0)
    }
}
