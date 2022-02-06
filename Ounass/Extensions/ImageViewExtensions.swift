//
//  ImageViewExtensions.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setListImage(imagePath:String?) {
        let baseURL = "https://ounass-prod1.atgcdn.ae/small_light(p=listing2x,of=jpg,q=70)/pub/media/catalog/product"
        //TODO: Add placeholder
        guard let imagePath = imagePath else { return }
        let combinedImageURL = baseURL + imagePath
        let imageURL = URL.init(string: combinedImageURL)
        self.kf.setImage(with:imageURL)
    }
}
