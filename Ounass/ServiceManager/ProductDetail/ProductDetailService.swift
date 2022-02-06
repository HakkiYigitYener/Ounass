//
//  ProductDetailService.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import Foundation
import Alamofire

class ProductDetailService: ProductDetailServiceProtocol {
    
    func fetchProductDetail(sku: String, completionHandler:@escaping(Product?, Error?)->()) {
        let requestVariables = OunessApi.productDetail(sku: sku)
        AF.request(requestVariables.requestURL, parameters: requestVariables.params).responseDecodable { (response:DataResponse<Product, AFError>) in
            switch response.result {
            case .success(let product):
                completionHandler(product, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
