//
//  RelatedProductsCell.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import UIKit

class RelatedProductsCell: UITableViewCell {

    @IBOutlet weak var relatedProductsCollectionView: UICollectionView!
    var dataSource: [Product] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        relatedProductsCollectionView.register(UINib.init(nibName: "ProductListCell", bundle: nil), forCellWithReuseIdentifier: "ProductListCell")
    }
    
    func setupCell(products: [Product]) {
        self.dataSource = products
        relatedProductsCollectionView.reloadData()
    }
}

extension RelatedProductsCell: UICollectionViewDelegate {
    
}

extension RelatedProductsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        let product = dataSource[indexPath.row]
        cell.setupCell(designerName: product.designerCategoryName,
                       productName: product.name,
                       price: product.price,
                       imagePath: product.media.first?.src)
        return cell
    }
}
