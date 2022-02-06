//
//  ProductDetailViewModel.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import Foundation

protocol ProductDetailServiceProtocol {
    func fetchProductDetail(sku: String, completionHandler:@escaping(Product?, Error?)->())
}

class ProductDetailViewModel: BaseViewModel<ProductDetailViewModel.State> {
    
    enum State: StateChange {
            case fetching
            case succeeded
            case failed(errorMessage: String)
    }
    
    enum SectionModel {
        case slider(medias: [Media])
        case title(designer: String, name: String, price: Double)
        case amberPoints(amberPoint: Double)
        case description(title: String, description: String)
    }
    
    private(set) var sectionData:[SectionModel] = []
    private(set) var product: Product?
    
    let apiService: ProductDetailServiceProtocol
    
    init(apiService: ProductDetailServiceProtocol = ProductDetailService()) {
        self.apiService = apiService
    }
    
    func fetchProductList(sku: String?) {
        guard let sku = sku else {
            return
        }
        emit(change: .fetching)
        apiService.fetchProductDetail(sku: sku) { [weak self] productDetail, error in
            guard let productDetail = productDetail, error == nil else {
                self?.emit(change: .failed(errorMessage: error?.localizedDescription ?? ""))
                return
            }
            self?.product = productDetail
            self?.setupDataSource(product: productDetail)
        }
    }
    
    func setupDataSource(product: Product) {
        sectionData = []
        sectionData.append(.slider(medias: product.media))
        sectionData.append(.title(designer: product.designerCategoryName, name: product.name, price: product.price))
        sectionData.append(.amberPoints(amberPoint: product.amberPointsPerItem))
        for attribute in product.copyAttributes {
            sectionData.append(.description(title: attribute.name, description: attribute.value))
        }
        self.emit(change: .succeeded)
    }
}
