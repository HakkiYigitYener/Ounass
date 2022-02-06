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
        let requestVariables = OunessApi.productList(page: page)
        AF.request(requestVariables.requestURL, parameters: requestVariables.params).responseDecodable { (response:DataResponse<ProductList, AFError>) in
            switch response.result {
            case .success(let productList):
                completionHandler(productList, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
