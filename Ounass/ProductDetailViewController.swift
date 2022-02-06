//
//  ProductDetailViewController.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import UIKit
import ImageSlideshow

class ProductDetailViewController: UIViewController {
    @IBOutlet weak var imageSlideView: ImageSlideshow!
    var product: Product!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageSlideView.contentScaleMode = .scaleAspectFill
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProductDetailViewController.didTap))
        imageSlideView.addGestureRecognizer(gestureRecognizer)
        imageSlideView.setMediaInputs(medias: product.media)
    }
    @objc func didTap() {
        imageSlideView.presentFullScreenController(from: self)
    }
}
