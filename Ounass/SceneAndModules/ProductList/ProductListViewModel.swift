//
//  ProductListViewModel.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import UIKit

protocol ProductListServiceProtocol {
    func fetchProductList(page: Int, shouldClear: Bool, completionHandler:@escaping(ProductList?, Error?)->())
}

class ProductListViewModel: BaseViewModel<ProductListViewModel.State> {
    
    enum State: StateChange {
            case fetching
            case succeeded
            case failed(errorMessage: String)
        }
    
    private(set) var dataSource: [Product] = []
    private(set) var paginationData: Pagination?
    private(set) var isFetching = false
    
    let apiService: ProductListServiceProtocol
    
    init(apiService: ProductListServiceProtocol = ProductListService()) {
        self.apiService = apiService
    }
    
    func fetchProductList(page: Int = 0, shouldClear: Bool = false)  {
        isFetching = true
        emit(change: .fetching)
        apiService.fetchProductList(page: page, shouldClear: shouldClear) {productList, error in
            self.isFetching = false
            guard let productList = productList, error == nil else {
                self.emit(change: .failed(errorMessage: error?.localizedDescription ?? ""))
                return
            }
            if shouldClear {
                self.dataSource = productList.products
            }
            else {
                self.dataSource += productList.products
            }
            self.paginationData = productList.pagination
            self.emit(change: .succeeded)
        }
    }
}
