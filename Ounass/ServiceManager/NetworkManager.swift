//
//  NetworkManager.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchProductDetail(sku:String, completionHandler:@escaping(Product?, Error?)->()) {
        let params = ["slug":sku]
        AF.request("https://www.ounass.ae/product/findbyslug", parameters: params).responseDecodable { (response:DataResponse<Product, AFError>) in
            switch response.result {
            case .success(let product):
                completionHandler(product, nil)
            case .failure(let error):
                print(error)
            }
        }
    }
}
