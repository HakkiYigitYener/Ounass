//
//  ProductAmberPointCell.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import UIKit

class ProductAmberPointCell: UITableViewCell {
    @IBOutlet weak var amberInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(amberPoint: Double) {
        let baseAttrString = NSMutableAttributedString.init(attributedString: "Earn ".attr(color: .label, font: .systemFont(ofSize: 14)))
        baseAttrString.append(String.init(format: "%.3f Amber ", amberPoint).attr( color: .label, font: .boldSystemFont(ofSize: 14)))
        baseAttrString.append("Points".attr( color: .label, font: .systemFont(ofSize: 14)))
        amberInfoLabel.attributedText = baseAttrString
    }
    
}
