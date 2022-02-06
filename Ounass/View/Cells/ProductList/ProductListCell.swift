//
//  ProductListCell.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import UIKit
import Kingfisher

class ProductListCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var designerNameLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setupCell(designerName: String,
                   productName: String,
                   price:Double,
                   imagePath:String?) {
        designerNameLabel.text = designerName
        productNameLabel.text = productName
        priceLabel.text = price.formattedPrice
        productImageView.setListImage(imagePath: imagePath)
    }

}
