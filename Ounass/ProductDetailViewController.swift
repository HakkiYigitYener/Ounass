//
//  ProductDetailViewController.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import UIKit

class ProductDetailViewController: UIViewController {
    var product: Product!

    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.shared.fetchProductDetail(sku: "214660294") { product in
           print(product)
       }
    }
}
