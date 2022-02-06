//
//  ImageSlideShowExtensions.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import Foundation
import ImageSlideshow

extension ImageSlideshow {
    func setMediaInputs(medias: [Media]) {
        let baseImageURL = "https://ounass-prod1.atgcdn.ae/small_light(p=zoom,of=jpg,q=70)/pub/media/catalog/product"
        let imageSources: [KingfisherSource] = medias.compactMap { media in
            //TODO: Add placeholder
            guard let imageURL = URL(string: baseImageURL + media.src) else { return nil }
            return KingfisherSource.init(url: imageURL, placeholder: nil)
        }
        self.setImageInputs(imageSources)
    }
}
