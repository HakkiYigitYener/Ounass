//
//  ProductDetailAccordionHeader.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import UIKit

protocol ProductDetailAccordionHeaderDelegate: AnyObject {
    func didAccordionHeaderTouched(section: Int)
}

class ProductDetailAccordionHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerArrowImageView: UIImageView!
    
    private(set) var section: Int = 0
    
    weak var delegate: ProductDetailAccordionHeaderDelegate?
    
    func setupHeader(title: String, isOpen:Bool, section: Int, delegate: ProductDetailAccordionHeaderDelegate) {
        self.delegate = delegate
        self.section = section
        headerTitleLabel.text = title
        headerArrowImageView.setRotation(angle: isOpen ? 180 : 0)
    }
    @IBAction func toggleButtonTouched(_ sender: Any) {
        delegate?.didAccordionHeaderTouched(section: section)
    }
}
