//
//  ProductOptionCell.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 7.02.2022.
//

import UIKit

protocol ProductOptionsCellDelegate: AnyObject {
    func didOptionSelected(attribute: ConfigurableAttribute, option: ConfigurableAttributeOption)
}


class ProductOptionsCell: UITableViewCell {

    @IBOutlet private weak var optionNameLabel: UILabel!
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    weak var delegate: ProductOptionsCellDelegate?
    private var attribute: ConfigurableAttribute?
    private var selectedOption: ConfigurableAttributeOption?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupUI() {
        optionsCollectionView.register(cellType: ProductOptionItemCell.self, bundle: nil)
    }
    
    func setupCell(attribute: ConfigurableAttribute, selectedOption: ConfigurableAttributeOption?, delegate: ProductOptionsCellDelegate) {
        self.delegate = delegate;
        self.attribute = attribute
        self.selectedOption = selectedOption
        optionNameLabel.text = getOptionName(from: attribute.code) 
        optionsCollectionView.reloadData()
    }
    
    func getOptionName(from code: String) -> String {
        switch code {
        case "color":
            return "Color"
        case "sizeCode":
            return "Size"
        default:
            return ""
        }
    }
    
}


extension ProductOptionsCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let attribute = attribute else { return }
        let option = attribute.options[indexPath.row]
        delegate?.didOptionSelected(attribute: attribute, option: option)
    }
}

extension ProductOptionsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attribute?.options.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let attribute = attribute else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(with: ProductOptionItemCell.self, for: indexPath)
        let option = attribute.options[indexPath.row]
        cell.setupCell(optionName: option.label, isSelected: selectedOption?.optionID == option.optionID)
        return cell
    }
}
