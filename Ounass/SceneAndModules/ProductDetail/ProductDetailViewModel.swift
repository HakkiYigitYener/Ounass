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
        case succeeded(title: String)
        case failed(errorMessage: String)
    }
    
    enum SectionModel {
        case slider(medias: [Media])
        case title(designer: String, name: String, price: Double)
        case amberPoints(amberPoint: Double)
        case description(title: String, description: String)
        case relatedProducts(products: [Product])
        case option(option: ConfigurableAttribute)
    }
    
    private(set) var sectionData:[SectionModel] = []
    
    private(set) var product: Product?
    
    var optionSelections: [String:ConfigurableAttributeOption] = [:]
    
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
            self?.setupDataSource(product: productDetail, isFromService: true)
        }
    }
    
    func setupDataSource(product: Product, isFromService: Bool = false) {
        sectionData = []
        
        let selectedVariant = getSelectedProductVariant()!
        sectionData.append(.slider(medias: selectedVariant.media))
        
        sectionData.append(.title(designer: selectedVariant.designerCategoryName, name: selectedVariant.name, price: selectedVariant.price))
        sectionData.append(.amberPoints(amberPoint: selectedVariant.amberPointsPerItem))
        for option in product.configurableAttributes {
            sectionData.append(.option(option: option))
            if option.options.count > 0, isFromService {
                optionSelections[option.code] = option.options[0]
            }
        }
        for attribute in product.copyAttributes {
            sectionData.append(.description(title: attribute.name, description: attribute.value))
        }
        if let relatedProductsDict = product.relatedProductsLookup, relatedProductsDict.count > 0 {
            let relatedProducts: [Product] = relatedProductsDict.compactMap { (key: String, value: Product) in
                return value
            }
            sectionData.append(.relatedProducts(products: relatedProducts))
        }
        self.emit(change: .succeeded(title: product.name))
    }
}
//MARK: Stock Calculations
extension ProductDetailViewModel {
    func getSelectedProductVariant() -> Product? {
        guard let sku = getSelectedProductVariantSku() else { return product }
        return product?.relatedProductsLookup?[sku]
    }

    func getSelectedProductVariantSku() -> String? {
        guard optionSelections.count > 0, let firstOption = optionSelections.first else {
            return nil
        }
        var baseList = firstOption.value.simpleProductSkus
        for selection in optionSelections {
            baseList = commonElements(baseList, selection.value.simpleProductSkus)
        }
        return baseList.first
    }

    func commonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> [T.Iterator.Element]
        where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
            var common: [T.Iterator.Element] = []

            for lhsItem in lhs {
                for rhsItem in rhs {
                    if lhsItem == rhsItem {
                        common.append(lhsItem)
                    }
                }
            }
            return common
    }
}


