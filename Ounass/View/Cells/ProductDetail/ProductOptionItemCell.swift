//
//  ProductOptionItemCell.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 7.02.2022.
//

import UIKit

class ProductOptionItemCell: UICollectionViewCell {

    @IBOutlet private weak var optionNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        optionNameLabel.layer.borderWidth = 2
        optionNameLabel.layer.borderColor = UIColor.systemOrange.cgColor
        optionNameLabel.layer.cornerRadius = 10
    }
    
    func setupCell(optionName: String, isSelected: Bool) {
        optionNameLabel.text = optionName
        optionNameLabel.backgroundColor = isSelected ? .systemOrange : .clear
    }

}
