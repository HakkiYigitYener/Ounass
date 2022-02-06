//
//  ProductDetailViewController.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import UIKit
import ImageSlideshow

class ProductDetailViewController: BaseViewController {
    @IBOutlet weak var productTableView: UITableView!
    private let viewModel = ProductDetailViewModel()
    var productSku: String?
    private var accordionStates: [Int:Bool] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleStateChanges()
        viewModel.fetchProductList(sku: productSku)
    }
    
    func setupUI() {
        
        let cells = [ ProductDetailSliderCell.self, ProductTitleCell.self, ProductAmberPointCell.self, ProductDetailAccordionCell.self, RelatedProductsCell.self ]
        productTableView.register(cellTypes: cells, bundle: Bundle.main)
        productTableView.register(UINib.init(nibName: "ProductDetailAccordionHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "ProductDetailAccordionHeader")
    }
    
    private func handleStateChanges() {
        viewModel.addChangeHandler { [weak self] (state) in
            switch state {
            case .fetching:
                self?.showIndicator(message: "Loading...", animationType: .ballRotateChase)
            case .succeeded(let title):
                self?.hideIndicator()
                self?.title = title
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ProductDetail":
            guard let vc = segue.destination as? ProductDetailViewController, let productSku = sender as? String else { return }
            vc.productSku = productSku
        default: break
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
            let cell = tableView.dequeueReusableCell(with: ProductDetailSliderCell.self, for: indexPath)
            cell.setupCell(medias: medias, delegate: self)
            return cell
        case .title(let designer, let name, let price):
            let cell = tableView.dequeueReusableCell(with: ProductTitleCell.self, for: indexPath)
            cell.setupCell(designerName: designer,
                           productName: name,
                           price: price)
            return cell
        case .amberPoints(let amberPoint):
            let cell = tableView.dequeueReusableCell(with: ProductAmberPointCell.self, for: indexPath)
            cell.setupCell(amberPoint: amberPoint)
            return cell
        case .description(title: _ , description: let description):
            let cell = tableView.dequeueReusableCell(with: ProductDetailAccordionCell.self, for: indexPath)
            cell.setupCell(descriptionText: description)
            return cell
        case .relatedProducts(products: let products):
            let cell = tableView.dequeueReusableCell(with: RelatedProductsCell.self, for: indexPath)
            cell.setupCell(products: products, delegate: self)
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

extension ProductDetailViewController: RelatedProductsCellDelegate {
    func relatedProductSelected(productSku: String) {
        self.performSegue(withIdentifier: "ProductDetail", sender: productSku)
    }
}
