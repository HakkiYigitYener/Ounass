//
//  ProductDetailViewController.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import UIKit
import ImageSlideshow

class ProductDetailViewController: UIViewController {
    @IBOutlet weak var productTableView: UITableView!
    let viewModel = ProductDetailViewModel()
    var productSku: String?
    var accordionStates: [Int:Bool] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleStateChanges()
        viewModel.fetchProductList(sku: productSku)
    }
    
    func setupUI() {
        productTableView.register(UINib.init(nibName: "ProductDetailSliderCell", bundle: nil), forCellReuseIdentifier: "ProductDetailSliderCell")
        productTableView.register(UINib.init(nibName: "ProductTitleCell", bundle: nil), forCellReuseIdentifier: "ProductTitleCell")
        productTableView.register(UINib.init(nibName: "ProductAmberPointCell", bundle: nil), forCellReuseIdentifier: "ProductAmberPointCell")
        productTableView.register(UINib.init(nibName: "ProductDetailAccordionHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "ProductDetailAccordionHeader")
        productTableView.register(UINib.init(nibName: "ProductDetailAccordionCell", bundle: nil), forCellReuseIdentifier: "ProductDetailAccordionCell")
        productTableView.register(UINib.init(nibName: "RelatedProductsCell", bundle: nil), forCellReuseIdentifier: "RelatedProductsCell")
    }
    
    private func handleStateChanges() {
        viewModel.addChangeHandler { [weak self] (state) in
            switch state {
            case .fetching:
                self?.showIndicator(message: "Loading...", animationType: .ballRotateChase)
            case .succeeded:
                self?.hideIndicator()
                self?.title = self?.viewModel.product?.name
                self?.productTableView.reloadData()
            case .failed(let errorMessage):
                self?.hideIndicator()
                self?.showAlertMessage(title: "Warning", message: errorMessage)
                self?.productTableView.reloadData()
            }
        }
    }
    
    func accordionState(for section: Int) -> Bool {
        if let state = accordionStates[section] {
            return state
        }
        else {
            accordionStates[section] = false
            return false
        }
    }
}

extension ProductDetailViewController: UITableViewDelegate {
    
}

extension ProductDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.sectionData[section] {
        case .description(title: _, description: _):
            return accordionState(for: section) ? 1 : 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.sectionData[indexPath.section] {
        case .slider(let medias):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailSliderCell", for: indexPath) as! ProductDetailSliderCell
            cell.setupCell(medias: medias, delegate: self)
            return cell
        case .title(let designer, let name, let price):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTitleCell", for: indexPath) as! ProductTitleCell
            cell.setupCell(designerName: designer,
                           productName: name,
                           price: price)
            return cell
        case .amberPoints(let amberPoint):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductAmberPointCell", for: indexPath) as! ProductAmberPointCell
            cell.setupCell(amberPoint: amberPoint)
            return cell
        case .description(title: _ , description: let description):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailAccordionCell", for: indexPath) as! ProductDetailAccordionCell
            cell.setupCell(descriptionText: description)
            return cell
        case .relatedProducts(products: let products):
            let cell = tableView.dequeueReusableCell(withIdentifier: "RelatedProductsCell", for: indexPath) as! RelatedProductsCell
            cell.setupCell(products: products)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch viewModel.sectionData[section] {
        case .description(title: let title , description: _):
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProductDetailAccordionHeader") as! ProductDetailAccordionHeader
            header.setupHeader(title: title, isOpen: accordionState(for: section), section: section, delegate: self)
            return header
        default:
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch viewModel.sectionData[section] {
        case .description(title: _, description: _):
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
}

extension ProductDetailViewController: ProductDetailSliderCellDelegate {
    func didTapSliderImage(imageSlideView: ImageSlideshow) {
        imageSlideView.presentFullScreenController(from: self)
    }
}

extension ProductDetailViewController: ProductDetailAccordionHeaderDelegate {
    func didAccordionHeaderTouched(section: Int) {
        accordionStates[section] = !accordionState(for: section)
        productTableView.reloadData()
    }
}
