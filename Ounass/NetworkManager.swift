//
//  NetworkManager.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchProductDetail(sku:String, completionHandler:@escaping(Product)->()) {
        let params = ["slug":sku]
        AF.request("https://www.ounass.ae/product/findbyslug", parameters: params).responseDecodable { (response:DataResponse<Product, AFError>) in
            switch response.result {
            case .success(let product):
                completionHandler(product)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchProductList(page:Int = 0, completionHandler:@escaping(ProductList)->()) {
        let params = ["p":page]
        AF.request("https://www.ounass.ae/api/women/clothing", parameters: params).responseDecodable { (response:DataResponse<ProductList, AFError>) in
            switch response.result {
            case .success(let productList):
                completionHandler(productList)
            case .failure(let error):
                print(error)
            }
        }
    }
}
