//
//  Endpoint.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import Foundation

/*
enum NetworkEnvironment {
    case production
}
*/
public enum OunessApi {
    case productList(page:Int)
    case productDetail(sku:String)
    
    var environmentBaseURL: String {
        return "https://www.ounass.ae/"
    }
    
    var path: String {
        switch self {
        case .productList(_):
            return "api/women/clothing"
        case .productDetail(_):
            return "product/findbyslug"
        }
    }
    
    var requestURL: String {
        return environmentBaseURL + path
    }
    
    var params: [String:Encodable] {
        switch self {
        case .productList(let page):
            return ["p":page]
        case .productDetail(let sku):
            return ["slug":sku]
        }
    }
}
