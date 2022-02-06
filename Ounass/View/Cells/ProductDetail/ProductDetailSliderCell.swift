//
//  ProductDetailSliderCell.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import UIKit
import ImageSlideshow

protocol ProductDetailSliderCellDelegate: AnyObject {
    func didTapSliderImage(imageSlideView: ImageSlideshow)
}

class ProductDetailSliderCell: UITableViewCell {

    @IBOutlet weak var imageSlideView: ImageSlideshow!
    
    weak var delegate: ProductDetailSliderCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTouchGestureToImageSlider()
    }
    
    func addTouchGestureToImageSlider() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProductDetailSliderCell.didTap))
        imageSlideView.addGestureRecognizer(gestureRecognizer)
    }

    func setupCell(medias: [Media], delegate: ProductDetailSliderCellDelegate) {
        self.delegate = delegate
        imageSlideView.setMediaInputs(medias: medias)
    }
    
    @objc func didTap() {
        delegate?.didTapSliderImage(imageSlideView: imageSlideView)
    }
}
