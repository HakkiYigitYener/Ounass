//
//  ProductDetailViewController.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import UIKit
import ImageSlideshow

class ProductDetailViewController: UIViewController {
    
    enum DataModel {
        case slider([Media])
        case title(designer: String, name: String, price: Double)
    }
    
    @IBOutlet weak var productTableView: UITableView!
    var product: Product!
    
    var dataSource:[DataModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDataSource()
    }
    
    func setupUI() {
        productTableView.register(UINib.init(nibName: "ProductDetailSliderCell", bundle: nil), forCellReuseIdentifier: "ProductDetailSliderCell")
        productTableView.register(UINib.init(nibName: "ProductTitleCell", bundle: nil), forCellReuseIdentifier: "ProductTitleCell")
    }
    
    func setupDataSource() {
        dataSource.append(.slider(product.media))
        dataSource.append(.title(designer: product.designerCategoryName, name: product.name, price: product.price))
    }
}

extension ProductDetailViewController: UITableViewDelegate {
    
}

extension ProductDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
        case .slider(let medias):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailSliderCell", for: indexPath) as! ProductDetailSliderCell
            cell.setupCell(medias: medias, delegate: self)
            return cell
        case .title(let designer, let name, let price):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTitleCell", for: indexPath) as! ProductTitleCell
            cell.setupCell(designerName: designer,
                           productName: name,
                           price: price)
            return cell
        }
    }
    
    
}

extension ProductDetailViewController: ProductDetailSliderCellDelegate {
    func didTapSliderImage(imageSlideView: ImageSlideshow) {
        imageSlideView.presentFullScreenController(from: self)
    }
}
