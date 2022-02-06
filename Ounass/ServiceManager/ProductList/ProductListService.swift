//
//  ProductListService.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import Foundation
import Alamofire

class ProductListService: ProductListServiceProtocol {
    func fetchProductList(page: Int, shouldClear: Bool, completionHandler: @escaping (ProductList?, Error?) -> ()) {
        let params = ["p":page]
        AF.request("https://www.ounass.ae/api/women/clothing", parameters: params).responseDecodable { (response:DataResponse<ProductList, AFError>) in
            switch response.result {
            case .success(let productList):
                completionHandler(productList, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
